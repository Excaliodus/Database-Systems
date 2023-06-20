use Orders 

--Q1
Create Procedure q12 
@OrderNo int, 
@ItemNo int, 
@Quantity int 
as   
Declare @QuantityInStore int 
if exists(Select* from OrderDetails as o join Items as i on o.ItemNo=i.ItemNo where o.ItemNo=@ItemNo And o.OrderNo=@OrderNo and i.[Quantity in Store]<@Quantity)  
Begin  
	(Select @QuantityInStore=i.[Quantity in Store] from OrderDetails as o join Items as i on o.ItemNo=i.ItemNo where o.ItemNo=@ItemNo And o.OrderNo=@OrderNo and i.[Quantity in Store]<@Quantity)  
	print 'Only '+ CAST(@QuantityInStore as Varchar(max))+' is present, which is less than your required quantity'
End  
else 
Begin 
	Insert into OrderDetails values (@OrderNo,@ItemNo,@Quantity) 
	Update Items Set [Quantity in Store]=[Quantity in Store]-@Quantity where ItemNo=@ItemNo
End

Execute q12 
@OrderNo=3, 
@ItemNo=200, 
@Quantity=300

--Q2 

Create Procedure q2 
@CustomerNo varchar(2),
@OrderNo int
as   
Declare @CustomerName varchar(max)
if exists(Select* from [Order] where CustomerNo=@CustomerNo and OrderNo=@OrderNo)  
Begin   
	delete from OrderDetails where OrderNo=@OrderNo
	delete from [Order] where OrderNo=@OrderNo 
End  
else 
Begin  
	(Select @CustomerName=c.Name from [Order] o join Customers c on o.CustomerNo=c.CustomerNo where o.CustomerNo=@CustomerNo) 
	print  'Order '+ CAST(@OrderNo as Varchar(max))+ ' is not of '+ CAST(@CustomerNo as Varchar(max))+ ' ' +CAST(@CustomerName as Varchar(max))
End 

execute q2 
@CustomerNo='C3', 
@OrderNo=5

--Q3
Create View q1 as
select o.OrderNo,sum(i.Price*o.Quantity) as Price
from OrderDetails as o join Items as I on o.ItemNo=i.ItemNo 
group by o.OrderNo

create procedure q3 
@CustomerName nvarchar(max), 
@Points int output
as 
Begin 
	select @Points=table1.totalpurchase/100  
from(
select c.CustomerNo,sum(price) as totalpurchase
from q1 as p join[Order] as o on p.OrderNo=o.OrderNo join Customers as c on c.CustomerNo=o.CustomerNo
group by c.CustomerNo) as table1 join Customers as c1 on c1.CustomerNo=table1.CustomerNo
where c1.Name=@CustomerName
end   

declare @p int

execute q3 
@CustomerName='Haisem',  
@Points=@p output

select @p as Points