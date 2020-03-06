create database db_1BM19CS402; 
use db_1BM19CS402;

create table person
(driver_id varchar(10), 
name varchar(10), 
address varchar(30),
primary key(driver_id)
);
 


create table car
(reg_num varchar(15)primary key,
model varchar(10),
year int
);

create table owns 
(driver_id varchar(10),
reg_num varchar(15),
primary key(driver_id,reg_num),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num)
);

create table accident
(report_num int primary key,
accident_date date,
location varchar(20)
);

create table participated
(driver_id varchar(10),
reg_num varchar(15),
report_num int,
damage_amount int,
primary key(driver_id,reg_num, report_num),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num),
foreign key(report_num)references accident(report_num)
);

show tables;

insert into person values('A01','Richard','Srinivas Nagar');
insert into person values('A02','Pradeep','Rajajinagar');
insert into person values('A03','Smith','Ashok Nagar');
insert into person values('A04','Venu','N R Colony');
insert into person values('A05','John','Hanumanth Nagar');

insert into car values('KA052250','Indica','1990'),
('KA031181','Lancer','1957'),
('KA095477','Toyota','1998'),
('KA053408','Honda','2008'),
('KA041702','Audi','2005');

insert into owns values('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');

insert into accident values('11','2003-01-01','Mysore Road'),
('12','2004-02-02','South End Circle'),
('13','2003-01-21','Bull Temple Road'),
('14','2008-02-17','Mysore Road'),
('15','2005-03-04','Kanakpura Road');

insert into participated values('A01','KA052250','11','10000'),
('A02','KA053408','12','50000'),
('A03','KA095477','13','25000'),
('A04','KA031181','14','3000'),
('A05','KA041702','15','5000');

/*QUERY-06/03/2020*/

/*List the names of Drivers whose damage is greter than the avg damage amount*/
select person.name
from person,participated
where person.driver_id = participated.driver_id and damage_amount>(
                                                                    select avg(damage_amount)
                                                                    from participated 
																                                                  );













