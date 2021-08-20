
USE DemoProj

----------------------- CREATING PROCEDURE ---------------
CREATE PROCEDURE PROSQL
AS
BEGIN
	SELECT * FROM EMPS
END
-------------------- calling procedure ------------------
PROSQL 
EXEC PROSQL
EXECUTE PROSQL

--------------------------------------------------------
DECLARE @I INT;
SET @I=1;
BEGIN
	PRINT 'VALUE OF I'+ cast(@I as varchar) -- Printing out the data we want to print 
END

ALTER procedure [DBO].[norm]
as

DECLARE @I INT; -- creating a variable in server 
SET @I=1; -- giving it some value 

-- <While loop> --
while @I<=5
BEGIN
	PRINT 'VALUE OF I'+ cast(@I as varchar)
	SET @I=@I+1
END

NORM
sp_helptext PROSQL  -- GETTING CODE INSIDE PROCEDURE


create procedure #temp1
as
begin
	print 'hello temporary'
end

#temp1 ---- temporary procedure , gets deleted when you exit management studio

select * from emps where eid=89;

----parameterized stored procedure -------

create procedure pro_select(@peid int)
as
begin
	select * from emps where eid = @peid
end

exec pro_select 89


create procedure multi_para(@peid int,@psal int)
as
begin
	select * from emps where eid > @peid or sal > @psal
end

multi_para 89,5000


create procedure pro_insert(@peid int,@pn varchar(20), @pdid int, @psal int , @pmgr int )
as
begin
	insert into emps values(@peid ,@pn, @pdid , @psal  , @pmgr  )
end

pro_insert 55,'sahil',100,15000,2

pro_select 55




-----------optional parameter should be last


create procedure edname
as
begin 
	select ename,d_name from emps join depts on emps.d_id = depts.d_id;
end 

edname

select * from emps
select * from depts
select * from location


sp_help 

alter table emps drop column mgr ;
-- with encryption -- so that other users dont get the procedure details if this is used 
-- with recompile -- whenever we want the system to recompile again and again, by default system won't recompile 

create procedure pro_crud(@task varchar(10),@peid int,@pename varchar(20)=null,@pdid int=null,@psal int=null) -- alter is for changing the procedure 
-- with encryption 
as
begin
set nocount on --> to stop the displayed error messages 
   if(@task='i')
      insert into emps(eid, ename, d_id, sal) values(@peid,@pename,@pdid,@psal)
   else if(@task='s')
      select * from emps where eid=@peid
   else if(@task='d')
      delete from emps where eid=@peid
   else if(@task='u')
      update emps set ename=@pename,sal=@psal where eid=@peid
   else
      print ' invalid option '     
end

alter procedure pro_crud(@task varchar(10),@peid int,@pename varchar(20)=null,@pdid int=null,@psal int=null) -- alter is for changing the procedure 
-- with encryption 
as
begin
set nocount on --> to stop the displayed error messages 
   if(@task='i')
      insert into emps(eid, ename, d_id, sal) values(@peid,@pename,@pdid,@psal)
   else if(@task='s')
      select * from emps where eid=@peid
   else if(@task='d')
      delete from emps where eid=@peid
   else if(@task='u')
      update emps set ename=@pename,sal=@psal where eid=@peid
   else
      print ' invalid option '     
end
 
select * from emps
exec pro_crud 'd',2

exec pro_crud 'i', 2, 'Priyansh', 200, 25000
select * from emps




create procedure Get_Details -- creating a procedure 
as
begin 
	select e.eid, e.ename , d.d_name
	from emps e join depts d
	on e.d_id = d.d_id;
end 

alter procedure Get_Details --> changing the str. of the procedure 
as
begin 
	select e.eid as ID, e.ename as 'Employee Name', d.d_name as 'Department'
	from emps e join depts d
	on e.d_id = d.d_id;
end 

create procedure Get_Single_Emp(@Eid int = null) --> changing the str. of the procedure 
as
begin 
	select e.eid as ID, e.ename as 'Employee Name', d.d_name as 'Department'
	from emps e join depts d
	on e.d_id = d.d_id
	where e.eid = @Eid;
end 

exec Get_Details;

exec Get_Single_Emp ;

------------- <Error Handling > ------------- 
--- we have try catch to handle errors no "finally"

declare @d int ;
declare @dv int ;

begin 
	set @dv = 20;
	begin try
		set @d = @dv/2;
		set @d = @dv/0; -- program won't work "Divide by zero error" will be displyed
		print @d	
	end try 
	begin catch
		print 'Cant divide by zero' 
		print error_message()
	end catch 
	print 'Welcome Team'
end 

declare @v int
declare @vd int
begin
  set @v=100

  begin try
  set @vd=@v/0
  print @vd
  end try
  begin catch
     print 'division error'
     print error_message()
     print Error_number()
     print Error_line()
     print Error_state()
  end catch
  
  print 'after catch block'
end

-- <Logging Errors> --
create table logerror(en int, em varchar(20))
create table dummy(num int)

alter table dummy alter column num int primary key(num);
drop table LogError ;

create procedure pro_dum(@rn int )
as 
begin 
	begin try 
		insert into dummy values(@rn)
	end try 
	begin catch 
		insert into logerror values(error_number(), error_message())
		print 'error'
	end catch 
	print 'After catch'
end 

exec pro_dum 22;
select * from logerror;


-- by sir 
alter procedure pro_dum(@rn int)
as
begin
    begin try
       
       insert into dummy2 values(@rn)
    end try
    begin catch
       insert into logerror(en,em) values(error_number(),error_message())
       print 'error'
       print error_number()
    end catch
    print 'after catch block'
end
pro_dum 22
-----------------


-----------<Triggers>----------
--- similar to store procedure ---
--- Automatically executed ---
-- when insert called insert 
-- invoked when a particular action occurs on a table, actions{Insert, Update, Delete}

--> Trigger have 3 parts 
--> Triggers are of 2 types before{oracle} after(better) after the action has occured 
--> 

--> creatung an insert table
create table auditemp(eid int, trans varchar(100), trans_date datetime) --> track transaction detail
--> creating trigger 


select * from emps ;
create trigger emp_insert_trigger --> internally system will call the trigger 
on emps --> on this table 
for insert --> for this specific action 
as --> similar to stored procedure 
begin 
	print 'Record Inserted'
end 

alter trigger emp_insert_trigger --> internally system will call the trigger 
on emps --> on this table 
for insert --> for this specific action 
as --> similar to stored procedure 
begin 
	declare @empID int 
	select @empID=eid from inserted 
	insert into auditemp(eid, trans, trans_date) values(@empID, 'insert', getdate());
	print 'Record Inserted'
end 

create trigger emp_delete_trigger --> internally system will call the trigger 
on emps --> on this table 
for delete --> for this specific action 
as --> similar to stored procedure 
begin 
	declare @empID int 
	select @empID=eid from inserted
	insert into auditemp(eid, trans, trans_date) values(@empID, 'delete', getdate());
	print 'Record Deleted'
end 

alter trigger emp_delete_trigger --> internally system will call the trigger 
on emps --> on this table 
for delete --> for this specific action 
as --> similar to stored procedure 
begin 
	declare @empID int 
	select @empID=eid from deleted
	insert into auditemp(eid, trans, trans_date) values(@empID, 'delete', getdate());
	print 'Record Deleted'
end 



insert into emps(eid, ename, d_id, sal) values(120, 'fer', 300, 24000);
insert into emps(eid, ename, d_id, sal) values(10, 'reff', 300, 24000);

delete from emps where eid=101;

select * from auditemp;
select * from emps;


create table update_audit(
	eid int,
	info varchar(100),
);


alter trigger emp_update_trigger 
on emps 
for update 
as 
begin 
	declare @e int
	declare @s int
	declare @n varchar(20)

	declare @ns int 
	declare @nn varchar(20)

	select @e=eid from deleted 
	select @s=sal from deleted 
	select @n=ename from deleted 
	
	select @ns=sal from inserted
	select @nn=ename from inserted

	insert into update_audit values(@e, ' old sal '+cast(@s as varchar(10)) + ' new sal ' + cast(@ns as varchar(10)) + ' old name '+ cast(@n as varchar(20)) + ' new name ' + cast(@nn as varchar(20)))
end

-- if salary > 10000 roll back else updated in audit and emps
-- 

update emps set sal=10, ename='newname' where eid = 1;
select * from update_audit;
sp_rename 'pro_crud', 'ProCrud' 
sp_helptext 'pro_crud'
sp_help logerror