create database BankingEnterprise;
use BankingEnterprise;

create table Branch(
  BranchName varchar(20),
  BranchCity varchar(20),
  Assets real,
  primary key(Branchname)
);

create table BankAccount(
   Accno real,
   BranchName varchar(20),
   Balance real,
   primary key(Accno,BranchName),
   foreign key(BranchName)references Branch(BranchName)
);

create table BankCustomer(
   CustomerName varchar(20),
   CustomerStreet varchar(20),
   City varchar(20),
   primary key(CustomerName)
);

create table Depositer(
   CustomerName varchar(20),
   Accno real,
   primary key(CustomerName,Accno),
   foreign key(CustomerName) references BankCustomer(CustomerName),
   foreign key(Accno) references BankAccount(Accno)
);

create table Loan(
   LoanNumber int,
   BranchName varchar(20),
   Amount real,
   primary key(LoanNumber,BranchName),
   foreign key(BranchName)references Branch(BranchName)
);

insert into Branch values('SBI_Chamrajpet','Bangalore','50000'),
    ('SBI_Residencyroad','Bangalore','10000'),
    ('SBI_ShivajiRoad','Bombay','20000'),
    ('SBI_ParlimentRoad','Delhi','10000'),
    ('SBI_JantarMantar','Delhi','20000');

insert into BankAccount values('1','SBI_Chamrajpet','2000'),
    ('2','SBI_Residencyroad','5000'),
    ('3','SBI_ShivajiRoad','6000'),
    ('4','SBI_ParlimentRoad','9000'),
    ('5','SBI_JantarMantar','8000'),
    ('6','SBI_ShivajiRoad','4000'),
    ('8','SBI_Residencyroad','4000'),
    ('9','SBI_ParlimentRoad','3000'),
    ('10','SBI_Residencyroad','5000'),
    ('11','SBI_JantarMantar','2000');

insert into BankCustomer values('Avinash','Bull_Temple_Road','Bangalore'),
    ('Dinesh','Bannergatta_Road','Bangalore'),
    ('Mohan','NationalCollege_Road','Bangalore'),
    ('Nikil','Akbar_Road','Delhi'),
    ('Ravi','Prithviraj_Road','Delhi');

insert into Depositer values('Avinash','1'),
    ('Dinesh','2'),
    ('Nikil','4'),
    ('Ravi','5'),
    ('Avinash','8'),
    ('Nikil','9'),
    ('Dinesh','10'),
    ('Nikil','11');

insert into Loan values('1','SBI_Chamrajpet','1000'),
    ('2','SBI_Residencyroad','2000'),
    ('3','SBI_ShivajiRoad','3000'),
    ('4','SBI_ParlimentRoad','4000'),
    ('5','SBI_JantarMantar','5000');

select * from Branch;
select * from BankAccount;
select * from BankCustomer;
select * from Depositer;
select * from Loan;

select CustomerName from Depositer group by CustomerName having count(*) >1

/* Find Find all the customers who have at least two deposits at the same branch */
Select C.customername 
from BankCustomer C
where exits(
select D.customername, count(D.customername)
                     from depositer D, BankAccount BA
                    where 
                          D.accno =BA.accno AND
                          C.customername =D.customername AND
                          BA.branchname =”SBI_ResidencyRoad”
                      Group by D.customername 
                       Having count(D.customername)>=2;
);

/*Find all the customers who have an account at all the branches located in a specific city (Ex. Delhi) */
select BC.customername
from BankCustomer BC
where not exists  (        select bracnhname from Branch where branchcity=‘Delhi’
                                minus
                                (select BA.branchname from Depositer D, BankAccount BA
                                  where D.accno=BA.accno and BC.customername=D.customername)
                               );

/*Demonstrate how you delete all account tuples at every branch located in a specific city (Ex. Bomay) */
 delete  from BankAccount
where branchname IN (
                                   select branchname
                                   from Branch
                                   where branchcity=‘BOMBAY’
                                      );
