use utf8;
package Openid::Schema::Result::SecondFactorType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::SecondFactorType

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

=head1 TABLE: C<second_factor_types>

=cut

__PACKAGE__->table("second_factor_types");

=head1 ACCESSORS

=head2 type

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("type", { data_type => "text", is_nullable => 0 });

=head1 UNIQUE CONSTRAINTS

=head2 C<second_factor_types_type_key>

=over 4

=item * L</type>

=back

=cut

__PACKAGE__->add_unique_constraint("second_factor_types_type_key", ["type"]);

=head1 RELATIONS

=head2 second_factors

Type: has_many

Related object: L<Openid::Schema::Result::SecondFactor>

=cut

__PACKAGE__->has_many(
  "second_factors",
  "Openid::Schema::Result::SecondFactor",
  { "foreign.type" => "self.type" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-12-10 01:20:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TMCNiEF4sQAjLRgiOi852w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
