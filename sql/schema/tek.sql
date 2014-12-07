create table tek (
    id int(5) not null auto_increment,
    tek_parent_id int(5) not null,
    alpha varchar(4) not null,
    standard varchar(4) not null,
    content varchar(255) not null,
    primary key (id)
);