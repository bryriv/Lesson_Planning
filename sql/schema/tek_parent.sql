create table tek_parent (
    id int(5) not null auto_increment,
    section tinyint not null,
    topic varchar(60) not null,
    grade tinyint not null,
    content text not null,
    primary key (id)
);