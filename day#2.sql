use DemoProj;

-- Constraints:  Rules to get efficient working of the data base 
-- Accuracy, Consistency, Reliability and Validity of data is taken care by the Constraint
-- Types: {Primary Key, Unique, Foreign Key, Not Null, Check, Default}

insert into Customers(cust_id, cust_name) values (200,  null);

-- In RDBMS no two rows should be same 
select * from Customers;

alter table Customers alter column cust_id int not null; -- not null constraint for cust_id
-- as we dont want cust_id to be null

-- this wont allow the following entry as the id we have passed is null
-- constraint for the cust_id is not null
insert into Customers(cust_id, cust_name) values (null,  'Abhishek');

delete from Customers where cust_id is null;-- this will delete all the records with null entries
delete from Customers where cust_name is null;-- this will delete all the records with null entries

alter table Customers alter column cust_name varchar(30) not null;

-------- <Creating new Table for applying Constarints>------------
-------- <Column Level>-----------
--- Not Null Costraint
create table ConstraintEg(
	rollNo int not null,
	studName varchar(20) not null,
);

--- Unique constraint 
-- will not allow redundant entry for the table specified 
create table UniqueName(
	Name varchar(50) unique -- only unique values with no null value throught the column if not specified "not null"
);

insert into UniqueName(Name) values('Abhi'), ('Alka'), ('Rahul');
select * from UniqueName;

insert into UniqueName(Name) values('Abhi'); -- will not allow as 'abhi' is already present in the DB
select * from UniqueName;

-- if we want not null as well as unique 
drop table UniqueName;
create table UniqueName(
	Name varchar(50) unique not null -- only unique values with one null value throught the column if not specified "not null"
);
insert into UniqueName(Name) values('Abhi'), ('Alka'), ('Rahul');
select * from UniqueName;

insert into UniqueName(Name) values('Abhi'); -- will not allow as 'abhi' is already present in the DB
select * from UniqueName;

insert into UniqueName(Name) values(null); -- will not allow as null values not allowed 
select * from UniqueName;


-- Primary Key constraint 
-- {not null + unique} can be achieved with one single constraint -> primary key
-- only one Primary key allowed throught the table 
drop table UniqueName;
create table UniqueName(
	Name varchar(50) primary key-- only unique values with one null value throught the column if not specified "not null"
);
insert into UniqueName(Name) values('Abhi'), ('Alka'), ('Rahul');
select * from UniqueName;

insert into UniqueName(Name) values('Abhi'); -- will not allow as 'abhi' is already present in the DB
select * from UniqueName;

insert into UniqueName(Name) values(null); -- will not allow as null values not allowed 
select * from UniqueName;

-- we can use primary key in one column and unique + not null in another column 
drop table UniqueName;
create table UniqueName(
	ID int primary key,
	Name varchar(50) not null unique, -- allowed
	-- pin int primary key -- not allowed
);

-- Default entry 
-- if we might miss any entry we want some default value to be present 
drop table UniqueName;
create table UniqueName(
	ID int primary key,
	Name varchar(50) default 'NoName', -- if no name given value woud be default 
);

insert into UniqueName(ID, Name) values(3, 'Abhi'), (1, 'Alka'), (2, 'Rahul');
select * from UniqueName;

insert into UniqueName(ID) values(4); -- as name not given we will get def. value for id-4 entry i.e. 'NoName'
select * from UniqueName;

-- Check Constraint 
-- Validity of data 
drop table Orders;
create table Orders(
	id int primary key,
	price int check(price>0 and price < 2000)
);

-- allowed as the price is in range of 0 to 2000
insert into Orders(id, price) values(1, 1000);
select * from Orders;

insert into Orders(id, price) values(2, 1030);
select * from Orders;

-- not allowed as the price is in range but id is already present 
insert into Orders(id, price) values(1, 1030);
select * from Orders;

-- not allowed as the price is not in range of 0 to 2000
insert into Orders(id, price) values(3, 2001);
select * from Orders;

-- if we want to create a link in between two tables
-- we use Foreign Keys 

-- requirements -> 1. Table with primary key
--				-> 2. Another table consisting of same column name 

create table Depart(
	d_id int primary key,
	d_name varchar(20) not null
);

insert into Depart(d_id, d_name) values(100, 'SALES'), (200, 'ADVERTISEMENT'), (300, 'MARKETING');

create table Employees(
	e_id int primary key,
	e_name varchar(20), 
	d_id int foreign key references Depart
);

insert into Employees(e_id, e_name, d_id) values(1, 'Abhi', 200), (2, 'Rahul', 200);

---------< Table Level Constraints >---------
drop table Product ;
--- Functionality wise no difference ---
create table Product(
	pid int,
	pname varchar(20),
	pcost int, 
	primary key(pid),
	check(pname like '%a%') -- anywhere in the pname 'a' should be there 
);

insert into Product(pid, pname, pcost) values(2, 'speakers', 15000);
insert into Product(pid, pname, pcost) values(1, 'display', 10000);
insert into Product(pid, pname, pcost) values(3, 'motherboard', 20000);
insert into Product(pid, pname, pcost) values(3, 'something', 20000);

-- disable
alter table Product noCheck constraint PK__Product__DD37D91AE544C243; -- not allowed as this is primary

alter table Product noCheck constraint CK__Product__pname__4E88ABD4; -- <constarint name> from an invalid entry 

-- enable
alter table Product Check constraint PK__Product__DD37D91AE544C243; -- not allowed as this is primary 

alter table Product Check constraint CK__Product__pname__4E88ABD4;


select * from Product;

drop table Orders;
create table Orders(oid int, pid int);
-- while placing order we need to check if the Product is avaliable --
-- for this we need a pid to check availablity of the table
-- hence we need to give references
drop table Orders;
create table Orders(
	oid int primary key, 
	pid int,
	foreign key(pid) references Product 
);

insert into Orders values(500, 3);

-- table level user-defined named constraint
-- "constraint" keyword for using self defined name 
create table emp(eid int, constraint pkeid primary key(eid));
insert into emp(eid) values(1);
insert into emp(eid) values(1);


-- disabeling constraint 
-- alter table Orders Nocheck constraint <name of the constraint>; we can find the name with invalid entry 
-- enabling constraint 
-- alter table Orders check constraint <name of the constraint>; we can find the name with invalid entry 


drop table marks;
create table marks(rno int not null, constraint rCheck check(rno>0 and rno<76));
truncate table marks;

insert into marks(rno) values(1),(2),(74);
select * from marks;

-- disable 
alter table marks nocheck constraint rCheck
insert into marks(rno) values(79); -- as the constraint is disable we can insert the value larger than range 
select * from marks;

-- enable 
alter table marks check constraint rCheck
insert into marks(rno) values(80); -- as the constraint is enabled we can't insert the value larger than range 
select * from marks;

-- dropping a constraint 
-- except for not null and default we can drop contraints
alter table marks drop constraint rCheck;

-- dropping removing 
alter table marks alter column rno int;


create table prime(pkid int constraint primepk primary key);
alter table prime noCheck constraint primepk;

-- For DBA --
alter index primepk on prime disable -- not for query developer 
alter index primepk on prime disable -- not for query developer 
-- < > --

insert into prime values(1);
select * from prime
delete from prime
alter table prime add constraint primepk1 primary key(pkid)
pname char(10)(static type) toy (3) 10 bytes (7bytes)
char(4) non-unicode
varchar(10) toy 3bytes
nchar(4) unicode character toy 6
nvarchar(4)

int (4 bytes) -,+
Tinyint(1byte) (0-255)
smallint(2 bytes) (-32765 to 32765)
Bigint(8 bytes) - +
Decimal(p,s)
salary decimal(5,2) (18) 123.24 234.34(incorrect) (1)

create table sales(cost decimal(5,2))
insert into sales values(1103.234567)

drop table sales
 
select * from sales
salary smallmoney 4(bytes) -2134567890 2134567890
salary money 8(bytes) -923,456,789,111 923,456,789,111,111


dateofjoin date (yyyy/mm/dd)
dateofjoin datetime(yyyy/mm/dd hh:mm:ss.ms)

showtime time (hh:mm:ss.ms)

photo binary(8000 bytes)
photo varbinary(2gb)
select lower('ABC')

Single row
multiple row
use CUSTOMERDB 

SELECT * FROM CUSTOMER
 
SELECT UPPER(CUST_NAME) UPR,LOWER(CUST_NAME) LWR FROM CUSTOMER

 SELECT LEFT('WILSON',3)
 SELECT RIGHT('WILSON',3)

 SELECT SUBSTRING('WILSON',4,3)
 SELECT LEN('WILSON')


  SELECT CONCAT('WIL','SON')
  SELECT CONCAT(CUST_ID,CUST_NAME) JN FROM CUSTOMER

  SELECT COUNT(CUST-NAME) FROM CUSTOMER

  SELECT ASCII('Xbc')
  Select char(87)
  select charindex('i' , 'wilson')

  select patindex('%so%' ,'wilson')
  select patindex('%[i,o]%','wlson')
  select replace('wilson','wil','gib')--only 3 parameters can be passed
  select rtrim('wilson ')
  select ltrim(' wilson')
  select getdate()
 select year (getdate())
  select month(getdate())
  select day(getdate())
  select datepart(year,'2018/8/2')--to extract part use datepart
  select datepart(hour,'2018/8/2 4:47')
  select datepart(minute,'2018/8/2 4:47')
  select datepart(quarter,'2018/8/2 4:47')
  select dateadd(year,2,'2018/8/2')-- to add month,year,dateusing dateadd
  select dateadd(day,2,'2018/8/2')
  select dateadd(month,2,'2018/8/2')
  select dateadd(year,-2,'2018/8/2')

  select datediff(year,'1999/06/23',getdate())--to find difference b/w 2 dates
  select datediff(month,'1999/06/23',getdate())
  select datediff(day,'1999/06/23',getdate())

  select abs(-25.456)
  select round(155.456,-2)--round value is whole amount like 100 /200

  select floor(1564.1) --giving natural num and if negative value in will round 
  select * from customer
  select max (cust_id) mx ,min(cust_id) mn,count(cust_id) count,sum(cust_id) total, from customer 
  select cast(200.45 as int)
  select cast(200.45 as float)
  select cast(200.45 as varchar)
  select convert(int,200.45)--first data type and value
  declare @v int
   set @v = 10
   select case@v when 10
   when 20 then value is 
   else'other value'
   end
   select* from customer
   select cust_id,case cust_id when 200 then 'cust-id 200' 
                               when 300 then 'cust-id 300'
							   else 'other cust-id' end as query
							   from CUSTOMER
create table newtable(rno int)
insert into newtable values(900)
select *from newtable
 select isnull(null,'subt')
 select isnull(rno,999) from  newtable
 select sum(rno) from newtable 
 select count(isnull(rno,1) )from newtable
 select nullif('abc','abx')
 select nullif(1,1)
 select isdate('2021')
 select isnumeric('10+30')select * from prime
delete from prime
alter table prime add constraint primepk1 primary key(pkid)
pname char(10)(static type) toy (3) 10 bytes (7bytes)
char(4) non-unicode
varchar(10) toy 3bytes
nchar(4) unicode character toy 6
nvarchar(4)

int (4 bytes) -,+
Tinyint(1byte) (0-255)
smallint(2 bytes) (-32765 to 32765)
Bigint(8 bytes) - +
Decimal(p,s)
salary decimal(5,2) (18) 123.24 234.34(incorrect) (1)

create table sales(cost decimal(5,2))
insert into sales values(1103.234567)

drop table sales
 
select * from sales
salary smallmoney 4(bytes) -2134567890 2134567890
salary money 8(bytes) -923,456,789,111 923,456,789,111,111


dateofjoin date (yyyy/mm/dd)
dateofjoin datetime(yyyy/mm/dd hh:mm:ss.ms)

showtime time (hh:mm:ss.ms)

photo binary(8000 bytes)
photo varbinary(2gb)
select lower('ABC')

Single row
multiple row
use CUSTOMERDB 

SELECT * FROM CUSTOMER
 
SELECT UPPER(CUST_NAME) UPR,LOWER(CUST_NAME) LWR FROM CUSTOMER

 SELECT LEFT('WILSON',3)
 SELECT RIGHT('WILSON',3)

 SELECT SUBSTRING('WILSON',4,3)
 SELECT LEN('WILSON')


  SELECT CONCAT('WIL','SON')
  SELECT CONCAT(CUST_ID,CUST_NAME) JN FROM CUSTOMER

  SELECT COUNT(CUST-NAME) FROM CUSTOMER

  SELECT ASCII('Xbc')
  Select char(87)
  select charindex('i' , 'wilson')

  select patindex('%so%' ,'wilson')
  select patindex('%[i,o]%','wlson')
  select replace('wilson','wil','gib')--only 3 parameters can be passed
  select rtrim('wilson ')
  select ltrim(' wilson')
  select getdate()
 select year (getdate())
  select month(getdate())
  select day(getdate())
  select datepart(year,'2018/8/2')--to extract part use datepart
  select datepart(hour,'2018/8/2 4:47')
  select datepart(minute,'2018/8/2 4:47')
  select datepart(quarter,'2018/8/2 4:47')
  select dateadd(year,2,'2018/8/2')-- to add month,year,dateusing dateadd
  select dateadd(day,2,'2018/8/2')
  select dateadd(month,2,'2018/8/2')
  select dateadd(year,-2,'2018/8/2')

  select datediff(year,'1999/06/23',getdate())--to find difference b/w 2 dates
  select datediff(month,'1999/06/23',getdate())
  select datediff(day,'1999/06/23',getdate())

  select abs(-25.456)
  select round(155.456,-2)--round value is whole amount like 100 /200

  select floor(1564.1) --giving natural num and if negative value in will round 
  select * from customer
  select max (cust_id) mx ,min(cust_id) mn,count(cust_id) count,sum(cust_id) total, from customer 
  select cast(200.45 as int)
  select cast(200.45 as float)
  select cast(200.45 as varchar)
  select convert(int,200.45)--first data type and value
  declare @v int
   set @v = 10
   select case@v when 10
   when 20 then value is 
   else'other value'
   end
   select* from customer
   select cust_id,case cust_id when 200 then 'cust-id 200' 
                               when 300 then 'cust-id 300'
							   else 'other cust-id' end as query
							   from CUSTOMER
create table newtable(rno int)
insert into newtable values(900)
select *from newtable
 select isnull(null,'subt')
 select isnull(rno,999) from  newtable
 select sum(rno) from newtable 
 select count(isnull(rno,1) )from newtable
 select nullif('abc','abx')
 select nullif(1,1)
 select isdate('2021')
 select isnumeric('10+30')
sp_help ConstraintEg;
sp_help Orders;



