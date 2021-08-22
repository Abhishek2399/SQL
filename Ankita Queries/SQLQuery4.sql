begin
--select 'welcome'
print 'welcome'
end
select * from emps
--=>syntax checking
--===>plan
--=>execute query

create procedure prosql
as
begin
select * from emps
end

prosql -- simplification of query

EXEC PROSQL
EXCUTE PROSQL
PROSQL

create procedure norm
as
begin
DECLARE @i int;
set @i=10;

   print 'value of i ' + cast (@i as varchar(20))
end
--WHILE STATEMNT


declare @i int
set @i=1
while @i<=5 --declaring variable @i
begin
 print 'i: '+ cast (@i as varchar(20))
 set @i=@i+1--increment
end


--IF STATEMENT
declare @i int
set @i=15

begin
   IF(@I<10)
      print 'GREATER THAN 10'
	else
	  print 'less than 10'
 
end

sp_helptext prosql

select * from emps
--creation of procedure
create procedure pro_select2(@peid int,@psal int)
as
begin
	select * from emps where eid=@peid or sal>@psal
end

select * from emps
pro_select2 3,1500
pro_select 11

execute pro_select 2


create procedure pro_insert(@peid int,@pn varchar(20),@pdid int,@psal int ,@pmgr int)
as
begin
     insert into emps values(@peid,@pn,@pdid,@psal,@pmgr)
end

select * from emps
pro_insert 34,'ganesh',100,1400,2

create procedure pro_delete(@peid int)
as
begin
     delete from emps where eid=@peid 
end
pro_delete 34


create procedure pro_update(@pid int,@pname varchar(20))
as
begin
     update emps set ename=@pname where eid=@pid
	 print 'record updated successfully'
end

select * from emps
pro_update 10,'jay'


alter procedure pro_sec(@pdid int=10,@pid int=10)
as
begin
	select * from emps where did=@pdid
end

pro_spec


create procedure pro_simp(@p int out)
as
begin
	set @p=1000;
end

declare @pp int
 exec pro_simp @pp out
print @pp


-- create a procedure to diplay ename dname 

create procedure pro_ename1
as
begin
	select eid,ename,dname from emps join depts on emps.did =depts.did;
end

exec pro_ename1

select * from emps
select * from depts

-- square
create procedure square(@n int,@res int out)
as
begin
	set @res=@n * @n
end

declare @r int
exec square 2,@r out
print 'square :' + cast(@r as varchar(20))

--
create procedure pro_crud(@task varchar(10),@peid int,@pename varchar(20)=null,@pdid int=null,@psal int=null)
--with encryption
--with recompile
as
begin
set nocount on
   if(@task='i')
      insert into emps values(@peid,@pename,@pdid,@psal)
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
exec pro_crud 'd',10

-- droping procedure
drop procedure pro_crud
--changing name
sp_rename 'proc_crud','pro_crud'

sp_rename 'empss' 'emps'

sp_helptext 'pro_crud'


-- handeling error
declare @d int;
declare @dv int;
begin
	set @dv=20;
	begin try
	set @d=@dv/4;
	print 'code after expresion'
	print @d
	end try
	begin catch
		--print 'cannot be divided by Zero'
		print Error_message()
	end catch
	print 'welcome Team'
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
		print error_number()
		print error_line()
		print error_state()
	end catch

	print 'after catch block'
end

create table dummy2(rno int primary key)
 create procedure pro_dum(@rn int)
 as
 begin
 begin try
  
 insert into dummy2 values(@rn)
 end try
 begin catch
 insert into logerror(en,em) values(error_number(),error_message())
 print'error'
 print error_number()
 end catch
 print 'after catch block'
 end
 drop table
 pro_dum 11
 create table logerror(en int,em varchar(20))




