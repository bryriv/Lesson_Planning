package Schema::ResultSet::Section;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

use Data::Dumper;

sub test {
    my $self = shift;
    print STDERR "Section ResultSet Test Method\n";
}

sub get_plan_sections {
    my ($self, $id) = @_;

    my @data = $self->search(
        {   'plan_id' => $id   },
        {
            join => 'enum_section_type',
            '+select' => ['enum_section_type.type, enum_section_type.label, enum_section_type.sequence'],
            '+as' => ['type', 'type_label', 'type_sequence'],
            order_by => {-asc => 'enum_section_type.sequence'}
        }
    )->all;

    return [ map { {$_->get_columns} } @data ];
}


sub process_content {
    my ($self, $data) = @_;
    my @sections;
    for my $section (@{$data}) {
        $section->{content} = $self->url_parse($section->{content}) if $section->{content};
        push @sections, $section;
    }
    return \@sections;
}


sub url_parse {
    my ($self, $content) = @_;
    $content =~ s/target="_blank"//g;
    $content =~ s/\<a\s+href=[\'\"]([^\'\"]*)[\'\"]\>([^\<]*)\<\/a\>/\\href{$1}{$2}/g;
    return $content;
}


1;
