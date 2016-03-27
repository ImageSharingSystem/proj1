drop table images;
drop table group_lists;
drop table groups;
drop table persons;
drop table users;

create table users(
       user_name	char(20),
       password		char(20),
       date_registered	date,
       primary key(user_name)
);

create table persons(
       user_name	char(20),
       first_name	char(20),
       last_name	char(20),
       address		char(20),
       email		char(20),
       phone		numeric(10,0),
       foreign key(user_name) references users(user_name),
       primary key(user_name)
);

create table groups(
       group_id		int,
       user_name	char(20),
       group_name	char(20),
       date_created	date,
       foreign key(user_name) references users(user_name),
       primary key(group_id)
);

create table group_lists(
       group_id		int,
       friend_name	char(20),
       date_added	date,
       foreign key(group_id) references groups(group_id),
       foreign key(friend_name) references users(user_name)
);

create table images(
       photo_id		int,
       owner_name	char(20),
       permitted	char(1),
       subject		char(20),
       place		char(20),
       date_taken	char(20),
       description	varchar(100),
       thumbnail	BLOB,
       photo		BLOB,
       foreign key(owner_name) references users(user_name),
       foreign key(permitted) references groups(group_id),
       primary key(photo_id)
)

insert into groups values(0,null,'public',null);
insert into groups values(1,null,'private',null);
insert into users values('admin','123456',null);

