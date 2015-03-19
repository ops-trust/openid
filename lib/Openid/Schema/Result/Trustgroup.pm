use utf8;
package Openid::Schema::Result::Trustgroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::Trustgroup

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

=head1 TABLE: C<trustgroup>

=cut

__PACKAGE__->table("trustgroup");

=head1 ACCESSORS

=head2 ident

  data_type: 'text'
  is_nullable: 0

=head2 descr

  data_type: 'text'
  is_nullable: 0

=head2 shortname

  data_type: 'text'
  is_nullable: 0

=head2 min_invouch

  data_type: 'integer'
  is_nullable: 0

=head2 pgp_required

  data_type: 'boolean'
  is_nullable: 0

=head2 please_vouch

  data_type: 'boolean'
  is_nullable: 0

=head2 vouch_adminonly

  data_type: 'boolean'
  is_nullable: 0

=head2 min_outvouch

  data_type: 'integer'
  is_nullable: 0

=head2 max_inactivity

  data_type: 'interval'
  is_nullable: 0

=head2 can_time_out

  data_type: 'boolean'
  is_nullable: 0

=head2 max_vouchdays

  data_type: 'integer'
  is_nullable: 0

=head2 idle_guard

  data_type: 'interval'
  is_nullable: 0

=head2 nom_enabled

  data_type: 'boolean'
  is_nullable: 0

=head2 target_invouch

  data_type: 'integer'
  is_nullable: 0

=head2 has_wiki

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ident",
  { data_type => "text", is_nullable => 0 },
  "descr",
  { data_type => "text", is_nullable => 0 },
  "shortname",
  { data_type => "text", is_nullable => 0 },
  "min_invouch",
  { data_type => "integer", is_nullable => 0 },
  "pgp_required",
  { data_type => "boolean", is_nullable => 0 },
  "please_vouch",
  { data_type => "boolean", is_nullable => 0 },
  "vouch_adminonly",
  { data_type => "boolean", is_nullable => 0 },
  "min_outvouch",
  { data_type => "integer", is_nullable => 0 },
  "max_inactivity",
  { data_type => "interval", is_nullable => 0 },
  "can_time_out",
  { data_type => "boolean", is_nullable => 0 },
  "max_vouchdays",
  { data_type => "integer", is_nullable => 0 },
  "idle_guard",
  { data_type => "interval", is_nullable => 0 },
  "nom_enabled",
  { data_type => "boolean", is_nullable => 0 },
  "target_invouch",
  { data_type => "integer", is_nullable => 0 },
  "has_wiki",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ident>

=back

=cut

__PACKAGE__->set_primary_key("ident");

=head1 RELATIONS

=head2 attestations

Type: has_many

Related object: L<Openid::Schema::Result::Attestation>

=cut

__PACKAGE__->has_many(
  "attestations",
  "Openid::Schema::Result::Attestation",
  { "foreign.trustgroup" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 mailinglists

Type: has_many

Related object: L<Openid::Schema::Result::Mailinglist>

=cut

__PACKAGE__->has_many(
  "mailinglists",
  "Openid::Schema::Result::Mailinglist",
  { "foreign.trustgroup" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_mailinglists

Type: has_many

Related object: L<Openid::Schema::Result::MemberMailinglist>

=cut

__PACKAGE__->has_many(
  "member_mailinglists",
  "Openid::Schema::Result::MemberMailinglist",
  { "foreign.trustgroup" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->has_many(
  "member_trustgroups",
  "Openid::Schema::Result::MemberTrustgroup",
  { "foreign.trustgroup" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_vouches

Type: has_many

Related object: L<Openid::Schema::Result::MemberVouch>

=cut

__PACKAGE__->has_many(
  "member_vouches",
  "Openid::Schema::Result::MemberVouch",
  { "foreign.trustgroup" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hWvtnXx3Sy9KDNqHO+H8wQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
