use utf8;
package Openid::Schema::Result::OpenidSourceCache;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::OpenidSourceCache

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

=head1 TABLE: C<openid_source_cache>

=cut

__PACKAGE__->table("openid_source_cache");

=head1 ACCESSORS

=head2 src_ip

  data_type: 'inet'
  is_nullable: 0

=head2 last_try

  data_type: 'timestamp'
  is_nullable: 0

=head2 attempt_count

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "src_ip",
  { data_type => "inet", is_nullable => 0 },
  "last_try",
  { data_type => "timestamp", is_nullable => 0 },
  "attempt_count",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</src_ip>

=back

=cut

__PACKAGE__->set_primary_key("src_ip");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-30 01:44:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ul+gxBZIg7RE7BbXQG99Ag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
