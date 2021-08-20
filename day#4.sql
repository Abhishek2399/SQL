USE CUSTOMER

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
	PRINT 'VALUE OF I'+ cast(@I as varchar)
END

ALTER procedure [DBO].[norm]
as

DECLARE @I INT;
SET @I=1;
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