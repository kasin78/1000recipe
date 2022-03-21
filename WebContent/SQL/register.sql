use recipe;

DROP TABLE IF EXISTS register;
CREATE TABLE register (
	id VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(50) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    name VARCHAR(25) NOT NULL,
    postNum INT,
    address VARCHAR(50),
    phoneNum VARCHAR(50),
    adminCode VARCHAR(50)
);