use utf8;
package Openid::Schema::Result::MemberTrustgroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberTrustgroup

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

=head1 TABLE: C<member_trustgroup>

=cut

__PACKAGE__->table("member_trustgroup");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 trustgroup

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 admin

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 activity

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 state

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "trustgroup",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "admin",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "activity",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "state",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "email",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</member>

=item * L</trustgroup>

=back

=cut

__PACKAGE__->set_primary_key("member", "trustgroup");

=head1 RELATIONS

=head2 member

Type: belongs_to

Related object: L<Openid::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "member",
  "Openid::Schema::Result::Member",
  { ident => "member" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 member_email

Type: belongs_to

Related object: L<Openid::Schema::Result::MemberEmail>

=cut

__PACKAGE__->belongs_to(
  "member_email",
  "Openid::Schema::Result::MemberEmail",
  { email => "email", member => "member" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 member_mailinglists

Type: has_many

Related object: L<Openid::Schema::Result::MemberMailinglist>

=cut

__PACKAGE__->has_many(
  "member_mailinglists",
  "Openid::Schema::Result::MemberMailinglist",
  {
    "foreign.member"     => "self.member",
    "foreign.trustgroup" => "self.trustgroup",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_vouch_vouchee_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberVouch>

=cut

__PACKAGE__->has_many(
  "member_vouch_vouchee_trustgroups",
  "Openid::Schema::Result::MemberVouch",
  {
    "foreign.trustgroup" => "self.trustgroup",
    "foreign.vouchee"    => "self.member",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_vouch_vouchor_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberVouch>

=cut

__PACKAGE__->has_many(
  "member_vouch_vouchor_trustgroups",
  "Openid::Schema::Result::MemberVouch",
  {
    "foreign.trustgroup" => "self.trustgroup",
    "foreign.vouchor"    => "self.member",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 state

Type: belongs_to

Related object: L<Openid::Schema::Result::MemberState>

=cut

__PACKAGE__->belongs_to(
  "state",
  "Openid::Schema::Result::MemberState",
  { ident => "state" },
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


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bz3ga5sqNYLnS2NGzB9ZzQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
