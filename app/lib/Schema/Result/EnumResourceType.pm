use utf8;
package Schema::Result::EnumResourceType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::EnumResourceType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<enum_resource_type>

=cut

__PACKAGE__->table("enum_resource_type");

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

=head2 resources

Type: has_many

Related object: L<Schema::Result::Resource>

=cut

__PACKAGE__->has_many(
  "resources",
  "Schema::Result::Resource",
  { "foreign.enum_resource_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-15 01:23:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YLEOAfO0tXppd5q2PLyJ8A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;