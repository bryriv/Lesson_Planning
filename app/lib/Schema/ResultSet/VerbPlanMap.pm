package Schema::ResultSet::VerbPlanMap;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

use Data::Dumper;

sub test {
    my $self = shift;
    print STDERR "VerbPlanMap ResultSet Test Method\n";
}

sub get_plan_verbs {
    my ($self, $id) = @_;

    my @data = $self->search(
        {   'plan_id' => $id   },
        {
            join => 'verb',
            '+select' => ['verb.verb'],
            '+as' => ['verb'],
            order_by => {-asc => 'verb.verb'}
        }
    )->all;

    return [ map { {$_->get_columns} } @data ];
}


1;