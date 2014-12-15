use utf8;
package Schema::Result::TekSummary6;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::TekSummary6 - VIEW

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<tek_summary_6>

=cut

__PACKAGE__->table("tek_summary_6");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
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
    default_value => 0,
    extra => { unsigned => 1 },
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
  "ks",
  { data_type => "text", is_nullable => 0 },
  "se",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-14 16:09:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XMqf6bm+Ectc3VzbOv5iTA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
