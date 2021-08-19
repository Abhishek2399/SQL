use DemoProj;

create table depts(d_id int primary key, d_name varchar(20) not null, loc_id int);

create table location(loc_id int primary key, loc_name varchar(20));

create table emps(eid int primary key, ename varchar(20), d_id int , sal int, foreign key(d_id) references depts);


insert into location(loc_id, loc_name) values(222, 'INDIA'), (333, 'CANADA');

insert into depts(d_id, d_name, loc_id) values(100, 'HR', 333), (200, 'SALES', 222), (300, 'IT', 333), (400, 'MKT', 333);

insert into emps(eid, ename, d_id, sal) values(1, 'Sunil', 100, 12000);
insert into emps(eid, ename, d_id, sal) values (3, 'Anil', 300, 25000);

delete from emps where eid = 3;

select * from emps;
select * from depts;
select * from location;

-- Joins to get data from multiple tables at the same time 

