use utf8;
package Openid::Schema::Result::Member;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Openid::Schema::Result::Member

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

=head1 TABLE: C<member>

=cut

__PACKAGE__->table("member");

=head1 ACCESSORS

=head2 descr

  data_type: 'text'
  is_nullable: 0

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 im_info

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 tel_info

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 post_info

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 bio_info

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 entered

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 tz_info

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 sms_info

  data_type: 'text'
  is_nullable: 1

=head2 ident

  data_type: 'text'
  is_nullable: 0

=head2 airport

  data_type: 'text'
  is_nullable: 1

=head2 no_email

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 affiliation

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 hide_email

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 change_pw

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 furlough

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 activity

  data_type: 'timestamp'
  default_value: (now())::timestamp without time zone
  is_nullable: 0

=head2 uuid

  data_type: 'uuid'
  is_nullable: 0
  size: 16

=head2 sysadmin

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 passwd_chat

  data_type: 'text'
  is_nullable: 1

=head2 login_attempts

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 login_try_begin

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "descr",
  { data_type => "text", is_nullable => 0 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "im_info",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "tel_info",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "post_info",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "bio_info",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "entered",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "tz_info",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "sms_info",
  { data_type => "text", is_nullable => 1 },
  "ident",
  { data_type => "text", is_nullable => 0 },
  "airport",
  { data_type => "text", is_nullable => 1 },
  "no_email",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "affiliation",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "hide_email",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "change_pw",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "furlough",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "activity",
  {
    data_type     => "timestamp",
    default_value => \"(now())::timestamp without time zone",
    is_nullable   => 0,
  },
  "uuid",
  { data_type => "uuid", is_nullable => 0, size => 16 },
  "sysadmin",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "passwd_chat",
  { data_type => "text", is_nullable => 1 },
  "login_attempts",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "login_try_begin",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ident>

=back

=cut

__PACKAGE__->set_primary_key("ident");

=head1 UNIQUE CONSTRAINTS

=head2 C<member_uuid_key>

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->add_unique_constraint("member_uuid_key", ["uuid"]);

=head1 RELATIONS

=head2 audit_histories

Type: has_many

Related object: L<Openid::Schema::Result::AuditHistory>

=cut

__PACKAGE__->has_many(
  "audit_histories",
  "Openid::Schema::Result::AuditHistory",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_details

Type: has_many

Related object: L<Openid::Schema::Result::MemberDetail>

=cut

__PACKAGE__->has_many(
  "member_details",
  "Openid::Schema::Result::MemberDetail",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_emails

Type: has_many

Related object: L<Openid::Schema::Result::MemberEmail>

=cut

__PACKAGE__->has_many(
  "member_emails",
  "Openid::Schema::Result::MemberEmail",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_language_skills

Type: has_many

Related object: L<Openid::Schema::Result::MemberLanguageSkill>

=cut

__PACKAGE__->has_many(
  "member_language_skills",
  "Openid::Schema::Result::MemberLanguageSkill",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_mailinglists

Type: has_many

Related object: L<Openid::Schema::Result::MemberMailinglist>

=cut

__PACKAGE__->has_many(
  "member_mailinglists",
  "Openid::Schema::Result::MemberMailinglist",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_trustgroups

Type: has_many

Related object: L<Openid::Schema::Result::MemberTrustgroup>

=cut

__PACKAGE__->has_many(
  "member_trustgroups",
  "Openid::Schema::Result::MemberTrustgroup",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_vouch_vouchees

Type: has_many

Related object: L<Openid::Schema::Result::MemberVouch>

=cut

__PACKAGE__->has_many(
  "member_vouch_vouchees",
  "Openid::Schema::Result::MemberVouch",
  { "foreign.vouchee" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_vouch_vouchors

Type: has_many

Related object: L<Openid::Schema::Result::MemberVouch>

=cut

__PACKAGE__->has_many(
  "member_vouch_vouchors",
  "Openid::Schema::Result::MemberVouch",
  { "foreign.vouchor" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 second_factors

Type: has_many

Related object: L<Openid::Schema::Result::SecondFactor>

=cut

__PACKAGE__->has_many(
  "second_factors",
  "Openid::Schema::Result::SecondFactor",
  { "foreign.member" => "self.ident" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-12-10 01:20:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:P7UpbUjjauQ+Z5NTSu0TBg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
