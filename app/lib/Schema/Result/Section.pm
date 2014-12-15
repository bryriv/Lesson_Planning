use utf8;
package Schema::Result::Section;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Section

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<section>

=cut

__PACKAGE__->table("section");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 plan_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 content

  data_type: 'text'
  is_nullable: 0

=head2 enum_section_type_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "plan_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "content",
  { data_type => "text", is_nullable => 0 },
  "enum_section_type_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 enum_section_type

Type: belongs_to

Related object: L<Schema::Result::EnumSectionType>

=cut

__PACKAGE__->belongs_to(
  "enum_section_type",
  "Schema::Result::EnumSectionType",
  { id => "enum_section_type_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 plan

Type: belongs_to

Related object: L<Schema::Result::Plan>

=cut

__PACKAGE__->belongs_to(
  "plan",
  "Schema::Result::Plan",
  { id => "plan_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mYmU3i4UQgBiYC7ZhxyLNw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
