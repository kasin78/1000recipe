use recipe;

DROP TABLE IF EXISTS notice;

CREATE TABLE notice (
    num int auto_increment PRIMARY KEY , 
    title varchar(50),
    userName VARCHAR(50),
    regDate date,
    readcount int,
    content varchar(2000)
);