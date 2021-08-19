use DemoProj;

create table depts(d_id int primary key, d_name varchar(20) not null, loc_id int);

create table location(loc_id int primary key, loc_name varchar(20));

create table emps(eid int primary key, ename varchar(20), d_id int , sal int, foreign key(d_id) references depts);


insert into location(loc_id, loc_name) values(222, 'INDIA'), (333, 'CANADA');

insert into depts(d_id, d_name, loc_id) values(100, 'HR', 333), (200, 'SALES', 222), (300, 'IT', 333), (400, 'MKT', 333);

insert into emps(eid, ename, d_id, sal) values(1, 'Sunil', 100, 12000);
insert into emps(eid, ename, d_id, sal) values (3, 'Anil', 300, 25000);

insert into emps(eid, ename, d_id, sal) values (2, 'Priyansh', 200, 25000), (4, 'Ashish', 400, 20000), (5, 'Priya', 300, 25000), (6, 'Ashutosh', 100, 55000), (7, 'Shubham', 100, 25000);
delete from emps where eid = 3;

select * from emps;
select * from depts;
select * from location;

-- Joins to get data from multiple tables at the same time 
--> Inner Joins {euqi, non-equi} "Matching joins in both tables"
--> Outer Joins {left, right} ""
--> Cross Joins
--> Self Joins 

--> Inner Join
select ename, d_name from emps join depts
on emps.d_id = depts.d_id;
-- get the ename from emps and dname from dept by joining both on the codition 
-- where the did in emps is equal to did in depts

-- Alias names
select ename, d_name, e.d_id  -- get what 
from emps e join depts d -- from where 
on e.d_id = d.d_id; -- how to join 

-- joining more than 2 tables 
select ename, loc_name 
from emps e join depts d on e.d_id = d.d_id
join location l on l.loc_id = d.loc_id;

-- if we want matched as well as un matched records 
-- inner join only shows matched records
-- hence we need to use outer join {left, right, full}

-- Remember this Query for left and right 
-- select * from emps, depts where emps.d_id = d.d_id

--> Left 
select ename, e.d_id, sal, d_name
from emps e left outer join depts d on 
e.d_id = d.d_id;

--> Right
select ename, e.d_id, sal, d_name
from emps e right outer join depts d on 
e.d_id = d.d_id;

--> Full
select ename, e.d_id, sal, d_name
from emps e outer join depts d on 
e.d_id = d.d_id;


truncate table grade;
create table grade(minsal int , maxsal int, grd char(1));
insert into grade(minsal, maxsal, grd) values(500, 10000, 'D'), (10001, 20000, 'C'),(20001, 40000, 'B'), (40001, 100000, 'A'); ;


delete from grade where minsal = 5000 and maxsal = 100000;

select * from depts;
select * from grade;
select * from emps;

-- how to join with no direct realtionship or common colm
-- non equi joins 
select ename, sal, grd 
from emps e join grade g 
on e.sal between g.minsal and g.maxsal;


-- most of the times cross join incorrect or invalid query 
-- sometimes we need cross joins 
select ename, d_name from emps cross join depts; -- a join without where condition is always cross join

-- Self Join 
-- information in the same table 
-- we want to get the emps working in the same department 
-- hence we need to check if different employees have the same dept. id

select s1.ename, s2.d_id, s2.eid 
from emps s1, emps s2
where s1.d_id = s2.d_id and s1.eid != s2.eid;

select * from emps ;
