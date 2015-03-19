package openid::View::Email::Template;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
    stash_key       => 'email',
    template_prefix => 'email/',
    default => {
                # Defines the default content type (mime type). Mandatory
                content_type => 'text/plain',
                # Defines the default charset for every MIME part with the 
                # content type text.
                # According to RFC2049 a MIME part without a charset should
                # be treated as US-ASCII by the mail client.
                # If the charset is not set it won't be set for all MIME parts
                # without an overridden one.
                # Default: none
                charset => 'utf-8'
            },
            sender => {
                # if mailer doesn't start with Email::Sender::Simple::Transport::,
                # then this is prepended.
                mailer => 'SMTP',
                # mailer_args is passed directly into Email::Sender::Simple 
                mailer_args => {
                    host     => 'localhost', # defaults to localhost
                    Host     => 'localhost', # defaults to localhost
                    #sasl_username => 'sasl_username',
                    #sasl_password => 'sasl_password',
            }
	}
);

=head1 NAME

openid::View::Email::Template - Templated Email View for openid

=head1 DESCRIPTION

View for sending template-generated email from openid. 

=head1 AUTHOR

root

=head1 SEE ALSO

L<openid>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
