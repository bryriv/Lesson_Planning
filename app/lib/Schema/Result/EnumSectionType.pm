use utf8;
package Schema::Result::EnumSectionType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::EnumSectionType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<enum_section_type>

=cut

__PACKAGE__->table("enum_section_type");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "type",
  { data_type => "varchar", is_nullable => 0, size => 60 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 sections

Type: has_many

Related object: L<Schema::Result::Section>

=cut

__PACKAGE__->has_many(
  "sections",
  "Schema::Result::Section",
  { "foreign.enum_section_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lNb/YzRfQ/w9BWTOO/0m7g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
