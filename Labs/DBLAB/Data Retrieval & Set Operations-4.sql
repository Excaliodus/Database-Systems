

use Lab4

Create Table salesman(
salesman_id int not null,
name varchar(30),
city varchar(20),
commission float
);

Create Table orders(
ord_no int not null,
purch_amt float,
ord_date date,
customer_id int,
salesman_id int
);

Create Table customers(
customer_id int not null,
cust_name varchar(30),
city varchar(20),
grade int,
salesman_id int
);

alter table salesman add constraint PrimaryKey primary key (salesman_id)

alter table orders add constraint PrimaryKey_order primary key (ord_no)

alter table customers add constraint PrimaryKey_customers primary key (customer_id)

alter table orders add constraint FK_salesman foreign key (salesman_id) references salesman (salesman_id)

alter table orders add constraint FK_customers foreign key (customer_id) references customers (customer_id)

alter table customers add constraint FK2_salesman foreign key (salesman_id) references salesman (salesman_id)

select salesman_id, city
from salesman

select *
from customers
where city='New York'
order by cust_name

select name as full_name
from salesman

select *
from customers
where cust_name like '%John%' and (city='London' or city= 'Paris' or city ='New York')

select cust_name
from customers
where cust_name like '%a%'

select *
from orders
order by ord_date DESC

select *
from orders
where ord_date like '_____01___'

select c.*
from customers as c, orders as o
where o.ord_date like '2012______' and o.ord_date like  '2014______'


Select
   YEAR(ord_date) as year,
   month(ord_date) as month,
   day (ord_date) as day

from
    orders
where month(ord_date)=10;

select c.*
from customers as c, orders as o
where o.ord_date like '2012______' and o.ord_date not like '2014______' and c.customer_id=o.customer_id

select o.purch_amt*3 as purchase_amount
from orders as o
where month(ord_date)=10;

select commission + 0.5 
from salesman 
where city='San Jose'

select s.name,o.ord_date,s.commission
from salesman as s,orders as o
where s.salesman_id=o.salesman_id