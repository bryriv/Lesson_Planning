use utf8;
package Schema::Result::Grade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Grade

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<grade>

=cut

__PACKAGE__->table("grade");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 grade

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "grade",
  { data_type => "varchar", is_nullable => 0, size => 30 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 plans

Type: has_many

Related object: L<Schema::Result::Plan>

=cut

__PACKAGE__->has_many(
  "plans",
  "Schema::Result::Plan",
  { "foreign.grade_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-22 18:52:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oIV+GefM+tsAiEL/z2uX7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
