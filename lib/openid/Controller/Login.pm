package openid::Controller::Login;
use Moose;
use namespace::autoclean;
use Net::OpenID::JanRain::CryptUtil qw( hmacSha1 );
use Net::OpenID::JanRain::Util qw( hashToPairs pairsToKV toBase64 fromBase64 );
use URI::Escape;
use feature qw(switch);


BEGIN { extends 'Catalyst::Controller'; }
    with 'Catalyst::TraitFor::Controller::reCAPTCHA';

=head1 NAME

openid::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;
	$c->forward('form');
}

sub form :Local {
  my ( $self, $c ) = @_;
	my $req = $c->request;
	my $cookie = $c->request->cookie($c->config->{session}->{cookie_name});
	my $sess_id = $cookie->{value}[0];

	if (defined($c->request->arguments->[0])){
		if (openid_functions::valid_username($c->request->arguments->[0])){
			$c->stash(login => $c->request->arguments->[0]);
		} else {
			$c->stash(alert => "Invalid format of username");
			$c->stash(alert_class => "warning");
		}
	}
	if (defined($c->request->param('openid.assoc_handle') )){
		if (!defined($c->stash->{assoc_valid})){
			my %assoc = openid_functions::assoc_load($c,$req->param('openid.assoc_handle'));
			my $result = openid_functions::assoc_valid($c,%assoc);
			if ($result ne "ok"){
				$c->stash( error => $result);
				$c->stash( template => 'templates/login/error.tt');
				return();
			}
			$c->stash( assoc => %assoc );
			$c->stash("openid.assoc_handle" => $c->request->param('openid.assoc_handle'));
		}
	}
	openid_functions::stage_login_form($c);

	#Check for existing session
	if (defined($sess_id)){
		#Validate Session string. 
		if (openid_functions::valid_username($sess_id)){
			my $session = $c->model('OT_DB::WebSession')->find($sess_id);
			if ($session->{'_column_data'}->{'a_session'}){
				my $D;
				eval($session->{'_column_data'}->{'a_session'});
				my $session_valid = 1;
				if ($D->{'_SESSION_ID'} ne $sess_id){
					$session_valid = 0;
					warn("Session id invalid: $cookie | ".$D->{'_SESSION_ID'});
				}
				if ($D->{'_SESSION_REMOTE_ADDR'} ne $c->request->address){
					$session_valid = 0;
					warn("Session ip mismatch: ".$c->request->address." | ".$D->{'_SESSION_REMOTE_ADDR'});
				}
				if (defined($D->{'~logged-in'}) and $D->{'~logged-in'} ne 't'){
					$session_valid = 0;
					warn("Session Not logged in");
				}
				my $now = time();
				if (($now - $D->{'_SESSION_ATIME'}) < 60){
					#Been less than a minute since our last session update.
				} elsif (($now - $D->{'_SESSION_ATIME'}) < $D->{'_SESSION_ETIME'}){
					#The db session is over a minute old. Let's update it.
				} else {
					$c->stash( alert => "Your session has expired.");
					$c->stash( alert_class => "notice");
					$session_valid = 0;
				}
				if ($session_valid){
					$c->log->info("User connected with valid session: ".$sess_id);
					$c->stash( session_valid => 1);
					$c->stash( username => $D->{'member'});
					$c->stash( session_data => $D);
					$c->forward('/login/submit');
					return();
				}
			} 
		} else {
			$c->stash( alert => "Invalid format of session cooike");
			$c->stash( alert_class => "error");
			$c->stash(template => 'templates/login/form.tt');
			$c->log->error("Invalid format of session cookie: ".$sess_id);
			openid_functions::increment_capcha($c);
		}
	}
	if (openid_functions::need_captcha($c)){
		$c->forward('captcha_get');
	}
	$c->response->header('Cache-Control' => 'no-cache');
        $c->stash(template => 'templates/login/form.tt');
}

sub submit :Path {
	my ( $self, $c ) = @_;
	my $req = $c->request;
	my $username;
	openid_functions::stage_login_form($c);

	if (defined($c->stash->{'session_valid'}) and $c->stash->{'session_valid'} == 1){
		$username = $c->stash->{'username'};
	} else {
		$username = $req->param('username');
		if(!$username){
			$c->stash( alert => "Username required.");
			$c->stash( alert_class => "error");
			$c->stash(template => 'templates/login/form.tt');
			openid_functions::increment_capcha($c);
			return();
		}
		$username =~ tr/A-Z/a-z/;
		$c->stash(username => $username);
		if(!openid_functions::valid_username($username)){
			$c->stash( alert => "Invalid format of username");
			$c->stash( alert_class => "warning");
			$c->stash(template => 'templates/login/form.tt');
			$c->log->error("Invalid format of username: ",$username);
			openid_functions::increment_capcha($c);
			return();
		}
	}

	#We can't write directly to however if $ENV{REMOTE_ADDR} is set first it will get set. 
	$ENV{REMOTE_ADDR} = $req->address(); 
	#TODO prevent corner case where member could be logged in via cookie while still needing capatcha.
	if (openid_functions::need_captcha($c)){
		if (!$c->forward('captcha_check') ) {
			$c->stash( alert => "Capatcha check failed" );
			$c->stash( alert_class => "error" );
			$c->log->error("Captcha check failed: ",$username);
			if (defined($req->param('openid.assoc_handle'))){
				my $assoc = openid_functions::assoc_load($c,$req->param('openid.assoc_handle'));
				my $result = openid_functions::assoc_valid($c,$assoc);
				if ($result ne "ok"){
					$c->stash( error => $result);
					$c->stash( template => 'templates/login/error.tt');
					$c->log->error("Association Invalid: ",$result);
					return();
				}
				$c->stash( assoc => $assoc );
				$c->stash( assoc_handle => $c->request->param('openid.assoc_handle'));
			}
			$c->forward('captcha_get');
			$c->stash(template => 'templates/login/form.tt');
			return();
		}
	}
	
	# No hints! default fail, unless we decide otherwise.
	# We will only report success or that the captcha is wrong.
	$c->stash( alert => 'Login incorrect' );
	$c->stash( alert_class => "error" );
	$c->stash( template => 'templates/login/form.tt' );
	$c->stash( login => $username );
	#TODO add other hashing functions to passwords
	#TODO someday we can be graceful about login attempts after a period of time. 
	if (defined($c->stash->{'session_valid'}) and $c->stash->{'session_valid'} == 1){
		
	} else {
		my @member  = $c->model('OT_DB::Member')->search({
			ident => $username,
			password => { '!=', undef },
			login_attempts => { '<', $c->config->{ops_t}->{max_login_attempt}}
		});
		if (@member){
			my @tfa = $c->model('OT_DB::SecondFactor')->search({
				member => $username,
				active => 't'
			});
			my $tfa_valid = 0;
			if(@tfa){
				foreach (@tfa){
					my $type = $_->{'_column_data'}->{'type'};
					my $key = $_->key;
					my $uuid = $_->uuid;
					my $counter = $_->counter;
					my $object = $_;
					given ($type) {
						when ("HOTP") {
							use Authen::OATH;
							my $oath = Authen::OATH->new();
							for( my $i = ($counter - 1); $i < ($counter + 3); $i++){
								if ($i){
									my $otp = $oath->hotp( $key, $i );
									if($otp eq $req->param('second_factor')){ 
										$tfa_valid = 1; 
									}
								}
							}
							if ($tfa_valid){
								$object->update(
									{counter => $counter + 1}
								 );
							}
						}
						when ("TOTP") {
							use Authen::OATH;
							my $oath = Authen::OATH->new();
							my $otp = $oath->totp( $key );
							if($otp eq $req->param('second_factor')){ $tfa_valid = 1; } 
						}
						when ("SOTP") {
							if($key eq Digest::SHA::sha256_hex($req->param('second_factor'))){
								$c->model('OT_DB::SecondFactor')->search({uuid => $uuid})->delete_all;
								$tfa_valid = 1;
							}	
						}
						default {
							$tfa_valid = 0;
							$c->stash( error => "Unknown second-factor type");
							$c->stash( template => 'templates/login/error.tt');
							$c->log->error("Unknown second-factor type: ".$type);
							return();
						}
					};
				}
			} elsif ($req->param('second_factor')) {
				#Second-factor is not configured, why did you populate it? 
				$c->log->info("Second factor populated, but not needed");
				$tfa_valid = 0;
			} else {
				$tfa_valid = 1;
			} 
			$c->stash(address => $req->address);
			$c->stash(method => $req->method);
			my $c_pw = crypt($req->param('password'),$member[0]->password);
			if (($c_pw eq $member[0]->password) and $tfa_valid){
				$c->log->info("Successful login for: ",$username);
				#TODO Move this to lib/openid.pm, needs to have access to $c or a raw dbh. 
				$c->config->{session}->{cgis_options} = {
					Handle => $c->model('OT_DB::WebSession')->result_source->storage->dbh,
					TableName => 'web_sessions'
				};
				$c->session_param('~logged-in','t');
				$c->session_param('member',$username);
				$c->session_param('test',$username);
				$c->session_param('uuid',$member[0]->uuid);
				$c->session_param('sysadmin',$member[0]->sysadmin);
				$c->session_param('change_pw',$member[0]->change_pw);
				$c->response->cookies->{'CGISESSID'} = { 
					domain => $c->config->{session}->{cookie_domain}, 
					value => $c->sessionid(),
					secure => $c->config->{session}->{cookie_httponly},
					httponly => $c->config->{session}->{cookie_secure}
				};
				$c->stash(session_valid => 1);
				openid_functions::reset_capcha($c);
				openid_functions::reset_member_attempt($c,$username);
			} else {
				openid_functions::increment_member_attempt($c,$username);
			}
		} else {
			$c->log->info("Login failed: ",$username);
			openid_functions::increment_capcha($c);
		}
	}
	if (defined($c->stash->{'session_valid'}) and $c->stash->{'session_valid'} == 1){
		if (defined($c->request->param('openid.return_to'))){
			if (defined($c->request->param('openid.sign')) and ($c->request->param('openid.sign') eq "false")){
				$c->response->redirect(uri_unescape($c->request->param('openid.return_to')),302);
				return();
			}
			
			my $append_string = "&openid.mode=id_res&openid.identity=";
			$append_string .= "https://openid.ops-trust.net/member/$username";

			my %sign_hash = (
			'mode' => "id_res",
			'identity' => "https://openid.ops-trust.net/member/$username",
			'return_to' => uri_unescape($req->param('openid.return_to')),
			'assoc_handle' => $req->param('openid.assoc_handle')
			);
			
			#my $token = uri_unescape(openid_functions::generate_sign_string(%sign_hash));
			my $token = openid_functions::generate_sign_string(%sign_hash);
			utf8::encode($token);
			#print "Token: |$token|\n";
			my $signed = openid_functions::generate_signed(%sign_hash);

			if (defined($req->param('openid.assoc_handle'))) {
				$append_string .= "&openid.assoc_handle=".$req->param('openid.assoc_handle');
				my $assoc =  $c->model('OT_DB::OpenidAssociation')->find($req->param('openid.assoc_handle'));
	
				my $a = fromBase64($assoc->{'_column_data'}->{'mac_key'});
				my $c = hmacSha1($a,$token);
				my $sig = uri_escape(toBase64($c));
				#print "SIG: $sig\n";
				$append_string .= "&openid.sig=$sig";
			} else {
				#TODO implement "dumb" mode.
				print "No Handle!\n";
			}
			$append_string .= "&openid.return_to=".uri_escape(uri_unescape($c->request->param('openid.return_to')));
			$append_string .= "&openid.signed=$signed";
			#TODO if return_to does not include a nonce or get varianble, swap first "&" of $append_string to "?"
			$c->response->redirect(uri_unescape($c->request->param('openid.return_to')).$append_string,302);
		} else {
			$c->response->redirect( $c->config->{ops_t}->{default_success} ,302 );
		}
		return(); #We were successful, no need to increment capacha count.
	}
}

sub end : ActionClass('RenderView::ErrorHandler') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
