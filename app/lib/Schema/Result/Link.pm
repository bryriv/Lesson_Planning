use utf8;
package Schema::Result::Link;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Link

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<link>

=cut

__PACKAGE__->table("link");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 link

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 sequence

  accessor: undef
  data_type: 'integer'
  extra: {unsigned => 1}
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
  "url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "link",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "sequence",
  {
    accessor    => undef,
    data_type   => "integer",
    extra       => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-01-23 23:06:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8LDJSLxq4VKMf8xOyInO5Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
