package openid::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    WRAPPER => 'wrapper.tt2',
    render_die => 1,
);

=head1 NAME

openid::View::HTML - TT View for openid

=head1 DESCRIPTION

TT View for openid.

=head1 SEE ALSO

L<openid>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
