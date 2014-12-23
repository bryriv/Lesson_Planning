package Schema::ResultSet::Plan;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';
use Template::Latex;
use TeX::Encode;
use File::Copy;

use Data::Dumper;

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
                join => ['tek_summary', 'grade'],
                '+select' => ['tek_summary.label', 'grade.grade'],
                '+as' => ['tek_label', 'grade']
            }
        );
        return {$plan->get_columns};
    }
    else {
        my @plans = $self->search(
            {},
            {
                join => ['tek_summary', 'grade'],
                '+select' => ['tek_summary.label', 'grade.grade'],
                '+as' => ['tek_label', 'grade']
            }
        );
        return [ map { {$_->get_columns} } @plans ];
    }
}

sub plan_complete {
    my ($self, $id) = @_;
    if ($id) {
        my $plan = $self->find(
            {   'me.id' => $id   },
            {
                join => ['proc_standard', 'tek_summary', 'grade'],
                '+select' => ['proc_standard.id', 'proc_standard.alpha', 'proc_standard.content', 'tek_summary.topic', 'tek_summary.ks', 'tek_summary.se', 'tek_summary.label', 'grade.grade'],
                '+as' => ['ps_id', 'ps_alpha', 'ps', 'topic', 'ks', 'se', 'tek_label', 'grade']
            }
        );
        return {$plan->get_columns};
    }
    else {
        my @plans = $self->search(
            {},
            {
                join => ['proc_standard', 'tek_summary', 'grade'],
                '+select' => ['proc_standard.id', 'proc_standard.alpha', 'proc_standard.content', 'tek_summary.topic', 'tek_summary.ks', 'tek_summary.se', 'tek_summary.label', 'grade.grade'],
                '+as' => ['ps_id', 'ps_alpha', 'ps', 'topic', 'ks', 'se', 'tek_label', 'grade']
            }
        );
        return [ map { {$_->get_columns} } @plans ];
    }
}

sub export {
    my ($self, $args) = @_;
    $self->{template_conf} = $args->{template};
    $self->build_cleaners();
    print STDERR Dumper $self->{template_conf};

    # get main plan data and related data
    my $plan_data = $self->plan_complete($args->{id});
    $plan_data->{verbs} = $args->{related_rs}{verb_plan_map}->get_plan_verbs($args->{id});
    $plan_data->{sections} = $args->{related_rs}{section}->get_plan_sections($args->{id});
    $plan_data->{resources} = $args->{related_rs}{resource}->get_plan_resources($args->{id});

    # separate first 2 sections for the first page
    $plan_data->{first_page} = [splice(@{$plan_data->{sections}}, 0, 2)];
    # stringify verbs
    $plan_data->{verb_string} = join(', ', map {$_->{verb}} @{$plan_data->{verbs}});
    # default value for section content if no data available
    for my $section (@{$plan_data->{first_page}}, @{$plan_data->{sections}}) {
        $section->{content} = $self->latex_chars($section->{content}) if $section->{content};
        $section->{content} = 'No data available' if !$section->{content};
    }
    # prep resource data
    for my $resource (@{$plan_data->{resources}}) {
        $resource->{complete} = $resource->{complete} == 1 ? 'Yes' : 'No';
        # $resource->{notes} = TeX::Encode::encode('latex', $resource->{notes});
        $resource->{notes} = $self->latex_chars($resource->{notes}) if $resource->{notes};
        $resource->{notes} = 'No notes' if !$resource->{notes};
    }
    $self->{plan_data} = $plan_data;

    print STDERR Dumper $plan_data;
    my $pdf_file = $self->generate_pdf_filename();

    my $tt = Template::Latex->new({
        INCLUDE_PATH    => $self->{template_conf}{include},
        OUTPUT_PATH    => $self->{template_conf}{output},
        PDFLATEX_PATH   => '/usr/bin/pdflatex'
    });
    my $pdf = $tt->process('plan_tex.tt2', $plan_data, '', binmode => 1) || print STDERR $tt->error();;

    move($self->{template_conf}{output}.'/out.pdf', $self->{template_conf}{output}."/$pdf_file");
    return {pdf_link => '/download/'.$pdf_file};
}

sub build_cleaners {
    my $self = shift;
    $self->{chars_to_escape} = qr/([$self->{template_conf}{chars_to_escape}])/;
    for my $char (keys %{$self->{template_conf}{char_map}}) {
        my $reg = qr/$char/;
        $self->{map_regex}{$reg} = $self->{template_conf}{char_map}{$char};
    }
}

sub latex_chars {
    my ($self, $data) = @_;
    # escape chars for latex
    $data =~ s/$self->{chars_to_escape}/\\$1/g;
    # map some other chars to latex equivalents
    for my $regex (keys %{$self->{map_regex}}) {
        $data =~ s/$regex/$self->{map_regex}{$regex}/g;
    }

    $data =~ s/\n/ \\newline\\newline /g;

    return $data;
}

sub generate_pdf_filename {
    my $self = shift;
    my @parts;
    (my $date = $self->{plan_data}{plan_d}) =~ s/-//g;
    push @parts, $date;
    (my $tek = $self->{plan_data}{tek_label}) =~ s/\s/_/g;
    $tek =~ s/[\(\)]//g;
    push @parts, $tek;
    push @parts, 'pdf';
    return join('.', @parts);
}






1;