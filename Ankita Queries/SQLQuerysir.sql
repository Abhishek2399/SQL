sp_help customer

 

insert into customer values(200,null)

 

select * from customer

 

alter table customer alter column cust_name varchar(20) not null

 

delete from customer where cust_name is null
-- column level constraint
create table notnull(rno int not null)
insert into notnull values(null)

 

drop table notnull
--table level constraint 

 

create table student(rno int,sname varchar(20) default 'noname' )

 

insert into student(rno,sname) values(2,'anil')
insert into student(rno) values(3)

 

insert into student values(1)

 

drop table student
select * from student

 


create table cust(cid int check(cid>0 and cid<=100) not null )

 

create table cust(cname varchar(20) check(cname in('sunil','anil'))  )

 

create table cust(cname varchar(20) check(cname like 's%')  )

 

create table cust(cname varchar(20) check(cname like '[s,a,t,d]%'))

 

 

drop table cust
insert into cust values('tyson')

 


create table dept(did int primary key,dname varchar(20))

 

insert into dept values(300,'SALES')

 

create table employee(eid int primary key,ename varchar(20),dept_id int foreign key references dept(did) )

 

insert into employee values(4,'surya',500)
select * from employee
drop table employee
select * from dept

 

-- table level constraint

 

create table product(pid int,pname varchar(20),p_cost int,primary key(pid),check(pname like '%a%'))

 

drop table product

 

insert into product values(3,'motherboard',15000)

 

select * from product
-- table level constraint
create table orders(oid int,pid int,foreign key(pid) references product(pid))

 

insert into orders values(500,5)
--to disable any constraint 
alter table orders Nocheck constraint FK__orders__pid__69279377

 

-- to enable any constraint
alter table orders check constraint FK__orders__pid__69279377
select * from orders
drop table orders

 

--table level user-defined named constraint
create table emp(eid int,constraint pkeid primary key(eid))

 

create table emp2(eid int,primary key(eid))

 

insert into emp2 values(1)

 

alter table emp drop constraint pkeid

 


create table marks(rno int,s1 int,s2 int,constraint s1check check(s1>0 and s1<=100))

 

insert into marks values(3,101,-12)

 

--disable constraint 
alter table marks nocheck constraint s1check

 

--enable constraint 
alter table marks check constraint s1check

 

create table dummy(srno int constraint srno_nn not null,constraint srnocheck check(srno>10))

 

drop table dummy
insert into dummy values(2)
alter table dummy drop constraint srno_nn
alter table dummy alter column srno int

 

create table def3(did int,dname varchar(20) constraint dfc default 'defaultname')

 

insert into def3(did) values(200)
alter table def alter column dname varchar(20)

 

alter table def2 drop constraint dfc
select * from def3

 


create table prime(pkid int constraint primepk primary key)

 


alter table prime nocheck constraint primepk

 

alter index primepk on prime disable
alter index primepk on prime rebuild

 

insert into prime values(1)

 

alter table prime drop constraint primepk

 

select * from prime
delete from prime

 

alter table prime add constraint primepk1 primary key(pkid)

 