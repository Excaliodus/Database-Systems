use q1

--q2(1)


select t.id,t.Name,count(*)
from TrafficWarden t,challan c
where t.id=c.TrafficWardenid
group by t.id,t.Name
having count(*)>=All(select count(*)
					 from TrafficWarden t2,challan c2
				     where t2.id=c2.TrafficWardenid
					 group by t2.id
					 except
					 select count(*)
					from TrafficWarden t,challan c
					where t.id=c.TrafficWardenid
					group by t.id
					having count(*)>=All(select count(*)
										 from TrafficWarden t2,challan c2
										 where t2.id=c2.TrafficWardenid
										 group by t2.id
										 ))


--2
select t.*
from TrafficWarden t, challan c
where t.id=c.TrafficWardenid and MONTH(c.ChallanDate)=1 and Year(c.ChallanDate)=2018
intersect
select t.*
from TrafficWarden t, challan c
where t.id=c.TrafficWardenid and MONTH(c.ChallanDate)=1 and Year(c.ChallanDate)=2020

--3
select p.Name,sum(c.amount) as totalamount
from Person p,challan c
where p.id=c.personid
group by p.Name
having sum(c.amount)>=All(select sum(c2.amount)
from Person p2,challan c2
where p2.id=c2.personid
group by p2.id
)

--4
select distinct t.Name
from TrafficWarden t,challan c, Person p
where t.id=c.TrafficWardenid and c.personid=p.id and p.city='Lahore'

--5
create view q5
as 
select p.Name as PersonName, t.Name as WardenName, count(*) as NumOfChallans
from Person p,challan c, TrafficWarden t
where p.id=c.personid and c.TrafficWardenid=t.id and Year(ChallanDate)>=2020
group by p.Name,t.Name
having count(*)>1
go
