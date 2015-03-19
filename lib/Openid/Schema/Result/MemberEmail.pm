use utf8;
package Openid::Schema::Result::MemberEmail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberEmail

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

=head1 TABLE: C<member_email>

=cut

__PACKAGE__->table("member_email");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 pgpkey_id

  data_type: 'text'
  is_nullable: 1

=head2 verified

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "pgpkey_id",
  { data_type => "text", is_nullable => 1 },
  "verified",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</member>

=item * L</email>

=back

=cut

__PACKAGE__->set_primary_key("member", "email");

=head1 UNIQUE CONSTRAINTS

=head2 C<member_email_email_key>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("member_email_email_key", ["email"]);

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

=head2 member_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->has_many(
  "member_trustgroups",
  "Openid::Schema::Result::MemberTrustgroup",
  { "foreign.email" => "self.email", "foreign.member" => "self.member" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VKQiFzTThuEI3RjYAodQMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
