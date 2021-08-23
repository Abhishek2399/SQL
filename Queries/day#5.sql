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
--> to create trigger on views

create trigger no_del on tab1 --> creating trigger on tab1
instead of delete --> for instead of delete
as 
begin --> what to do instead of delete 
	print('Deleting record is not permissible') --> print this message
	--> if we write delete here it will work 
	-- delete from tab1 where Rno = some_Rno --> this will work, this won't call the trigger again 
end 

alter trigger no_del on tab1 
instead of delete --> for instead of delete
as 
begin --> what to do instead of delete 
	print('Deleting record is not permissible') --> print this message
	--> if we write delete here it will work 
	-- delete from tab1 where Rno = some_Rno --> this will work, this won't call the trigger again 
	delete from tab1 where Rno > 50; --> delete all records where R_number greater than 50
	select Rno as Deleted, s1 as Sub from deleted;
end 

alter trigger no_del on tab1 
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


-- Tracking Update details in tab1 table 

create table audUP(
	oRno int,
	info varchar(100),
);


create trigger onlySub on tab1
for update 
as
begin 
	declare @oRno int
	declare @osub int --> old sub
	declare @nsub int --> new sub 
	
	select @oRno=Rno, @osub = s1 from deleted ;
	select @nsub = s1 from inserted ;

	insert into audUP(oRno, info) 
	values(
		@oRno, 'old value: '+ 
		cast(@osub as varchar(5)) + 
			' new value : '+ cast(@nsub as varchar(5)) + 
			' On Date : ' + cast(getdate() as varchar(100))
	);
end 

update tab1 set s1 = 89 where Rno = 52;
select * from audUP;




create procedure procaud --> creating view 
as 
select * from audup --> for this query 


-------------- <Views> --------------
--> virtual table 
--> query can be sotred in view 
--> query will be called when we call view

create view viewaud --> creating view 
as 
select * from audup --> for this query 

--> both have same outout 
exec procaud; 
select * from viewaud; --> just virtual table data wont be stored physically anywhere 
--> we can update insert and delete 
insert into viewaud values(12, 67); --> this will change the original audUP table as well
-- delete from viewaud where condn; --> this will change the original audUP table as well

--> if a view is based on a single table it is simple view 
--> if a view is based on more than one table it is complex  
--> we cannot create trigger on view 
--> instead of trigger will work on view 

-----------------<Not Allowed!!!!!>-------------------------
--> after trigger 
create trigger trigView on viewaud
after insert
as
begin 
	print('Inserted in View')
end
-------------------------------------------------------------


-----------------<Allowed!!!!!>-------------------------
--> instead of trigger 
create trigger trigView on viewaud
instead of delete
as
begin 
	print('Inserted in View')
end
-------------------------------------------------------------

use DemoProj;

select * from emps;
select * from depts;


-- getting dept name and emp name 
select e.ename, d.d_name 
from emps e join depts d
on e.d_id = d.d_id;

--> creating a simple view for above join
create view simpview --> complex view as 2 tables are involved 
as
select e.ename, d.d_name 
from emps e join depts d
on e.d_id = d.d_id;

--> as 2 tables are involved we can't do any DML operations 
select * from simpview;


--> computed view 
create view simpview1
as 
select sal=sal+1 from emps;


select * from simpview1;


create table empdup(eid int, ename varchar(20));

create view viewemp
as 
select ename from empdup

insert into viewemp values('wilson'); --> allowed only if other columns dont have any constraint 

select * from empdup;

--> Even with simple views we can't perform all the DML operations properly 
