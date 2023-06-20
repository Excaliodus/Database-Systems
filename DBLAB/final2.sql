--Q1.
--1. Suppose that a problem is found with a product (item ID: “DTNTR”), and you want to know all
--the products made by the same vendor. write a query with join that find out which vendor
--creates item “DTNTR” and then find which other products are made by that vendor.
SELECT *
FROM products
WHERE vend_id =
(
SELECT vend_id
FROM products
WHERE prod_id = 'DTNTR'
GROUP BY vend_id
)
go
 
--2. Write a query to retrieve the list of all customers ids, names and total number of unique items ordered by each customer.
SELECT customers.cust_id, customers.cust_name, COUNT(Y.NIB) AS [Number of Unique Items Bought]
FROM (
	SELECT customers.cust_id, COUNT(orderitems.order_item) AS [NIB]
	FROM customers JOIN orders on customers.cust_id = orders.cust_id JOIN orderitems on orders.order_num = orderitems.order_num
	GROUP BY customers.cust_id, orderitems.order_item
) Y JOIN customers on Y.cust_id = customers.cust_id
GROUP BY customers.cust_id, customers.cust_name
go
                  
--3. Write a view to display the vendor id and name of those vendors whose items never sold
create view neverSold
as
SELECT vend_id,vendors.vend_name	
FROM vendors
EXCEPT
SELECT vendors.vend_id,vendors.vend_name
FROM vendors JOIN products on vendors.vend_id = products.vend_id
GROUP BY vendors.vend_id,vendors.vend_name
Go
 
--4. List Customer id and name of the customers who has ordered the most from the products of the vendor. Note: Only list top 1 if there are more than one ordered by customer id.
SELECT p1.vend_id, customers.cust_id, customers.cust_name, COUNT(p1.prod_id) AS [Number of Orders Places by Customer]
FROM customers join orders on customers.cust_id = orders.cust_id join orderitems on orders.order_num = orderitems.order_num
join products as p1 on orderitems.prod_id = p1.prod_id
WHERE p1.vend_id IN (
	SELECT vend_id
	FROM vendors
	WHERE EXISTS (
		SELECT Y.vend_id, MAX(Y.[Number of Orders Places by Customer])
		FROM(
			SELECT products.vend_id, customers.cust_id, customers.cust_name, COUNT(products.prod_id) AS [Number of Orders Places by Customer]
			FROM customers join orders on customers.cust_id = orders.cust_id join orderitems on orders.order_num = orderitems.order_num
			join products on orderitems.prod_id = products.prod_id
			WHERE products.vend_id = vendors.vend_id
			GROUP BY products.vend_id, customers.cust_id, customers.cust_name
		) Y
		GROUP BY Y.vend_id
	)
)
GROUP BY p1.vend_id, customers.cust_id, customers.cust_name
HAVING COUNT(*) = (
	SELECT MAX(Y.[Number of Orders Places by Customer])
	FROM(
		SELECT products.vend_id, customers.cust_id, customers.cust_name, COUNT(*) AS [Number of Orders Places by Customer]
		FROM customers join orders on customers.cust_id = orders.cust_id join orderitems on orders.order_num = orderitems.order_num
		join products on orderitems.prod_id = products.prod_id
		WHERE products.vend_id = p1.vend_id
		GROUP BY products.vend_id, customers.cust_id, customers.cust_name
	) Y
	GROUP BY Y.vend_id
)
Go

select cust_id, cust_name, noofOrders	
from
(select t1.vend_id, max(t1.noofOrders) as maxorders
from
(select vendors.vend_id, customers.cust_id, customers.cust_name, count(customers.cust_id) as noofOrders from customers inner join orders on customers.cust_id = orders.cust_id
inner join orderitems on orders.order_num = orderitems.order_num
inner join products on orderitems.prod_id = products.prod_id
inner join vendors on products.vend_id = vendors.vend_id
group by vendors.vend_id, customers.cust_id, customers.cust_name) as t1
group by t1.vend_id) as t2
inner join 
(select vendors.vend_id, customers.cust_id, customers.cust_name, count(customers.cust_id) as noofOrders from customers inner join orders on customers.cust_id = orders.cust_id
inner join orderitems on orders.order_num = orderitems.order_num
inner join products on orderitems.prod_id = products.prod_id
inner join vendors on products.vend_id = vendors.vend_id
group by vendors.vend_id, customers.cust_id, customers.cust_name) as t3
on t2.vend_id = t3.vend_id and t2.maxorders = t3.noofOrders
              
--UDF
--Write a user defined function that receives vendor id and return total number of products that vendor has in the store.

CREATE FUNCTION NoOfProducts(@vid int)
RETURNS INT
AS
BEGIN
RETURN(
	SELECT count(prod_id)
	FROM products
	WHERE vend_id = @vid
)
END
Go

--Report
--Create a VIEW to give a detailed report on all vendors. This report will include following columns:
--• Vendor ID and name
--• Total products
--• Total products that have been ordered (at least once), Note: count unique products that
--have been ordered at least once
--• Total products that have been never ordered

CREATE VIEW q3
AS
SELECT X.vend_id, X.[Total Number of Products], X.[Total Number of Products Ordered at least once], (X.[Total Number of Products] - X.[Total Number of Products Ordered at least once]) AS [Total Numbers of Products Never Ordered]
FROM (
	SELECT Y.vend_id, Y.[Total Number of Products], COUNT(orderitems.prod_id) AS [Total Number of Products Ordered at least once]
	FROM (
		SELECT vendors.vend_id, COUNT(*) AS [Total Number of Products]
		FROM vendors LEFT JOIN products on vendors.vend_id = products.vend_id
		GROUP BY vendors.vend_id
	) Y 
left join products on Y.vend_id = products.vend_id  left join orderitems on products.prod_id = orderitems.prod_id
	GROUP BY Y.vend_id, Y.[Total Number of Products]
) X
Go
 
 



--Q2.
--Surprise chashback
--Create a User defined function (UDF) “SurpriseCashBack” that prints the cash backs and total price of the orders for each customer. If a customer has made 3 or more orders, then 30% cash back will be given for all orders and all others who have made at least one order 10% cash back will be given for each order. Columns to return customer id, customer name, total price of order and cash back. Cash back is the percentage of total price of the order. Write statement to execute the UDF

CREATE FUNCTION SurpriseCashBack()
RETURNS TABLE
AS
RETURN (
	SELECT Y.cust_id, Y.cust_name, Y.[Total Price], (Y.[Total Price] * 0.3) AS [Cash Back]
	FROM (
		SELECT customers.cust_id, customers.cust_name, SUM(orderitems.quantity * orderitems.item_price) AS [Total Price]
		FROM customers JOIN orders on customers.cust_id = orders.cust_id JOIN orderitems on orders.order_num = orderitems.order_num
		GROUP BY customers.cust_id, customers.cust_name
	) Y 
join orders on Y.cust_id = orders.cust_id
	GROUP BY Y.cust_id, Y.cust_name, Y.[Total Price], (Y.[Total Price] * 0.3)
	HAVING COUNT(*) >= 3
	UNION
	SELECT Y.cust_id, Y.cust_name, Y.[Total Price], (Y.[Total Price] * 0.1) AS [Cash Back]
	FROM (
		SELECT customers.cust_id, customers.cust_name, SUM(orderitems.quantity * orderitems.item_price) AS [Total Price]
		FROM customers JOIN orders on customers.cust_id = orders.cust_id JOIN orderitems on orders.order_num = orderitems.order_num
		GROUP BY customers.cust_id, customers.cust_name
	) Y join orders on Y.cust_id = orders.cust_id
	GROUP BY Y.cust_id, Y.cust_name, Y.[Total Price], (Y.[Total Price] * 0.3)
	HAVING COUNT(*) >= 1 AND COUNT(*) < 3
)
go

select *
from SurpriseCashBack()
 
--ValidateOrderItems

--Write a TRIGGER named “ValidateOrderItems” such that whenever insertion is done on
--orderitems table, the original insert statement will not add the data in the orderitems table.
--Instead, our trigger will add the data. Before adding the data, it will check whether quantity is greater than 0 or not. If it is greater than 0, then data will be added, otherwise data will not be added. Also check if the order num is present in the order table or not. Print appropriate messages.

CREATE TRIGGER ValidateOrderItems ON orderitems
INSTEAD OF INSERT
AS
BEGIN
	DECLARE
	@i_order_num  INT,
	@i_order_item INT,
	@i_prod_id NCHAR(10),
	@i_quantity INT,
	@i_item_price MONEY
	
	SELECT
	@i_order_num = inserted.order_num,
	@i_order_item = inserted.order_item,
	@i_prod_id = inserted.prod_id,
	@i_quantity = inserted.quantity,
	@i_item_price = inserted.item_price
	FROM inserted

	IF EXISTS (
	SELECT *
	FROM orders
	WHERE order_num = @i_order_num)
	begin
		IF (@i_quantity > 0)
		begin
			INSERT INTO orderitems VALUES(@i_order_num, @i_order_item, @i_prod_id, @i_quantity, @i_item_price)
		end
		else
		print('Quantity is <= 0')
	end
	else
	print('Order Number does not exist')
END
go
--Trigger UpdateCustomers
--Write a TRIGGER named “UpdatedCustomer” which will fire whenever the customer table is updated. The trigger will display the old data as well as updated data of the customer. And also display the count of updated columns

CREATE TRIGGER UpdatedCustomer ON customers
AFTER UPDATE
AS
BEGIN
	DECLARE
	@old_cust_id INT,
	@old_cust_name NCHAR(50),
	@old_cust_address NCHAR(50),
	@old_cust_city NCHAR(50),
	@old_cust_state NCHAR(5),
	@old_cust_zip NCHAR(10),
	@old_cust_country NCHAR(50),
	@old_cust_contact NCHAR(50),
	@old_cust_email NCHAR(255)

	DECLARE
	@new_cust_id INT,
	@new_cust_name NCHAR(50),
	@new_cust_address NCHAR(50),
	@new_cust_city NCHAR(50),
	@new_cust_state NCHAR(5),
	@new_cust_zip NCHAR(10),
	@new_cust_country NCHAR(50),
	@new_cust_contact NCHAR(50),
	@new_cust_email NCHAR(255)

	SELECT
	@old_cust_id = deleted.cust_id,
	@old_cust_name = deleted.cust_name,
	@old_cust_address = deleted.cust_address,
	@old_cust_city = deleted.cust_city,
	@old_cust_state = deleted.cust_state,
	@old_cust_zip = deleted.cust_zip,
	@old_cust_country = deleted.cust_country,
	@old_cust_contact = deleted.cust_contact,
	@old_cust_email = deleted.cust_email
	FROM deleted

	SELECT
	@new_cust_id = inserted.cust_id,
	@new_cust_name = inserted.cust_name,
	@new_cust_address = inserted.cust_address,
	@new_cust_city = inserted.cust_city,
	@new_cust_state = inserted.cust_state,
	@new_cust_zip = inserted.cust_zip,
	@new_cust_country = inserted.cust_country,
	@new_cust_contact = inserted.cust_contact,
	@new_cust_email = inserted.cust_email
	FROM inserted

	SELECT *
	FROM deleted

	SELECT *
	FROM inserted

	DECLARE @count int
	SET @count = 0
	IF (@old_cust_id != @new_cust_id)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_name != @new_cust_name)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_address != @new_cust_address)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_city != @new_cust_city)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_state != @new_cust_state)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_zip != @new_cust_zip)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_country != @new_cust_country)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_contact != @new_cust_contact)
	begin
	 set @count = @count + 1
	end
	IF (@old_cust_email != @new_cust_email)
	begin
	 set @count = @count + 1
	end

	SELECT @count AS [Number of Updated Columns]

END
go
update customers
set 
	cust_name='farah',
	cust_address='abc',
	cust_city='lahore',
	cust_state='punj',
	cust_zip='5400',
	cust_country='Pakistan',
	cust_contact='087555',
	cust_email='fmunir@gmail.com'
	where cust_id=10004


--Transaction
--Write a transaction in a procedure which updates the quantity of a product. If no error occurs during the update commit the transaction else rollback. Set an isolation level for the transaction such that no other transaction can access this row during this process.

CREATE PROCEDURE q4
@on int,
@oi int,
@q int
AS
set TRANSACTION ISOLATION LEVEL REPEATABLE READ ;
begin TRANSACTION 
BEGIN TRY
UPDATE orderitems
SET orderitems.quantity = @q
WHERE order_num = @on AND order_item = @oi
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK
	END
END CATCH
COMMIT TRANSACTION

Go
