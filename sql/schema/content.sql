create table content (
    id int(5) not null auto_increment,
    plan_id int(5) not null,
    content text not null,
    content_type_id int(5) not null,
    primary key (id)
);