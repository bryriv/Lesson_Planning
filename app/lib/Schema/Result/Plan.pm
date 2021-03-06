use utf8;
package Schema::Result::Plan;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Plan

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<plan>

=cut

__PACKAGE__->table("plan");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 plan_d

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 grade_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 tek_summary_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 proc_standard_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 create_d

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "plan_d",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "grade_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "tek_summary_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "proc_standard_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "create_d",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 grade

Type: belongs_to

Related object: L<Schema::Result::Grade>

=cut

__PACKAGE__->belongs_to(
  "grade",
  "Schema::Result::Grade",
  { id => "grade_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 proc_standard

Type: belongs_to

Related object: L<Schema::Result::ProcStandard>

=cut

__PACKAGE__->belongs_to(
  "proc_standard",
  "Schema::Result::ProcStandard",
  { id => "proc_standard_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 resources

Type: has_many

Related object: L<Schema::Result::Resource>

=cut

__PACKAGE__->has_many(
  "resources",
  "Schema::Result::Resource",
  { "foreign.plan_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sections

Type: has_many

Related object: L<Schema::Result::Section>

=cut

__PACKAGE__->has_many(
  "sections",
  "Schema::Result::Section",
  { "foreign.plan_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tek_summary

Type: belongs_to

Related object: L<Schema::Result::TekSummary>

=cut

__PACKAGE__->belongs_to(
  "tek_summary",
  "Schema::Result::TekSummary",
  { id => "tek_summary_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 verb_plan_maps

Type: has_many

Related object: L<Schema::Result::VerbPlanMap>

=cut

__PACKAGE__->has_many(
  "verb_plan_maps",
  "Schema::Result::VerbPlanMap",
  { "foreign.plan_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-01-25 14:01:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nrdfqlLgretcXytlvVLGJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
