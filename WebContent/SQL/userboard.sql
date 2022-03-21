use recipe;

drop table if exists userboard;

create table userboard(
	num int auto_increment primary key,
    title varchar(50),
    userName varchar(50),
    password varchar(50),
    regDate date,
    readcount int,
    content varchar(2000)
);