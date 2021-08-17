
-- DDL
-- Create query is used to create objects of sql 
-- Create table will create a table with given table name and field 
-- Syntax create table <table name>(fields or tables_name <data type>)
-- Rows in tables are also called "tupples"
create table Customers(
cust_id int,
cust_name varchar(20),
);

--eg: Creating an ORders table with order_ID
create table Orders(
order_ID int,
); 

-- DML
-- Filling/Inserting Data
-- Insert command to insert the data 
-- Data can only be inserted in table 
-- Syntax insert into <table_name> values(as per the order write the data directly)
insert into Customers values(100, 'Abhishek');
insert into Customers values(102, 'Anil');

-- insert into Customers values(102); following will give an error as both of the fields are necessary in the following command 
-- another way 
insert into Customers(cust_id) values(300); -- following command is used for specific data 
insert into Customers(cust_id, cust_name) values(300, 'Ashwini'); -- following command is used for specific data 

-- insert multiple values 
insert into Customers(cust_id, cust_name) values(319, 'Ash'),(197, 'Aadi'),(121, 'Bhovar'); 

-- Alter command 
-- to alter the structure of the table 
-- adding updating removing cols form any table 
-- changing the data size of the cols in the table 

-- Syntax 
-- alter table <table_name> add <new_col_name>(field) adding new column 
alter table Customers add cust_addrs varchar(20);

-- alter table <table_name> alter column <col_name>(modified field) modifying a pre existing field in the table 
alter table Customers alter column cust_addrs varchar(100);



-- select query is used to get data from any specific table
-- Syntax select <Col_name> from <Table_name> -> to get the specified colm data from specified table
-- Syntax select * from <Table_name> -> to get data from all the colms in the specified table 
select * from Customers;
select cust_name from Customers;



--To get the structure of the table we have created 
--Syntax : sp_help <table_name>
sp_help Orders

sp_help Customers


