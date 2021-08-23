--> Business Rule : Real life use {Railway, Account, Hospital} management 

-------------- <Triggers> --------------
--> works with ddl{create alter drop} and dml{insert update delete merge} commands 
--> two types after and instead of trigger 
--> For Complex validation

--> here we only have after trigger 
--> after a statement{insert, delete, update} is executed trigger would be fired
select name from master.sys.databases;

create database CustomerDb;
use CustomerDb;

create table tab1(
	Rno int,
	s1 int,
);


-- <After Trigger> --
--{ --> we want to get the error message --> and den roll back transaction } --> can be done by constraint
--> we dont have to do it explicitly


create trigger i_trigger  --> creating a trigger 
on tab1 --> for table tab1
for insert --> for action insert 
as 
begin 
	declare @sub int
	select @sub = s.s1 from inserted s;
	if(@sub > 100) --> checking conditon
		begin
			print('Invalid Marks Entry')
			rollback tran --> rolling back the transaction if invalid entry 
		end 
	else 
		print('Inserted Successfully ')
end 


insert into tab1 values(1, 23);
insert into tab1 values(2, 230);
insert into tab1 values(2, 100);


-- <Instead of Trigger> --
--> Meaning : instead of trigger do something else 
-- delete from tab1 where Rno = 1; --> this is will delete data where id is 1 from table tab1
--> if we dont want this to happen we can create an instead 

create trigger no_del on tab1 --> creating trigger on tab1
instead of delete --> for instead of delete
as 
begin --> what to do instead of delete 
	print('Deleting record is not permissible') --> print this message
	--> if we write delete here it will work 
	-- delete from tab1 where Rno = some_Rno --> this will work, this won't call the trigger again 
end 

alter trigger no_del on tab1 --> creating trigger on tab1
instead of delete --> for instead of delete
as 
begin --> what to do instead of delete 
	print('Deleting record is not permissible') --> print this message
	--> if we write delete here it will work 
	-- delete from tab1 where Rno = some_Rno --> this will work, this won't call the trigger again 
	delete from tab1 where Rno > 50; --> delete all records where R_number greater than 50
	select Rno as Deleted, s1 as Sub from deleted;
end 

alter trigger no_del on tab1 --> creating trigger on tab1
instead of delete --> for instead of delete
as 
begin --> what to do instead of delete 
	--> if we write delete here it will work 
	-- delete from tab1 where Rno = some_Rno --> this will work, this won't call the trigger again 
	select Rno as Deleted, s1 as Sub from deleted;
	--> only delete if id > 50
	declare @toDel int
	declare @osub int
	select @toDel = Rno from deleted;
	if(@toDel < 51)
		begin 
			print('Deleting record is not permissible') --> print this message	
			rollback tran
		end 
	else 
		delete from tab1 where Rno = @toDel;
end 

delete from tab1 where Rno = 51;

insert into tab1(Rno, s1) values(51, 24), (52, 37), (66, 54);
select * from tab1;


