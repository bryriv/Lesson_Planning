#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use lib 'lib';
use Schema;
# use DBIx::Class::ResultClass::HashRefInflator;

use Data::Dumper;

my $conf = plugin JSONConfig => { file => './app.conf' };

helper db => sub {
  return Schema->connect($conf->{dsn}, $conf->{dbuser}, $conf->{dbpwd});
};

get '/plans' => sub {
    my $self = shift;
    my @plans = $self->db->resultset('Plan')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @plans
        ]},
    );
};

get '/plans/:id' => sub {
    my $self = shift;
    my $plan = $self->db->resultset('Plan')->find($self->stash('id'));
    $self->respond_to(
        any  => {json => {$plan->get_columns}},
    );
};

post '/plans' => sub {
    my $self = shift;
    my $data = $self->req->body;
    my $hash = decode_json($data);

    print STDERR Dumper $hash;

    $hash->{sections} = $self->munge_sections($hash->{sections});

    print STDERR Dumper $hash;

    $self->db->resultset('Plan')->create($hash);

    return $self->render(json => {result => 999, message => 'OK'});

    # my $plan = $self->db->resultset('Plan')->create($hash);
    # if($plan->id) {
    #     return $self->render(
    #         json => {
    #             result => $plan->id, 
    #             message => 'OK',

    #         }
    #     );
    # }
    # else {
    #     return $self->render(
    #         json => {result => '0', message => 'Create plan failed.'}
    #     );
    # }
};

get '/teks' => sub {
    my $self = shift;
    # my @enum_section_types = $self->db->resultset('EnumSectionType')->all();
    # my %types = map {$_->{type} => $_->{id}} map {{$_->get_columns}} @enum_section_types;
    # print STDERR Dumper \%types;

    my @teks = $self->db->resultset('TekSummary')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @teks
        ]},
    );};

get '/teks/:id' => sub {
    my $self = shift;
    my $tek_id  = $self->stash('id');
    my $tek = $self->db->resultset('TekSummary')->find($tek_id);
    $self->respond_to(
        any  => {json => {$tek->get_columns}},
    );
};

get '/ps' => sub {
    my $self = shift;
    my @ps = $self->db->resultset('ProcStandard')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @ps
        ]},
    );};

get '/ps/:id' => sub {
    my $self = shift;
    my $ps_id  = $self->stash('id');
    my $ps = $self->db->resultset('ProcStandard')->find($ps_id);
    $self->respond_to(
        any  => {json => {$ps->get_columns}},
    );
};

get '/verbs' => sub {
    my $self = shift;
    my @verbs = $self->db->resultset('Verb')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @verbs
        ]},
    );};

get '/verbs/:id' => sub {
    my $self = shift;
    my $verb_id  = $self->stash('id');
    my $verb = $self->db->resultset('Verb')->find($verb_id);
    $self->respond_to(
        any  => {json => {$verb->get_columns}},
    );
};


helper munge_sections => sub {
    my ($self, $sections) = @_;

    # get hash lookup for section type ids {type => db_id}
    my @enum_section_types = $self->db->resultset('EnumSectionType')->all();
    my %enum_section_types = map {$_->{type} => $_->{id}} map {{$_->get_columns}} @enum_section_types;

    my @sections;
    for my $section (keys %{$sections}) {
        push @sections, 
            {   enum_section_type_id => $enum_section_types{$section}, 
                content => $sections->{$section}
            };
    }
    return \@sections;
};


app->start;

# get '/plans' => sub {
#     my $self = shift;
#     # my @plans = $self->db->resultset('Plan')->search({}, { join => 'primary_tek'});
#     my @plans = $self->db->resultset('Plan')->search({}, { prefetch => 'primary_tek'});
#     # my @plans = $self->db->resultset('Plan')->search();
#     for my $plan (@plans) {
#         # print STDERR Dumper $plan;
#         # print STDERR $plan->primary_tek->tek, "\n";
#         # my %data = $plan->get_inflated_columns;
#         # print STDERR Dumper \%data;
#     }
#     # $self->respond_to(
#     #     # any  => {json => {"plans" => [
#     #     #     map { {$_->get_columns} } @plans
#     #     # ]}},
#     #     any  => {json => {"plans" => 
#     #          @plans
#     #     ]}},
#     # );

#     my $json = {
#         json => {
#             "plans" => [ {"id" => "3", "primary_tek_id" => "2"} ],
#             "primary_teks" => [ { "id" => "2", "tek" => "9.2A"} ]
#         }
#     };

#     $self->respond_to( any => $json);
# };
