drop trigger default_group;
drop trigger image_increment;
drop sequence image_sequence;
drop trigger group_increment;
drop sequence group_sequence;
drop table images;
drop table group_lists;
drop table groups;
drop table persons;
drop table users;






create table users(
       user_name	char(20),
       password		char(20),
       date_registered	date default sysdate,
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
       date_created	date default sysdate,
       foreign key(user_name) references users(user_name),
       primary key(group_id),
       check(group_name is not null)
);

create table group_lists(
       group_id		int,
       friend_name	char(20),
       date_added	date default sysdate,
       foreign key(group_id) references groups(group_id),
       foreign key(friend_name) references users(user_name)
);

create table images(
       photo_id		int,
       owner_name	char(20),
       permitted	int,
       subject		char(20),
       place		char(20),
       date_taken	char(20),
       description	varchar(100),
       thumbnail	BLOB,
       photo		BLOB,
       foreign key(owner_name) references users(user_name),
       foreign key(permitted) references groups(group_id),
       primary key(photo_id)
);

create sequence group_sequence
minvalue 0
start with 0 
increment by 1;

create trigger group_increment
before insert
on groups
for each row
declare
	dummy integer;
begin
	select group_sequence.nextval into dummy from dual;
       :new.group_id := dummy;
end group_increment;
/
create sequence image_sequence
minvalue 0
start with 0 
increment by 1;

create trigger image_increment
before insert
on images
for each row
declare
	dummy integer;
begin
	select image_sequence.nextval into dummy from dual;
       :new.photo_id := dummy;
end image_increment;
/

create trigger default_group
after insert
on users
for each row
begin
	insert into groups(user_name,group_name) values(:new.user_name,'default');
end default_group;
/

insert into groups(group_name) values('public');
insert into groups(group_name) values('private');
