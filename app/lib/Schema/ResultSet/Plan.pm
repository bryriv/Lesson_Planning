package Schema::ResultSet::Plan;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

sub test {
    my $self = shift;
    print STDERR "Plan ResultSet Test Method\n";
}

sub plan_simple {
    my ($self, $id) = @_;
    if ($id) {
        my $plan = $self->find(
            {   'me.id' => $id  },
            {
                join => ['tek_summary'],
                '+select' => ['tek_summary.label'],
                '+as' => ['tek_label']
            }
        );
        return {$plan->get_columns};
    }
    else {
        my @plans = $self->search(
            {},
            {
                join => ['tek_summary'],
                '+select' => ['tek_summary.label'],
                '+as' => ['tek_label']
            }
        );
        return [ map { {$_->get_columns} } @plans ];
    }

    # if ($id) {
    #     my $plan = $self->find($id);
    #     return {$plan->get_columns};
    # }
    # else {
    #     my @plans = $self->search(
    #         {},
    #         {}
    #     );
    #     return [ map { {$_->get_columns} } @plans ];
    # }
}

sub plan_complete {
    my ($self, $id) = @_;
    if ($id) {
        my $plan = $self->find(
            {   'me.id' => $id   },
            {
                join => ['proc_standard', 'tek_summary'],
                '+select' => ['proc_standard.id', 'proc_standard.alpha', 'proc_standard.content', 'tek_summary.topic', 'tek_summary.ks', 'tek_summary.se', 'tek_summary.label'],
                '+as' => ['ps_id', 'ps_alpha', 'ps', 'topic', 'ks', 'se', 'tek_label']
            }
        );
        return {$plan->get_columns};
    }
    else {
        my @plans = $self->search(
            {},
            {
                join => ['proc_standard', 'tek_summary'],
                '+select' => ['proc_standard.id', 'proc_standard.alpha', 'proc_standard.content', 'tek_summary.topic', 'tek_summary.ks', 'tek_summary.se', 'tek_summary.label'],
                '+as' => ['ps_id', 'ps_alpha', 'ps', 'topic', 'ks', 'se', 'tek_label']
            }
        );
        return [ map { {$_->get_columns} } @plans ];
    }
}

1;