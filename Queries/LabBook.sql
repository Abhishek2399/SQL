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
-- <Procedure{Several Queries in Single command}>

alter procedure define -- defining Procedure to declare and use the Region type data
as 
begin 
	declare @add Region ; -- declaraing the Region type data named add
	print @add -- displaying add
end 

drop procedure define ;
-- <Creating a Default> --
create default DefRegion as 'NA';

sp_bindefault DefRegion, Region ;

exec define ;


alter table Customer add custregion Region ;
alter table Customer add Gender char(1) ;

sp_help Customer;

alter table Customer 
add constraint ck_gnder check(Gender = 'M' or Gender = 'F' or Gender = 'T' );

alter table Customer 
drop constraint ck_gnder;

alter table Customer 
add constraint ck_gender check(Gender = 'M' or Gender = 'F' or Gender = 'T');


create table Orders(
	oid int not null check(oid>10000),
	cid int not null,
	odate Datetime,
	ostate char(1) check(ostate='P' or ostate = 'C')
);



