use utf8;
package Schema::Result::Verb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Verb

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<verb>

=cut

__PACKAGE__->table("verb");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 verb

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
  "verb",
  { data_type => "varchar", is_nullable => 0, size => 60 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 verb_plan_maps

Type: has_many

Related object: L<Schema::Result::VerbPlanMap>

=cut

__PACKAGE__->has_many(
  "verb_plan_maps",
  "Schema::Result::VerbPlanMap",
  { "foreign.verb_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6qRMw3JcPL6LttL7BaYuJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
