use LabBook;

create table Customer(
	cid int unique not null,
	cname varchar(20) not null,
	add1 varchar(30),
	add2 varchar(30),
	cnumber varchar(12) not null,
	pcode varchar(10),
);



---------<Creating User Defined D_Type>---------
create type Region from varchar(15) ; -- create what ? -> Type, What should be its name -> Region, Using What -> varchar, Length -> 15


create procedure define
as 
begin 
	declare @add Region ;
	set @add = 'Andheri East Pump House'
end 

-- <Procedure{Several Queries in Single command}>

alter procedure define -- defining Procedure to declare and use the Region type data
as 
begin 
	declare @add Region ; -- declaraing the Region type data named add
	set @add = 'Andheri East' -- giving value to add
	print @add -- displaying add
end 

define -- executing the procedure 