package openid::Controller::Root;
use Moose;
use namespace::autoclean;
use UUID;
use MIME::Base64;
use Crypt::DH;
use Digest::SHA qw( sha1 sha256 sha1_hex sha256_hex );
use Net::OpenID::JanRain::Association;
use Net::OpenID::JanRain::Util qw( hashToPairs pairsToKV toBase64 fromBase64 );
use Net::OpenID::JanRain::CryptUtil qw( randomString bytesToNum numToBase64 numToBytes base64ToNum);
use Math::BigInt lib => 'GMP';
use feature qw(switch);
use Net::OpenID::Common;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

openid::Controller::Root - Root Controller for openid

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;
        my $cookie = $c->request->cookie($c->config->{session}->{cookie_name});
	if ($cookie){
		#I've been here before, take me to the login form. 
		$c->forward('login/form');
		return;
	} 
	$c->response->headers->header( 'X-XRDS-Location' => "https://openid.ops-trust.net/xrds/member" );
	$c->stash(head_links => '<link rel="openid2.provider" href="https://openid.ops-trust.net/server"/>
<link rel="openid2.local_id" href="https://openid.ops-trust.net/member/"/>
<link rel="openid.server" href="https://openid.ops-trust.net/server"/>
<link rel="openid.delegate" href="https://openid.ops-trust.net/member/" />');
	$c->stash( template => 'templates/about.tt') ;
}

sub robots :Path('robots.txt') {
	my ( $self, $c ) = @_;
	$c->stash(no_wrapper => 1);
	$c->stash(template => 'templates/robots.tt');
}

sub about :Global {
	my ( $self, $c ) = @_;
	$c->stash(template => 'templates/about.tt');
}

sub server :Global {
	my ( $self, $c ) = @_;
	my $req = $c->request;

	my $session_type = '';
	my $assoc_type = '';
	my $openid_version = '';
	my $shared_secret = '';

	if (!defined($req->param('openid.mode'))){
		$c->stash( ns => "http://openid.net/signon/1.1");
		$c->stash( error => "No mode defined");
		$c->stash( template => 'templates/server_error.tt');
		$c->log->error("Openid request arrived without openid.mode set.");
		return();
	} elsif ($req->param('openid.mode') eq 'associate' and $req->method eq 'POST'){
		$c->log->info("new association requested by:",$c->request->address);
		$c->stash(no_wrapper => 1);
		$c->stash(assoc_expire  => $c->config->{ops_t}->{association_expire});
		if (defined($req->param('openid.ns'))) {
			if ($req->param('openid.ns') eq "http://openid.net/signon/1.1"){
				$c->stash( ns => "http://openid.net/signon/1.1");
				$openid_version = "1.1";
			} elsif ($req->param('openid.ns') eq "http://specs.openid.net/auth/2.0"){
				$c->stash( ns => "http://specs.openid.net/auth/2.0");
				$openid_version = "2.0";
			} else {
				$c->stash( error => "NS not known.");
				$c->stash( template => 'templates/server_error.tt');
				$c->log->error("Unknown openid.ns value provided:",$req->param('openid.ns'));
				return();
			}
		} else {
			$c->stash( ns => "http://openid.net/signon/1.1");
			$openid_version = "1.1";
		}
		$c->log->debug("openid.ns: $openid_version");
		if (defined($req->param('openid.session_type'))) {
			given ($req->param('openid.session_type')) {		
				when ("no-encryption") {
					$c->stash( session_type => "no-encryption");
					$session_type = "no-encryption";
				}
				when ("DH-SHA1") {
					$c->stash( session_type => "DH-SHA1");
					$session_type = "DH-SHA1";
				}
				when ("DH-SHA256") {
					$c->stash( session_type => "DH-SHA256");
					$session_type = "DH-SHA256";
				}
				default {
					$c->stash( error => "session_type set to unknown value: ".$req->param('openid.session_type'));
					$c->stash( template => 'templates/server_error.tt');
					$c->log->error("Unknown openid.session_type value provided:",$req->param('openid.session_type'));
					return();
				}
			};
		} else {
			$c->stash( error => "session_type not set (required).");
			$c->stash( template => 'templates/server_error.tt');
			$c->log->error("openid.session_type required but not provided.");
			return();
		}
		$c->log->debug("openid.session_type: $session_type");
		if (defined($req->param('openid.assoc_type'))) {
			given ($req->param('openid.assoc_type')) {
				#HMAC-SHA1 - 160 bit key length ([RFC2104] and [RFC3174])
                                when ("HMAC-SHA1") {
                                        $c->stash( assoc_type => "HMAC-SHA1");
                                        $assoc_type = "HMAC-SHA1";
                                }
				#HMAC-SHA256 - 256 bit key length ([RFC2104] and [FIPS180‑2]
                                when ("HMAC-SHA256") {
                                        $c->stash( assoc_type => "HMAC-SHA256");
                                        $assoc_type = "HMAC-SHA256";
                                }
                                default {
                                        $c->stash( error => "assoc_type set to unknown value: ".$req->param('openid.assoc_type'));
                                        $c->stash( template => 'templates/server_error.tt');
					$c->log->error("Unknown openid.assoc_type value provided:",$req->param('openid.assoc_type'));
                                        return();
                                }
                        };
		} else {
			$c->stash( error => "assoc_type not set (required).");
			$c->stash( template => 'templates/server_error.tt');
			$c->log->error("openid.assoc_type required but not provided.");
			return();
		}
		$c->log->debug("openid.assoc_type: $assoc_type");
		#Assign the association handle. 
		my $assoc_handle = openid_functions::create_assoc_handle();
		$c->stash( assoc_handle => $assoc_handle);
		$c->log->debug("Assoc Handle: $assoc_handle");
		my $secret = openid_functions::generate_secret($assoc_type);

		if ($session_type eq "no-encryption"){
			$shared_secret = openid_functions::generate_secret($assoc_type);
			$c->stash( mac_key => toBase64($shared_secret));
			$c->stash( template => 'templates/mode_associate.tt');
		} else {
			my $dh = OpenID::util::get_dh();
			my $cpub = _arg2bi($req->param("openid.dh_consumer_public"));
			$shared_secret = $dh->compute_secret($cpub);
			my $enc_mac_key =  '';
			if ($assoc_type eq "HMAC-SHA1"){
				$enc_mac_key = toBase64($secret ^ sha1(_bi2bytes($shared_secret)));
			} else {
				$enc_mac_key = toBase64($secret ^ sha256(_bi2bytes($shared_secret)));
			}	
			$c->log->debug("MAC Key: $enc_mac_key");
			$c->stash( dh_server_public => OpenID::util::int2arg($dh->pub_key));
			$c->stash( enc_mac_key => $enc_mac_key);
			$c->stash( template => 'templates/mode_associate_enc.tt');
		}
		#Write Association to the DB.
		$c->model('OT_DB::OpenidAssociation')->create({
			uuid  => $assoc_handle,
			assoc_type => $assoc_type,
			session_type => $session_type,
			mac_key => toBase64($secret),
			timestamp => 'now()'
		});
	} elsif ($req->param('openid.mode') eq 'associate'){
		$c->stash( error => "Mode set to associate, but not a POST request.");
		$c->stash( template => 'templates/server_error.tt');
		return();
        } elsif ($req->param('openid.mode') eq 'checkid_setup') {
		$c->log->info("checkid_setup requested by:",$c->request->address);
		$c->stash(assoc_expire  => $c->config->{ops_t}->{association_expire});
                if (defined($req->param('openid.return_to'))){
			if (openid_functions::assoc_valid($c,$req->param('openid.assoc_handle'))){
				my $assoc = openid_functions::assoc_load($c,$req->param('openid.assoc_handle'));
				my $result = openid_functions::assoc_valid($c,$assoc);
				if ($result ne "ok"){
					$c->stash( error => $result);
					$c->stash( template => 'templates/login/error.tt');
					return();
				}
				$c->stash( assoc => $assoc );
				$c->stash( assoc_handle => $c->request->param('openid.assoc_handle'));
                        }

		        openid_functions::stage_login_form($c);

                        my $login = $req->param('openid.identity');
                        $login =~ s/.*\/([^\/]+)$/$1/;
                        if ($login =~ m/openid\.ops-trust\.net/){
                                $login = "";
                        } elsif ($login eq "member"){
                                $login = "";
                        }
			$c->stash( assoc_valid => 1 );
                        $c->stash( login => $login);
			$c->forward('login/form');
                } else {
			$c->log->error("No return_to variable set");
                        $c->stash( error => "No return_to varible set, this login won't get far.");
                        $c->stash( tenplate => 'templates/login/error.tt');
                }
        }
}

sub server_1 :Global {
	my ( $self, $c ) = @_;
	my $req = $c->request;
	if (defined($req->param('openid.assoc_handle'))){
		my $assoc = openid_functions::assoc_load($c,$req->param('openid.assoc_handle'));
		#use Data::Dumper;
		#print Dumper $assoc;
		my $result = openid_functions::assoc_valid($c,$assoc);
		if ($result ne "ok"){
			$c->stash( error => $result);
			$c->stash( template => 'templates/login/error.tt');
			return();
		}
		$c->stash( assoc => $assoc );
		$c->stash( assoc_handle => $c->request->param('openid.assoc_handle'));
	}
	if ($req->param('openid.mode') eq 'check_authentication' and $req->method eq 'POST'){
                $c->stash(no_wrapper => 1);
		#TODO Validate signature
		$c->stash(result => "true");
	}
	$c->stash(template => 'templates/login/submit.tt');
}

sub xrds : Path('/xrds') Args(1) {
        my ( $self, $c, $member_id ) = @_;
	$c->response->headers->header( 'Content-Type' => "application/xrds+xml; charset=UTF-8");
	$c->stash(username => $member_id);
	$c->stash(openid_url_prefix => "https://openid.ops-trust.net/");
	$c->stash(no_wrapper => 1);
	$c->stash( template => 'templates/xrds.tt');
}

sub member : Path('/member') Args(1) {
        my ( $self, $c, $member_id ) = @_;
	$c->stash(member => $member_id);
	my @member  = $c->model('OT_DB::Member')->search({
		ident => $member_id,
		password => { '!=', undef }
	});
	if (openid_functions::valid_username($member_id)){
		$c->stash(head_links => '<link rel="openid2.provider" href="https://openid.ops-trust.net/server"/>
	<link rel="openid2.local_id" href="https://openid.ops-trust.net/member/'.$member_id.'"/>
	<link rel="openid.server" href="https://openid.ops-trust.net/server"/>
	<link rel="openid.delegate" href="https://openid.ops-trust.net/member/'.$member_id.'" />');
	} else {
		$c->stash( alert => "Invalid format of username");
		$c->stash( alert_class => "warning");
		$c->forward("/index");
	}
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
	my ( $self, $c ) = @_;
	if ( $c->request->path eq '.well-known/webfinger' ){
		$c->stash(no_wrapper => 1);
        	$c->response->headers->header( 'Content-Type' => "application/jrd+json");
		$c->stash(resource => $c->request->param('resource'));
		$c->stash(rel => $c->request->param('rel'));
		$c->stash(template => 'templates/well-known.tt');
	} elsif ($c->request->path =~ m/\.well-known\/openid-configuration/ ){
		$c->stash(no_wrapper => 1);
        	$c->response->headers->header( 'Content-Type' => "application/json");
		$c->stash(template => 'templates/openid-configuration.tt');
	} else {
		$c->response->body( 'Page not found' );
		$c->response->status(404);
	}
}

=head2 end

Attempt to render a view, if needed.

=cut

#sub end : ActionClass('RenderView') {}
sub end : ActionClass('RenderView::ErrorHandler') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub _bi2bytes {
    my $bigint = Math::BigInt->new(shift);
    die "Can't deal with negative numbers" if $bigint->is_negative;

    my $bits = $bigint->as_bin;
    die unless $bits =~ s/^0b//;

    # prepend zeros to round to byte boundary, or to unset high bit
    my $prepend = (8 - length($bits) % 8) || ($bits =~ /^1/ ? 8 : 0);
    $bits = ("0" x $prepend) . $bits if $prepend;

    return pack("B*", $bits);
}

sub _bytes2bi {
    return Math::BigInt->new("0b" . unpack("B*", $_[0]));
}

sub _arg2bi {
    return undef unless defined $_[0] && $_[0] ne "";
    # don't acccept base-64 encoded numbers over 700 bytes.  which means
    # those over 4200 bits.
    return Math::BigInt->new("0") if length($_[0]) > 700;
    return _bytes2bi(MIME::Base64::decode_base64($_[0]));
}


__PACKAGE__->meta->make_immutable;

1;
