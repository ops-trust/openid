use utf8;
package Openid::Schema::Result::MemberDetailType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberDetailType

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

=head1 TABLE: C<member_detail_types>

=cut

__PACKAGE__->table("member_detail_types");

=head1 ACCESSORS

=head2 type

  data_type: 'text'
  is_nullable: 0

=head2 display_name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "type",
  { data_type => "text", is_nullable => 0 },
  "display_name",
  { data_type => "text", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<member_detail_types_display_name_idx>

=over 4

=item * L</display_name>

=back

=cut

__PACKAGE__->add_unique_constraint("member_detail_types_display_name_idx", ["display_name"]);

=head2 C<member_detail_types_type_key>

=over 4

=item * L</type>

=back

=cut

__PACKAGE__->add_unique_constraint("member_detail_types_type_key", ["type"]);

=head1 RELATIONS

=head2 member_details

Type: has_many

Related object: L<Openid::Schema::Result::MemberDetail>

=cut

__PACKAGE__->has_many(
  "member_details",
  "Openid::Schema::Result::MemberDetail",
  { "foreign.type" => "self.type" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m2XFfZqdOgYaFH2k2E66Fw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
