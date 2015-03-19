use utf8;
package Openid::Schema::Result::AuditHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::AuditHistory

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

=head1 TABLE: C<audit_history>

=cut

__PACKAGE__->table("audit_history");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 what

  data_type: 'text'
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "what",
  { data_type => "text", is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
);

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


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OlxZ7yUHVNxou67kb8+8nw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
