CREATE TABLE CUSTOMER(Cust_id int, Cust_name varchar(20))

Create table orders(otder_id int, order_name varchar(20))

insert into CUSTOMER values(100,'Sanjay')

insert into CUSTOMER values(200,'Raj')

insert into CUSTOMER(Cust_id) values(300)

insert into CUSTOMER(Cust_id,Cust_name) values(300,'vijay')

insert into CUSTOMER(Cust_name,Cust_id) values('maher',400)

insert into CUSTOMER(Cust_name,Cust_id) values('Raju',500),('shyam',600),('Ashok',700),('mehesh',800)

select * from CUSTOMER

alter table CUSTOMER add Cust_add varchar(20)

alter table CUSTOMER drop column Cust_add 

create table one(intc int)

insert into one values(1200),(1300),(1400)

alter table one alter column intc varchar(10)

insert into one values('Sanjay')

alter table one drop column intc

drop table one

truncate table one

create view v1
as select * from one

delegate v=func1;
v();
  
drop view v1
select * from v1


 

 use ProjectDb
select * from CUSTOMER
select  Cust_id,Cust_name from CUSTOMER
-- to display different heading in resultset col alias
select Cust_name  cname,Cust_id  cid from CUSTOMER
select Cust_name as cname,Cust_id as cid from CUSTOMER
select Cust_name 'customer name' , Cust_id 'cust id' from CUSTOMER

select * from CUSTOMER where Cust_name='Sanjay'
select Cust_name  'cname' from CUSTOMER
select * from customer where Cust_name='vijay' or Cust_name='Ram'

select * from customer where Cust_id>=100 and Cust_id<=300

select * from customer where Cust_id  between 100 and 300

select * from customer where Cust_id in (100,200,300)
select * from CUSTOMER where Cust_name not in('vijay', 'Ram')

select * from CUSTOMER where Cust_name!='Raj' and Cust_name!='sanjay'

select * from customer where Cust_id>400 and Cust_name='shyam'

select * from CUSTOMER where Cust_name not like 'R%'

select * from CUSTOMER where Cust_name like 'R%'

select * from CUSTOMER where Cust_name like '_i%'

select * from CUSTOMER where Cust_name like '%y_m'

select * from CUSTOMER where Cust_name like '_____'
select * from CUSTOMER where Cust_name like 's%' or Cust_name like 'A%'

select * from CUSTOMER where Cust_name like '[r,a]%'


select * from CUSTOMER where Cust_name not like '[r,a]%'

select * from CUSTOMER where Cust_name  like '[^r,a]%'
select * from CUSTOMER where Cust_name like '[v,m][i,a,e]%[y,r]'
select * from CUSTOMER order by Cust_name
select * from CUSTOMER order by Cust_name desc
select * from CUSTOMER order by Cust_id desc

select * from CUSTOMER where Cust_name is null

select * from customer where Cust_id in (400,300) order by Cust_id asc,Cust_name desc

begin transaction
update CUSTOMER set cust_name='rajesh'
rollback

begin transaction
update CUSTOMER set cust_name='rajesh' where Cust_name is null 
rollback 

begin transaction
update CUSTOMER set cust_name='rajesh' , Cust_id=1
rollback 

begin transaction
delete from CUSTOMER where Cust_id=300
rollback

begin transaction
delete from CUSTOMER where Cust_name like 's%'
rollback



sp_help CUSTOMER

