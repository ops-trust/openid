use utf8;
package Openid::Schema::Result::OpenidAssociation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::OpenidAssociation

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

=head1 TABLE: C<openid_associations>

=cut

__PACKAGE__->table("openid_associations");

=head1 ACCESSORS

=head2 uuid

  data_type: 'uuid'
  is_nullable: 0
  size: 16

=head2 assoc_type

  data_type: 'text'
  is_nullable: 0

=head2 session_type

  data_type: 'text'
  is_nullable: 0

=head2 mac_key

  data_type: 'text'
  is_nullable: 0

=head2 timestamp

  data_type: 'timestamp'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uuid",
  { data_type => "uuid", is_nullable => 0, size => 16 },
  "assoc_type",
  { data_type => "text", is_nullable => 0 },
  "session_type",
  { data_type => "text", is_nullable => 0 },
  "mac_key",
  { data_type => "text", is_nullable => 0 },
  "timestamp",
  { data_type => "timestamp", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->set_primary_key("uuid");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-23 03:47:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CVJxMckbxt4aksCtKBXwBA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
