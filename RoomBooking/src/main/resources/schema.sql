CREATE TABLE room (
    ID BIGINT,
    NAME NVARCHAR(40) NOT NULL,
    CONSTRAINT PK_room PRIMARY KEY  (ID)
);
CREATE TABLE timetable(
    ID BIGINT,
    PERSON NVARCHAR(40),
    TIMEFROM TIMESTAMP,
    TIMETO TIMESTAMP,
    CONTACT NVARCHAR(40),
    ROOM_ID BIGINT,
    CONSTRAINT PK_timetable PRIMARY KEY  (ID),
    CONSTRAINT FK_room FOREIGN KEY (ROOM_ID) REFERENCES room(ID)
);
INSERT INTO room VALUES (0, 'tennis');
INSERT INTO room VALUES (1, 'playstation');
INSERT INTO room VALUES (2, '302');
INSERT INTO room VALUES (3, '303');
INSERT INTO room VALUES (4, '304');
INSERT INTO room VALUES (5, '404');
create table USERS
(
    id       serial not null
        constraint user_table_pk
            primary key,
    login    varchar(50),
    password varchar(500),
    role varchar(50)
);
Insert Into USERS VALUES(0,'SA', '$2a$16$pPr7c4JrshgvDLFdVkhqfujD0nSb2ekNDNtsqnNW9BBbm9txVTGpC','ROLE_SUPERADMIN');