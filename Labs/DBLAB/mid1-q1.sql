create database q1
use q1

CREATE TABLE Person
(
id int NOT NULL primary key,
Name varchar(40),
age int,
city varchar(50)
);
CREATE TABLE challan
(
id int NOT NULL primary key,
personid int,
TrafficWardenid int,
amount int
);
CREATE TABLE TrafficWarden
(
id int NOT NULL primary key,
Name varchar(40),
city varchar(50),
[rank] varchar(50)
);

Alter Table challan add constraint FK_person foreign key (personid) references
Person (id) on delete cascade
Alter Table challan add constraint FK_warden foreign key (TrafficWardenid) references
TrafficWarden (id) on delete set null

alter table Person add LicenceNumber char(11) check(len(LicenceNumber)=11) unique;
alter table challan add ChallanDate date not null;
alter table challan add LastDate date not null;
alter table challan add constraint DEFAULT_Amount default 5000 for amount;


select p.Name, count(*) as numofChallans
from Person p,challan c
where p.id=c.personid
group by p.Name
having count(*)>(select avg(count(*))
				from Person p,challan c
				where p.id=c.personid
				group by p.Name)


