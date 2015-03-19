package openid_functions;

sub create_assoc_handle(){
        my $uuid_bin;
        my $uuid;
        UUID::generate($uuid_bin);
        UUID::unparse($uuid_bin, $uuid);
        return($uuid);
}

sub generate_secret($){
        my ($assoc_type) = @_;
        my $shared_secret = create_assoc_handle();
        if($assoc_type eq "HMAC-SHA1"){
                #$shared_secret = substr($shared_secret,3,20);
		$shared_secret = Net::OpenID::JanRain::CryptUtil::randomString(20);
        } elsif ($assoc_type eq "HMAC-SHA256"){
                #$shared_secret = substr($shared_secret,1,32);
		$shared_secret = Net::OpenID::JanRain::CryptUtil::randomString(32);
        }
        return($shared_secret);
}

sub assoc_load($$){
        my ($c,$uuid) = @_;
        my @assoc =  $c->model('OT_DB::OpenidAssociation')->search({
                uuid  => $uuid
        });
        return $assoc[0]->{'_column_data'};
}

sub assoc_valid($$){
        my ($c,$assoc) = @_;
        if (defined($assoc->{'timestamp'})){
                my $timestamp = $assoc->{'timestamp'};
                use DateTime::Format::Pg;
                use DateTime::Format::Epoch;
                my $dt = DateTime::Format::Pg->parse_datetime( $timestamp );
                my $dte = DateTime->new( year => 1970, month => 1, day => 1 );
                my $formatter = DateTime::Format::Epoch->new(
                      epoch          => $dte,
                      unit           => 'seconds',
                      type           => 'int',    # or 'float', 'bigint'
                      #skip_leap_secondss => 1,
                      start_at       => 0,
                      local_epoch    => undef,
                  );
                my $assoc_time = $formatter->format_datetime($dt);
                my $delta = time() - $assoc_time;
                if ($delta > $c->config->{ops_t}->{association_expire}) {
                        return "Invalid Association: expired";
                } else {
                        return "ok";
                }
        } else {
                return "Invalid Association Key";
        }
}

sub stage_login_form($){
	use URI::Escape;
        my ($c) = @_;
        if (defined($c->request->param('openid.realm'))){
                $c->stash( realm => $c->request->param('openid.realm'));
        }
        if (defined($c->request->param('openid.trust_root'))){
                $c->stash( trust_root => $c->request->param('openid.trust_root'));
        }
        if (defined($c->request->param('openid.return_to'))){
                $c->stash( return_to => uri_escape(uri_unescape($c->request->param('openid.return_to'))));
        }
        if (defined($c->request->param('openid.sign'))){
                $c->stash( sign => $c->request->param('openid.sign'));
        }
}

sub valid_username($){
        my ($user) = @_;
        if ($user =~ m/^[a-z0-9]*$/) { return 1; }
        return 0;
}

sub need_capcha($){
        my ($c) = @_;
        my @ip_cache = $c->model('OT_DB::OpenidSourceCache')->search({
                src_ip => $c->request->address
        });

        if (defined($ip_cache[0])){
                my $count = $ip_cache[0]->{'_column_data'}->{'attempt_count'};
                if ($count > $c->config->{'ops_t'}->{'tries_before_cap'}){
                        return 1;
                }
        }
        return 0;
}

sub increment_capcha($) {
        my ($c) = @_;
        my @ip_cache = $c->model('OT_DB::OpenidSourceCache')->search({
                src_ip => $c->request->address
        });
        my $count = $ip_cache[0]->{'_column_data'}->{'attempt_count'};
        if (defined($count)){
                $ip_cache[0]->update(
                        {attempt_count => $count + 1},
                        {last_try => 'now()'}
                 );
        } else {
                $c->model('OT_DB::OpenidSourceCache')->create(
                        {src_ip => $c->request->address,
                        attempt_count => 1,
                        last_try => 'now()'}
                );
        }
	if (openid_functions::need_capcha($c)){
		$c->forward('captcha_get');
	}
}

sub reset_capcha($) {
	my ($c) = @_;
	my @ip_cache = $c->model('OT_DB::OpenidSourceCache')->search({
		src_ip => $c->request->address
	});
	if (defined($ip_cache[0])){
		$ip_cache[0]->update( {attempt_count => 0} );
	}
}

sub increment_member_attempt($$) {
        my ($c,$username) = @_;
        my @member = $c->model('OT_DB::Member')->search({
                ident => $username
        });
        my $count = $member[0]->{'_column_data'}->{'login_attempts'};
        $member[0]->update(
                {login_attempts => $count + 1,
                login_try_begin => 'now()'}
         );
}

sub reset_member_attempt($$) {
        my ($c,$username) = @_;
        my @member = $c->model('OT_DB::Member')->search({
                ident => $username
        });
        $member[0]->update( {login_attempts => 0} );
}

sub generate_sign_string(%) {
        my (%input) = @_;
	my $string = "";
	foreach $key (keys %input) {
		$string .= $key.":".$input{$key}."\n";
	}
	return($string);
}

sub generate_signed(%) {
        my (%input) = @_;
	my $string = join(",", keys %input);
	return($string);
}

1;

