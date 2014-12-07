create table plan (
    id int(5) not null auto_increment,
    plan_d date not null,
    grade tinyint not null,
    primary_tek_id int(5) not null,
    secondary_tek_id int(5) not null,
    ps_id int(5) not null,
    primary key (id)
);