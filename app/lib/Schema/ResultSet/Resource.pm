package Schema::ResultSet::Resource;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

use Data::Dumper;

sub test {
    my $self = shift;
    print STDERR "Resource ResultSet Test Method\n";
}

sub get_plan_resources {
    my ($self, $id) = @_;

    my @data = $self->search(
        {   'plan_id' => $id   },
        {
            join => 'enum_resource_type',
            '+select' => ['enum_resource_type.type', 'enum_resource_type.label', 'enum_resource_type.sequence'],
            '+as' => ['type', 'type_label', 'type_sequence'],
            order_by => {-asc => 'enum_resource_type.sequence'}
        }
    )->all;

    return [ map { {$_->get_columns} } @data ];
}


1;