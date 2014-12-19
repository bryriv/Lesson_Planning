#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use lib 'lib';
use Schema;

my $conf = plugin JSONConfig => { file => './app.conf' };

use Data::Dumper;

# plans
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
    my $plan = $self->db->resultset('Plan')->find(
        {   'me.id' => $self->stash('id')   },
        {
            join => ['proc_standard', 'tek_summary'],
            '+select' => ['proc_standard.alpha', 'proc_standard.content', 'tek_summary.topic', 'tek_summary.ks', 'tek_summary.se'],
            '+as' => ['ps_alpha', 'ps', 'topic', 'ks', 'se']
        }
    );
    $self->respond_to(
        any  => {json => {$plan->get_columns}},
    );
};

get '/plans/:id/verbs' => sub {
    my $self = shift;
    my $plan_id = $self->stash('id');
    my @data = $self->db->resultset('VerbPlanMap')->search(
        {   'plan_id' => $plan_id   },
        {
            join => 'verb',
            '+select' => ['verb.verb'],
            '+as' => ['verb'],
            order_by => {-asc => 'verb.verb'}
        }
    )->all;
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @data   # gets verb_plan_map, plus verb.verb
            # map { {$_->verb->get_columns} } @data # gets a smaller hash with just the 'verb' data, needs prefetch
        ]},
    );
};

get '/plans/:id/resources' => sub {
    my $self = shift;
    my $plan_id = $self->stash('id');
    # select * from resource r join enum_resource_type e on e.id = r.enum_resource_type_id where r.plan_id = 41;
    my @data = $self->db->resultset('Resource')->search(
        {   'plan_id' => $plan_id   },
        {
            join => 'enum_resource_type',
            '+select' => ['enum_resource_type.type', 'enum_resource_type.label', 'enum_resource_type.sequence'],
            '+as' => ['type', 'type_label', 'type_sequence'],
            order_by => {-asc => 'enum_resource_type.sequence'}
        }
    )->all;
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @data
        ]},
    );
};

get '/plans/:id/sections' => sub {
    my $self = shift;
    my $plan_id = $self->stash('id');
    # select * from section s join enum_section_type e on e.id = s.enum_section_type_id where s.plan_id = 41;
    my @data = $self->db->resultset('Section')->search(
        {   'plan_id' => $plan_id   },
        {
            join => 'enum_section_type',
            '+select' => ['enum_section_type.type, enum_section_type.label, enum_section_type.sequence'],
            '+as' => ['type', 'type_label', 'type_sequence'],
            order_by => {-asc => 'enum_section_type.sequence'}
        }
    )->all;

    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @data
        ]},
    );
};

put '/plans/:id/sections/:section_id' => sub {
    my $self = shift;
    # planid not needed, so I guess I "could" have created entry point /sections/:id
    # not sure which is more "REST" compliant
    my $section_id = $self->stash('section_id');
    my $data = $self->req->body;
    my $hash = decode_json($data);

    my $rs = $self->db->resultset('Section')->find($section_id);
    my $update = $rs->update($hash);

    my $update_success = 1;
    for my $key (keys %$hash) {
        if ($hash->{$key} ne $update->get_column($key)) {
            $update_success = 0;
            last;
        }
    }

    return $update_success ?
        $self->render(json => { message => 'OK' }) :
        $self->render(json => { message => 'Fail' });
};

put '/plans/:id/resources/:resource_id' => sub {
    my $self = shift;
    # planid not needed, so I guess I "could" have created entry point /sections/:id
    # not sure which is more "REST" compliant
    my $resource_id = $self->stash('resource_id');
    my $data = $self->req->body;
    my $hash = decode_json($data);

    my $rs = $self->db->resultset('Resource')->find($resource_id);
    my $update = $rs->update($hash);

    my $update_success = 1;
    for my $key (keys %$hash) {
        if ($hash->{$key} ne $update->get_column($key)) {
            $update_success = 0;
            last;
        }
    }

    return $update_success ?
        $self->render(json => { message => 'OK' }) :
        $self->render(json => { message => 'Fail' });
};

put '/plans/:id/verbs' => sub {
    my $self = shift;
    my $plan_id = $self->stash('id');
    my $data = $self->req->body;
    my $hash = decode_json($data);
    my $verbs = $hash->{verbs};

    my $update_success = 1;

    my $verb_map_rs = $self->db->resultset('VerbPlanMap');
    my $delete = $verb_map_rs->search(
        {   plan_id => $plan_id   },
    )->delete;

    # if new verbs, get them in arrayref of hashrefs
    my $new_verbs = [];
    if ($verbs) {
        my @data = $self->db->resultset('Verb')->search(
                {   id => {-in => $verbs}    },
                {   order_by => {-asc => 'verb'} }
        )->all;
        $new_verbs = [map { {$_->get_columns} } @data];

        my @verb_data;
        for my $verb_id (@{$verbs}) {
            push @verb_data, {plan_id => $plan_id, verb_id => $verb_id};
        }
        # void context. need to handle error condition, but it will probably 500 anyway
        $verb_map_rs->populate(\@verb_data);
    }

    return $update_success ?
        $self->render(json => { message => 'OK', new_verbs => $new_verbs }) :
        $self->render(json => { message => 'Fail' });
};

post '/plans' => sub {
    my $self = shift;
    my $data = $self->req->body;
    my $hash = decode_json($data);

    print STDERR Dumper $hash;

    $hash->{sections} = $self->map_sections($hash->{sections});
    $hash->{verb_plan_maps} = $self->map_verbs($hash->{verb_plan_maps});
    $hash->{resources} = $self->map_resources($hash->{resources});

    print STDERR Dumper $hash;

    # return $self->render(json => {result => 999, message => 'OK'});

    my $plan = $self->db->resultset('Plan')->create($hash);
    return $plan->id ?
        $self->render(json => {   result => $plan->id, message => 'OK' }) :
        $self->render(json => {   result => '0', message => 'Create plan failed.'});
};


# teks
get '/teks' => sub {
    my $self = shift;
    my @teks = $self->db->resultset('TekSummary')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @teks
        ]},
    );
};

get '/teks/:id' => sub {
    my $self = shift;
    my $tek_id  = $self->stash('id');
    my $tek = $self->db->resultset('TekSummary')->find($tek_id);
    $self->respond_to(
        any  => {json => {$tek->get_columns}},
    );
};

# process standards
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

# verbs
get '/verbs' => sub {
    my $self = shift;
    my @verbs = $self->db->resultset('Verb')->search(
        {},
        {   order_by => {-asc => 'verb'} }
    )->all();
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

post '/verbs' => sub {
    my $self = shift;
    my $data = $self->req->body;
    my $hash = decode_json($data);

    print STDERR Dumper $hash;
    my $verb = $self->db->resultset('Verb')->create($hash);
    if($verb->id) {
        return $self->render(
            json => {
                result => $verb->id, 
                message => 'OK',

            }
        );
    }
    else {
        return $self->render(
            json => {result => '0', message => 'Add verb failed.'}
        );
    }
};

# types
get '/section_types' => sub {
    my $self = shift;
    my @teks = $self->db->resultset('EnumSectionType')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @teks
        ]},
    );
};

get '/resource_types' => sub {
    my $self = shift;
    my @teks = $self->db->resultset('EnumResourceType')->all();
    $self->respond_to(
        any  => {json => [
            map { {$_->get_columns} } @teks
        ]},
    );
};


# helpers
helper db => sub {
  return Schema->connect($conf->{dsn}, $conf->{dbuser}, $conf->{dbpwd});
};

helper map_sections => sub {
    my ($self, $sections) = @_;

    # get hash lookup for section type ids {type => db_id}
    my @enum_section_types = $self->db->resultset('EnumSectionType')->all();
    my %enum_section_types = map {$_->{type} => $_->{id}} map {{$_->get_columns}} @enum_section_types;

    # Include all sections even if they're weren't posted
    # Builds out complete plan
    my @sections;

    for my $section_type (keys %enum_section_types) {
        my $hash->{enum_section_type_id} = $enum_section_types{$section_type};
        $hash->{content} = $sections->{$section_type} if $sections->{$section_type};
        push @sections, $hash;
    }
    return \@sections;
};

helper map_resources => sub {
    my ($self, $resources) = @_;

    # get hash lookup for resource type ids {type => db_id}
    my @enum_resource_types = $self->db->resultset('EnumResourceType')->all();
    my %enum_resource_types = map {$_->{type} => $_->{id}} map {{$_->get_columns}} @enum_resource_types;

    my @resources;
    for my $resource_type (keys %enum_resource_types) {
        my $hash->{enum_resource_type_id} = $enum_resource_types{$resource_type};
        for my $attr (keys %{$resources->{$resource_type}}) {
            $hash->{$attr} = $resources->{$resource_type}{$attr} if $resources->{$resource_type}{$attr};
        }
        push @resources, $hash;
    }
    return \@resources;
};


helper map_verbs => sub {
    my ($self, $verbs) = @_;
    my @verbs;
    for my $verb (@{$verbs}) {
        push @verbs, {verb_id => $verb->{id}};
    }
    return \@verbs;
};

app->start;

