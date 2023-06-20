USE ATM

--q1
CREATE FUNCTION UserBalance(@Cardnum Varchar(20))
RETURNS float
AS
BEGIN
Declare @returnvalue float
Select @returnvalue=c.balance from [Card] as c where c.cardNum=@Cardnum
RETURN @returnvalue
END
Execution:
select dbo.UserBalance(N'1234') as Balance

--q2
CREATE FUNCTION UserData(@Userid int)
RETURNS Table
AS
RETURN SELECT*
FROM [User] as u where u.userId=@Userid

Execution:
select * from dbo.UserData(1)

--q3
Create Procedure q3
@Username varchar(20)
as Begin
select * from [User] as u
where u.name=@Username
end
execute q3
@Username='Ali'

--q4
Create Procedure q4
@userid int
as Begin

select c.cardNum,dbo.UserBalance(c.cardNum) as balance from [User] as u1,[UserCard] as u2, [Card] as c where u1.userId=@userid and u1.userId=U2.userID AND U2.cardNum=c.cardNum
end

execute q4
@userid=1


--q5
CREATE FUNCTION UserBalance2(@userid int)
RETURNS Table
AS
RETURN select c.cardNum,c.balance as balance from [User] as u1,[UserCard] as u2, [Card] as c where u1.userId=@userid and u1.userId=U2.userID AND U2.cardNum=c.cardNum

Execution:
select * from dbo.UserBalance2(1)


--q6
Create Procedure q6
@id int,
@num int output
as Begin
select @num=count(uc.userID) from [User] as u,UserCard as uc
where u.userId=uc.userID and u.userId=@id
end

declare @numofcards int
execute q6
@id=1,
@num=@numofcards output
select @numofcards as NumofCards

--q7
--IT CAN BE DONE USING UDF AS  INSERT/UPDATE OR DELETE OPERARION ARE NOT USED
Create Procedure q7
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
execute q7
@cn=N'1234',@p=N'1770',
@s=@status output
select @status as Status

--q8
Create Procedure q8
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
execute q8
@cn=N'1234',@p=N'1770',@np=N'1100',
@o=@output output
select @output as [output]

--q9
--IT CAN NOT BE DONE USING UDF AS INSERT/UPDATE OR DELETE OPERARIONS ARE USED
alter table [Transaction] add TransactionType int
insert into [Transaction] values(6, CAST(N'2020-02-10' AS Date), N'1234',1, 6000)

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
		iNSERT INTO [Transaction] (transId,transDate,amount,TransactionType,cardNum)
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
@cn=N'1234',@p=N'1100',@At=5000,
@trans=@TransType output
select @TransType as TransType