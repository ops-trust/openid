use utf8;
package Openid::Schema::Result::Freemail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::Freemail

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<freemail>

=cut

__PACKAGE__->table("freemail");

=head1 ACCESSORS

=head2 ident

  data_type: 'text'
  is_nullable: 0

=head2 descr

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ident",
  { data_type => "text", is_nullable => 0 },
  "descr",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ident>

=back

=cut

__PACKAGE__->set_primary_key("ident");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:omPD2BKX/MySPL0Zucz56A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
