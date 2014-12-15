use utf8;
package Schema::Result::Tek;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Tek

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tek>

=cut

__PACKAGE__->table("tek");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 tek_parent_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 alpha

  data_type: 'varchar'
  is_nullable: 0
  size: 4

=head2 standard

  data_type: 'varchar'
  is_nullable: 0
  size: 4

=head2 content

  data_type: 'varchar'
  is_nullable: 0
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
  "tek_parent_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "alpha",
  { data_type => "varchar", is_nullable => 0, size => 4 },
  "standard",
  { data_type => "varchar", is_nullable => 0, size => 4 },
  "content",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 tek_parent

Type: belongs_to

Related object: L<Schema::Result::TekParent>

=cut

__PACKAGE__->belongs_to(
  "tek_parent",
  "Schema::Result::TekParent",
  { id => "tek_parent_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MaT8gh5WMwbtx6hgaSlcVA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
