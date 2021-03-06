use utf8;
package Openid::Schema::Result::Mailinglist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::Mailinglist

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

=head1 TABLE: C<mailinglist>

=cut

__PACKAGE__->table("mailinglist");

=head1 ACCESSORS

=head2 lhs

  data_type: 'text'
  is_nullable: 0

=head2 descr

  data_type: 'text'
  is_nullable: 0

=head2 members_only

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 can_add_self

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 automatic

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 trustgroup

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 always_crypt

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 activity

  data_type: 'timestamp'
  is_nullable: 1

=head2 virtual

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "lhs",
  { data_type => "text", is_nullable => 0 },
  "descr",
  { data_type => "text", is_nullable => 0 },
  "members_only",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "can_add_self",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "automatic",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "trustgroup",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "always_crypt",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "activity",
  { data_type => "timestamp", is_nullable => 1 },
  "virtual",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</lhs>

=item * L</trustgroup>

=back

=cut

__PACKAGE__->set_primary_key("lhs", "trustgroup");

=head1 UNIQUE CONSTRAINTS

=head2 C<mailinglist_ukey>

=over 4

=item * L</lhs>

=item * L</trustgroup>

=item * L</virtual>

=back

=cut

__PACKAGE__->add_unique_constraint("mailinglist_ukey", ["lhs", "trustgroup", "virtual"]);

=head1 RELATIONS

=head2 member_mailinglists

Type: has_many

Related object: L<Openid::Schema::Result::MemberMailinglist>

=cut

__PACKAGE__->has_many(
  "member_mailinglists",
  "Openid::Schema::Result::MemberMailinglist",
  {
    "foreign.lhs"        => "self.lhs",
    "foreign.trustgroup" => "self.trustgroup",
    "foreign.virtual"    => "self.virtual",
  },
  { cascade_copy => 0, cascade_delete => 0 },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8Y3hfFPU3p7ZMIO1gFNuug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
