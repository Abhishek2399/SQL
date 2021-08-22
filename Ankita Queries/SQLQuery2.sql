insert into customer values(200,'anil')

select * from customer

alter table customer alter column cust_id int not null

alter table customer alter column cust_name varchar(20) not null

delete from customer where cust_name is null
-- colum level constraints
create table notnull(rno int not null)
insert into notnull values(null)

drop table notnull

--table level constraint

create table student(rno int not null)

insert into student values(45)

select * from student

drop table student

create table student(rno int unique not null)

insert into student values(null)

insert into student values(47)

drop table student

insert into student values(45)

create table student(rno int  primary key)

insert into student values(47)
insert into student values(null)
insert into student values(45)

select * from student

create table student(rno int  primary key,div int unique not null)

insert into student values(1)

drop table student

create table student(nrno int,sname varchar(20) default 'noname')


insert into student(nrno,sname) values(2,'anil')
insert into student(nrno) values(3)

drop table student
select * from student


create table cust(cid int check(cid>0 and cid<=100))

insert into cust values(100)

drop table cust

create table cust(cid int check(cid>0 and cid<=100) not null)

insert into cust values(null)



create table cust(cname varchar(20) check(cname in ('sunil','anil')))
insert into cust values('sunil')


select * from cust



create table cust(cname varchar(20) check(cname like 's%'))



create table cust(cname varchar(20) check(cname like '[s,a,t,d]%'))

create table dept(did int primary key,dname varchar(20))

insert into dept values(400,'ENQUIRY')

create table employee(eid int primary key,ename varchar(20),did int)

insert into employee values(2,'Raju',400)
select * from employee

select * from dept

drop table employee

create table employee(eid int primary key,ename varchar(20),did int foreign key references dept)

-- table level constraint

create table product(pid int,pname varchar(20),p_cost int,primary key(pid),check(pname like '%a%'))

drop table product

insert into product values(4,'motherboard',1700)

create table orders1(oid int,pid int,foreign key (pid) references product(pid))

insert into orders1 values(500,9)
-- to disable constraint
alter table orders Nocheck constraint FK__orders1__pid__3E52440B
-- to enable constraint
alter table orders check constraint FK__orders1__pid__3E52440B

select * from orders1
select * from product

drop table orders1

--table level user-defined named constraint

create table emp(eid int,constraint pkeid primary key(eid))

create table emp2(eid int, primary key(eid))

insert into emp2 values(1)

create table marks(rno int, s1 int,s2 int,constraint s1check check(s1>0 and s1<=100))
drop table marks
insert into marks values(1,0,200)
-- disable constraint
alter table marks nocheck constraint s1check

--enable constraint
alter table marks check constraint s1check

create table dummy(srno int constraint srno_nn not null,constraint srnocheck check(srno>10))

drop table dummy
insert into dummy values(null)
alter table  dummy drop constraint srno_nm
alter table dummy alter column srno int
select * from dummy 


create table def(did int,dname varchar(20) constraint dfc default  'defaultname')

insert into def(did) values(100)
alter table def alter column dname varchar(20)

alter table def  drop constraint dfc
drop table def

select * from def

create table prime(pkid int constraint primepk primary key)


alter table prime nocheck constraint primepk

alter index primepk on prime disable
alter index primepk on prime rebuild

insert into prime values(1)

alter table prime drop constraint primepk
alter table prime add constraint primepk1 primary key(pkid)

select * from prime
delete from prime

create table sales(cost decimal(5,2))
insert into sales values(310.678564)


select * from sales

select lower('ABC')

select * from CUSTOMER

select upper(cust_name) upr,lower(cust_name) lwr from CUSTOMER

select count(cust_name) from CUSTOMER


select LEFT('willson' , 3)
select RIGHT('willson',4)


select SUBSTRING('wilson',4,3)
select LEN('wilson')
select CONCAT('wil','son')
select CONCAT(cust_id,' ',cust_name) JN from CUSTOMER
select ASCII('A')
Y-MM-DD)
create table order2(oid int,o_name varchar(20), o_date  DATETIME)
insert into order2 values(4,'mouse','2021-07-21')

select * from order2

select char(87)

select charindex('s','wilson')

select patindex('%so%','wilson')
select patindex('%[i,o]%','wilson')

select replace('wilsonwil','wil','gab')

select rtrim('      wilson     ')
select ltrim('        wilson   ')

select getdate()

select year(getdate())


select DATEPART(quarter,'2014/09/12 09:23')

select dateadd(year,2,'2013/10/12')


select dateadd(year,-2,'2013/10/12')


select dateadd(month,3,'2013/10/12')

select datediff(year,'1998/06/27',getdate())

select CURRENT_TIMESTAMP

select abs(-24.654)


select round(1265.456,-3)

select ceiling(-1525.567)

select max(cust_id),min(cust_id),count(cust_id),sum(cust_id),avg(cust_id) from customer


select cast(200.45 as int)

select cast(200.45 as float)

select cast('2019-05-05' as datetime)


select convert(int ,200.45)

select convert(float ,200.45)

select convert(datetime ,'2019-05-05')

declare @v int
set @v=30
select case @v 
		when 10 then 'value is 10'
		when 20 then 'value is 20'
		when 30 then 'value is 30'
		else 'other value'
end

select * from CUSTOMER


select cust_id,case cust_id when 200 then 'cust-id is 200'
							when 300 then 'cust-id is 300'
							else 'other cust-id'end as query 
							from CUSTOMER



create table newtable(eno int)

insert into newtable values(null)


select * from newtable


select isnull(null,'subt')
select isnull(eno,999) from newtable

select count(eno) from newtable


select count(isnull(eno,1)) from newtable

select nullif('abc','abx')

select nullif(10,110)

select isdate('2021-12-3')

select isdate('1999')

select isnumeric(10+30)



