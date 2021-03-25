use crud;
create table user
(
	ID          SERIAL,
	NAME        CHAR(255) NOT NULL,
	DESCRIPTION CHAR(255) NOT NULL
);