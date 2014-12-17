use utf8;
package Schema::Result::VerbPlanMap;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::VerbPlanMap

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<verb_plan_map>

=cut

__PACKAGE__->table("verb_plan_map");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 verb_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 plan_id

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
  "verb_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "plan_id",
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

=head2 verb

Type: belongs_to

Related object: L<Schema::Result::Verb>

=cut

__PACKAGE__->belongs_to(
  "verb",
  "Schema::Result::Verb",
  { id => "verb_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-17 01:48:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hQgNn+Hrtcj6hOAMqU5d1A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
