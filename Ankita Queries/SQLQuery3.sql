create table depts(did int primary key,dname varchar(20) not null,loc_id int)

create table location(loc_id int primary key,loc_name varchar(20))

create table emps(eid int primary key,ename varchar(20),did int,sal int,foreign key(did)references depts)

insert into location values(114,'Australia')

drop table location

insert into depts values(800,'ABD',119)


insert into emps values(9,'prakash',100,1900,2),(10,'Rishi',500,1500,1)


select * from emps

select * from depts

select *from location

-- inner join

select ename,dname,emps.did from emps join depts on emps.did = depts.did

select ename,dname,e.did from emps e join depts d on e.did = d.did

select ename,dname,e.did from emps e inner join depts d on e.did = d.did

select ename,dname,e.did from emps e , depts d where e.did = d.did

select ename,loc_name from emps e join depts d on e.did=d.did join location l on d.loc_id=l.loc_id


select * from emps
select ename,e.did,sal,dname from emps e, depts d where e.did=d.did

---outer join 
select ename,e.did,sal,dname from emps e  left outer join depts d on e.did=d.did



select ename,e.did,sal,dname from emps e  right outer join depts d on e.did=d.did




select ename,e.did,sal,dname from emps e  full outer join depts d on e.did=d.did

--non equi join of inner join

create table grade(minisal int,maxsal int,grd char(1))


insert into grade values(500,1000,'D')

select * from grade
select * from emps


select ename,sal,grd from emps e join grade g on e.sal between g.minisal and g.maxsal

-- cross join
select ename,dname from emps,depts

-- self join 
select s1.ename,s2.did,s2.eid from emps s1,emps s2 where s1.did=s2.did and s1.eid!=s2.eid

select  e.eid , e.ename en, m.ename mn,m.eid mgid from emps e join emps m on e.mgr=m.eid
select * from emps


-- adding another column to emps
alter table emps add mgr int

--updating emps table
update emps set mgr=1 where eid=7


-- how to create a group
select * from emps
select did,min(sal) minisal,max(sal) maxsal,count(*) totalemployees,sum(sal) totalsal,avg(sal) averagesal from emps group by did

-- selecting groups
select max(sal) maxsal,did from emps group by did  having  max(sal)<1500 
select * from emps
 
-- grouping sets
create table emphistory(eid int,ename varchar(20),did int,dt_of_switch datetime)

insert into emphistory values(4,'rajib',200,'2018-04-12')

update emphistory set did=400 where eid=5

select * from emps
select * from emphistory

-- for combining the result of one query with another query using "union all" and we can use only "union"  for erasing duplicate data=====if we want to use alliace name then it must be on the first query(orde of column is important)

select eid empcode,ename empname from emphistory union all
select eid,ename from emps

--intersect operator(orde of column is important)

select eid empcode,ename empname from emphistory intersect
select eid,ename from emps

--except operator(order of column is importan)

select eid empcode,ename empname from emphistory except
select eid,ename from emps

select eid empcode,ename empname from emps except
select eid,ename from emphistory



---subquery
select * from emps

select did from emps where ename='manish' 


select * from emps where did=(select did from emps where ename='manish') and ename!='manish'


select * from emps where did=100 and ename<>'manish'

select * from emps where did in (select did from emps where ename='rajib')
 
select * from emps where did >all (select did from emps where ename='rajib')
 
 select * from emps where did >any (select did from emps where ename='rajib')

 select * from emps where did <all (select did from emps where ename='rajib')

 select * from emps where did <any (select did from emps where ename='rajib')

 select * from emps where did =all (select did from emps where ename='rajib')

 select * from emps where did =any (select did from emps where ename='rajib')

 -- to find the employee data earning greater than average salary

 select avg(sal) from emps
 select * from emps where sal > 2237

 --subquery
 select * from emps where sal > (select avg(sal) from emps) 
 
 -- to find out the employee data working in INDIA
 
  select * from location

 select * from emps where did  in (select did from depts where loc_id= (select loc_id from location where loc_name='India') )

 --create table login
 create table login(uid int,pwd varchar(20))
 insert into login values(1,'p'),(2,'w')

 select * from emps where exists(select * from login where uid=2)

 select max(sal) from emps

 select ename,sal from emps where sal=(select max(sal) from emps)

 --select oq.ename,(select max(sal) from emps sq where sq.eid=oq.eid) subq from emps

 --find all employee details who work in a particular departtment


 --using joining
 select ename,emps.did from emps join depts on emps.did=depts.did



 --using subquery
 select ename,did from emps where did in (select did from depts)



 --using corelated subquery
 select ename,did from emps where exists(select * from depts where depts.did=emps.did)

 select ename,did from emps where not exists(select * from depts where depts.did=emps.did)


 --add one more column in emps table as project id and create another table project id


 create table project(pid int,eid int,pname varchar(20))


 insert into project values(777,5,'HR project')
 select * from project

 --find the detail of employee working on project
 --using corelated subquery

 select ename,eid from emps oq where  exists(select * from project cq where cq.eid=oq.eid)

 -- second max salary
 --using subquery
 select  ename,sal from emps where sal=(select max(sal) from emps where sal<(select max(sal) from emps))

 --using corelated subquery
 select sal,ename from emps oq where 2=(select count(sal) from emps cq where cq.sal > oq.sal)

 select sal from emps

 -- top 3 salaries

 select top 3 sal,ename from emps order by sal desc

  select top 5 with ties sal,ename from emps order by sal desc

  --using subquery and top
  select max(sal) from(select top 3 ename,sal from emps order by sal asc) as tbl

  --using top for nth highest salary
   select top 1 sal from(select top 3 ename,sal from emps order by sal asc) as tbl order by tbl.sal

   select * from emps

   --didplay from 4th record using offset keyword,fetch clause,only keyword
   select * from emps order by eid offset 5 rows fetch next 1 rows only

   select * from emps order by sal desc offset 0 rows fetch next 6 rows only

   --statements,transict sql
   declare @i int
   set @i=10;

   begin
   if(@i>50)
		print 'greater than 50'

   else	
		select 'less than 50'
   end


 --create two table product and store ,in product table pr5oduct id and product name,descriptio,cost and in store table st_id,pid,quantity

 create table product1(pid int primary key,pname varchar(20) not null,description varchar(20),cost int)

 create table store(st_id int primary key,pid int,quantity int,foreign key(pid) references product1)

 insert into product1 values(5,'bowl','utensils',100)

 insert into store values(5,4,10)


 select * from product1
 select * from store





