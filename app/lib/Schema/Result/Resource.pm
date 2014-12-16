use utf8;
package Schema::Result::Resource;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Resource

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<resource>

=cut

__PACKAGE__->table("resource");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 plan_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 enum_resource_type_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 complete

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 notes

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "plan_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "enum_resource_type_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "complete",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "notes",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 enum_resource_type

Type: belongs_to

Related object: L<Schema::Result::EnumResourceType>

=cut

__PACKAGE__->belongs_to(
  "enum_resource_type",
  "Schema::Result::EnumResourceType",
  { id => "enum_resource_type_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-15 19:54:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gtYLiP69o5X0yIAfVJxEJA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
