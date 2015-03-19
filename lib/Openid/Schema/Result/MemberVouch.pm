use utf8;
package Openid::Schema::Result::MemberVouch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberVouch

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

=head1 TABLE: C<member_vouch>

=cut

__PACKAGE__->table("member_vouch");

=head1 ACCESSORS

=head2 vouchor

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 vouchee

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 trustgroup

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 comment

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 positive

  data_type: 'boolean'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "vouchor",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "vouchee",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "trustgroup",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "comment",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "positive",
  { data_type => "boolean", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</vouchor>

=item * L</vouchee>

=item * L</trustgroup>

=back

=cut

__PACKAGE__->set_primary_key("vouchor", "vouchee", "trustgroup");

=head1 RELATIONS

=head2 member_trustgroup_vouchee_trustgroup

Type: belongs_to

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->belongs_to(
  "member_trustgroup_vouchee_trustgroup",
  "Openid::Schema::Result::MemberTrustgroup",
  { member => "vouchee", trustgroup => "trustgroup" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 member_trustgroup_vouchor_trustgroup

Type: belongs_to

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->belongs_to(
  "member_trustgroup_vouchor_trustgroup",
  "Openid::Schema::Result::MemberTrustgroup",
  { member => "vouchor", trustgroup => "trustgroup" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 trustgroup

Type: belongs_to

Related object: L<Openid::Schema::Result::Trustgroup>

=cut

__PACKAGE__->belongs_to(
  "trustgroup",
  "Openid::Schema::Result::Trustgroup",
  { ident => "trustgroup" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 vouchee

Type: belongs_to

Related object: L<Openid::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "vouchee",
  "Openid::Schema::Result::Member",
  { ident => "vouchee" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 vouchor

Type: belongs_to

Related object: L<Openid::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "vouchor",
  "Openid::Schema::Result::Member",
  { ident => "vouchor" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t91uVoqZo9SMujO4VkLY8g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
