create table link (
    id int(5) not null auto_increment,
    url varchar(255),
    plan_id int(5) not null,
    link_type_id int(5) not null,
    complete tinyint default 0,
    notes varchar(255),
    primary key (id)
);