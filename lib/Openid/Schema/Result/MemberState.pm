use utf8;
package Openid::Schema::Result::MemberState;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberState

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

=head1 TABLE: C<member_state>

=cut

__PACKAGE__->table("member_state");

=head1 ACCESSORS

=head2 ident

  data_type: 'text'
  is_nullable: 0

=head2 can_login

  data_type: 'boolean'
  is_nullable: 0

=head2 can_see

  data_type: 'boolean'
  is_nullable: 0

=head2 can_send

  data_type: 'boolean'
  is_nullable: 0

=head2 can_recv

  data_type: 'boolean'
  is_nullable: 0

=head2 blocked

  data_type: 'boolean'
  is_nullable: 0

=head2 hidden

  data_type: 'boolean'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ident",
  { data_type => "text", is_nullable => 0 },
  "can_login",
  { data_type => "boolean", is_nullable => 0 },
  "can_see",
  { data_type => "boolean", is_nullable => 0 },
  "can_send",
  { data_type => "boolean", is_nullable => 0 },
  "can_recv",
  { data_type => "boolean", is_nullable => 0 },
  "blocked",
  { data_type => "boolean", is_nullable => 0 },
  "hidden",
  { data_type => "boolean", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ident>

=back

=cut

__PACKAGE__->set_primary_key("ident");

=head1 RELATIONS

=head2 member_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->has_many(
  "member_trustgroups",
  "Openid::Schema::Result::MemberTrustgroup",
  { "foreign.state" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+w9IWLRIB8dg8GKBkyBfyQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
