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
create table emp(eid int, constraint pkeid primary key(eid));

-- disabeling constraint 
-- alter table Orders Nocheck constraint <name of the constraint>; we can find the name with invalid entry 
-- enabling constraint 
-- alter table Orders check constraint <name of the constraint>; we can find the name with invalid entry 






sp_help ConstraintEg
sp_help Orders



