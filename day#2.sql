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
drop table UniqueName;
create table UniqueName(
	Name varchar(50) primary key-- only unique values with one null value throught the column if not specified "not null"
);




sp_help ConstraintEg


