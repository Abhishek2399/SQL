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


