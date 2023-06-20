

--Q1
Create Procedure q1
as Begin
select * from [User]
end
execute q1

--Q2
Create Procedure q2
@username varchar(20)
as Begin
select * from [User] as u
where u.name=@username
end
execute q2
@username='Ali'

--Q3
Create Procedure q3
@cardnum varchar(20)
as Begin
select u.name,u.phoneNum,u.city from [User] as u,UserCard as uc
where u.userId=uc.userID and uc.cardNum=@cardnum
end
execute q3
@cardnum=N'1324327436569'

--Q4
Create Procedure q4
@Min float output
as Begin
select @Min=min(c.balance) from [Card] as c
end

Declare @MinBalance float
execute q4
@Min=@MinBalance output
Select @MinBalance as MinBalance

--Q5
Create Procedure q5
@username varchar(20),
@id int,
@num int output
as Begin
select @num=count(uc.userID) from [User] as u,UserCard as uc
where u.userId=uc.userID and u.name=@username and u.userId=@id
end

declare @numofcards int
execute q5
@username='Ali',@id=1,
@num=@numofcards output
select @numofcards as NumofCards

--Q6
Create Procedure q6
@cn varchar(20),
@p varchar(4),
@s int output
as Begin
if exists(select * from [Card] as c where @cn=c.cardNum and @p=c.PIN)
	begin
		set @s=1
		end
	else
	begin
		set @s=0
	end
end

declare @status int
execute q6
@cn=N'2324325666456',@p=N'1200',
@s=@status output
select @status as Status

--Q7
Create Procedure q7
@cn varchar(20),
@p varchar(4),
@np varchar(4),
@o varchar(20) output
as Begin
if exists(select * from [Card] as c where @cn=c.cardNum and @p=c.PIN) and len(@np)=4
	begin
		UPDATE [Card]
		SET [Card].PIN=@np
		where [Card].pin=@p
		set @o='Updated PIN'
		end
	else
	begin
		set @o='Error'
	end
end
declare @output varchar(20)
execute q7
@cn=N'2324325666456',@p=N'1200',@np=N'1100',
@o=@output output
select @output as [output]

--Q8
Create Procedure Withdraw
@cn varchar(20),
@p varchar(4),
@At int,
@trans int output
as Begin
if exists(select * from [Card] as c where @cn=c.cardNum and @p=c.PIN) and @At<=(select c2.balance
																				from [Card] as c2
																				where c2.cardNum=@cn and c2.PIN=@p)
	begin
		iNSERT INTO [Transaction] (transId,transDate,amount,transType,cardNum)
		VALUES((select max(t.transId)+1 
				from [Transaction] as t),CAST(N'2017-05-06' AS Date),@At,1,@cn)
		update [Card]
		set balance-=@At
		where cardNum=@cn and PIN=@p
		set @trans=1
		end
	else
	begin
		set @trans=4
	end
end

declare @TransType int
execute Withdraw
@cn=N'2324325666456',@p=N'1100',@At=50001,
@trans=@TransType output
select @TransType as TransType

