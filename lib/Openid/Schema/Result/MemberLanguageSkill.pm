use utf8;
package Openid::Schema::Result::MemberLanguageSkill;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::MemberLanguageSkill

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

=head1 TABLE: C<member_language_skill>

=cut

__PACKAGE__->table("member_language_skill");

=head1 ACCESSORS

=head2 member

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 language

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 skill

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "language",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "skill",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<member_language_skill_member_language_idx>

=over 4

=item * L</member>

=item * L</language>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "member_language_skill_member_language_idx",
  ["member", "language"],
);

=head1 RELATIONS

=head2 language

Type: belongs_to

Related object: L<Openid::Schema::Result::Language>

=cut

__PACKAGE__->belongs_to(
  "language",
  "Openid::Schema::Result::Language",
  { iso_639_1 => "language" },
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

=head2 skill

Type: belongs_to

Related object: L<Openid::Schema::Result::LanguageSkill>

=cut

__PACKAGE__->belongs_to(
  "skill",
  "Openid::Schema::Result::LanguageSkill",
  { skill => "skill" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:H/nqPHUr9W0PGLzsP9G+rg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
