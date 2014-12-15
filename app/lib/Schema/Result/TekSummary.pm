use utf8;
package Schema::Result::TekSummary;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::TekSummary

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tek_summary>

=cut

__PACKAGE__->table("tek_summary");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 label

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 tek

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 13

=head2 grade

  data_type: 'tinyint'
  is_nullable: 0

=head2 standard

  data_type: 'varchar'
  is_nullable: 0
  size: 4

=head2 topic

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 ks

  data_type: 'text'
  is_nullable: 0

=head2 se

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
  "label",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "tek",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 13 },
  "grade",
  { data_type => "tinyint", is_nullable => 0 },
  "standard",
  { data_type => "varchar", is_nullable => 0, size => 4 },
  "topic",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "ks",
  { data_type => "text", is_nullable => 0 },
  "se",
  { data_type => "varchar", is_nullable => 0, size => 255 },
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
  { "foreign.tek_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NUukGp2iF6eWnSudVNiO5Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
