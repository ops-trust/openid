use utf8;
package Openid::Schema::Result::Language;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::Language

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

=head1 TABLE: C<languages>

=cut

__PACKAGE__->table("languages");

=head1 ACCESSORS

=head2 iso_639_1

  data_type: 'varchar'
  is_nullable: 0
  size: 2

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "iso_639_1",
  { data_type => "varchar", is_nullable => 0, size => 2 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<languages_iso_639_1_key>

=over 4

=item * L</iso_639_1>

=back

=cut

__PACKAGE__->add_unique_constraint("languages_iso_639_1_key", ["iso_639_1"]);

=head2 C<languages_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("languages_name_key", ["name"]);

=head1 RELATIONS

=head2 member_language_skills

Type: has_many

Related object: L<Openid::Schema::Result::MemberLanguageSkill>

=cut

__PACKAGE__->has_many(
  "member_language_skills",
  "Openid::Schema::Result::MemberLanguageSkill",
  { "foreign.language" => "self.iso_639_1" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r7QM44I45Js6e3LbOOHa1w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
