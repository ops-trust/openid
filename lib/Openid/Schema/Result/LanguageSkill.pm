use utf8;
package Openid::Schema::Result::LanguageSkill;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::LanguageSkill

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

=head1 TABLE: C<language_skill>

=cut

__PACKAGE__->table("language_skill");

=head1 ACCESSORS

=head2 skill

  data_type: 'text'
  is_nullable: 0

=head2 seq

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "skill",
  { data_type => "text", is_nullable => 0 },
  "seq",
  { data_type => "integer", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<language_skill_seq_key>

=over 4

=item * L</seq>

=back

=cut

__PACKAGE__->add_unique_constraint("language_skill_seq_key", ["seq"]);

=head2 C<language_skill_skill_key>

=over 4

=item * L</skill>

=back

=cut

__PACKAGE__->add_unique_constraint("language_skill_skill_key", ["skill"]);

=head1 RELATIONS

=head2 member_language_skills

Type: has_many

Related object: L<Openid::Schema::Result::MemberLanguageSkill>

=cut

__PACKAGE__->has_many(
  "member_language_skills",
  "Openid::Schema::Result::MemberLanguageSkill",
  { "foreign.skill" => "self.skill" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-11-04 02:50:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5Rjyd73hrbekIeCdGqxFVg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
