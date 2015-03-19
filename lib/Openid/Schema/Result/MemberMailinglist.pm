use utf8;
package Openid::Schema::Result::MemberMailinglist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberMailinglist

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

=head1 TABLE: C<member_mailinglist>

=cut

__PACKAGE__->table("member_mailinglist");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 lhs

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 trustgroup

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 virtual

  data_type: 'boolean'
  default_value: false
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "lhs",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "trustgroup",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "virtual",
  {
    data_type      => "boolean",
    default_value  => \"false",
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</member>

=item * L</lhs>

=item * L</trustgroup>

=back

=cut

__PACKAGE__->set_primary_key("member", "lhs", "trustgroup");

=head1 RELATIONS

=head2 mailinglist

Type: belongs_to

Related object: L<Openid::Schema::Result::Mailinglist>

=cut

__PACKAGE__->belongs_to(
  "mailinglist",
  "Openid::Schema::Result::Mailinglist",
  { lhs => "lhs", trustgroup => "trustgroup", virtual => "virtual" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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

=head2 member_trustgroup

Type: belongs_to

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->belongs_to(
  "member_trustgroup",
  "Openid::Schema::Result::MemberTrustgroup",
  { member => "member", trustgroup => "trustgroup" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ly2MBXW3r/aqcWvfHxDTtQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
