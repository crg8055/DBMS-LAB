create database Supplier;
use Supplier;

create table Suppliers(
  sid int primary key,
  sname varchar(20),
  city varchar(30)
);

create table Parts(
  pid int primary key,
  pname varchar(20),
  color varchar(20)
);

create table Catalog(
   sid int,
   pid int,
   cost real,
   primary key(sid,pid),
   foreign key(sid)references Suppliers(sid) on delete cascade,
   foreign key(pid)references Parts(pid) on delete cascade
);

insert into Suppliers values('10001','Acme Widget','Bangalore'),
     ('10002','Johns','Kolkota'),
     ('10003','Vimal','Mumbai'),
     ('10004','Reliance','Delhi');
     
insert into parts values('20001','Book','Red'),
     ('20002','Pen','Red'),
     ('20003','Pen','Green'),
     ('20004','Mobile','Green'),
     ('20005','Charger','Black');

insert into catalog values('10001','20001','10'),
     ('10001','20002','10'),
     ('10001','20003','30'),
     ('10001','20004','10'),
     ('10001','20005','10'),
     ('10002','20001','10'),
     ('10002','20002','20'),
     ('10003','20003','30'),
     ('10004','20003','40');
     
/* 1. Find the SID of Suppliers who supply some RED or GREEN parts*/
select distinct(suppliers.sid) 
from Suppliers,parts,catalog
where  suppliers.sid = catalog.sid and parts.pid = catalog.pid and parts.color in('red','green');

/* 2. Find the SID of Suppliers who supply some RED parts or whose city is BANGALORE*/
select distinct(suppliers.sid)
from Suppliers,parts,catalog
where Suppliers.sid = catalog.sid and parts.pid = catalog.pid and parts.color = 'red' or suppliers.city='bangalore';

/* 3. Find pairs of SID such that the suppliers with the first SID charges more for some part than the supplier with the second SID. */
select s1.sid, s2.sid, p1.pid 
from suppliers s1, suppliers s2, parts p1, catalog c1, catalog c2
where s1.sid = c1.sid and s2.sid = c2.sid and p1.pid = c1.pid and p1.pid = c2.pid and c1.cost > c2.cost;
