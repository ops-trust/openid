use utf8;
package Openid::Schema::Result::SecondFactor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::SecondFactor

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

=head1 TABLE: C<second_factors>

=cut

__PACKAGE__->table("second_factors");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 type

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 active

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 counter

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 key

  data_type: 'text'
  is_nullable: 1

=head2 uuid

  data_type: 'uuid'
  is_nullable: 0
  size: 16

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "type",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "active",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "counter",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "key",
  { data_type => "text", is_nullable => 1 },
  "uuid",
  { data_type => "uuid", is_nullable => 0, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");

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

=head2 type

Type: belongs_to

Related object: L<Openid::Schema::Result::SecondFactorType>

=cut

__PACKAGE__->belongs_to(
  "type",
  "Openid::Schema::Result::SecondFactorType",
  { type => "type" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-12-10 04:30:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AOiDYbe7WtjhUaUv8yqXVg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
