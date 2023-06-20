Student(roll_no, name, dept_id, batch)
Course(course_id, name, credit_hrs, dept_id)
Section (section_id, course_id, capacity)
Enrolled(student_roll_no, section_id)
Faculty(faculty_id, name, dept_id)
Department(dept_id, name)

Create database Neon
use Neon

go
create table Students
(RollNo varchar(7) primary key
,Name varchar(30)
,dept_id int Foreign key References Department(dept_id),
batch int
)
GO
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'1', N'Ali', 1, 2021)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'2', N'Bilal', 2, 2019)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'3', N'Ayesha', 1, 2017)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'4', N'Ahmed', 1, 2016)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'5', N'Sara', 3, 2018)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'6', N'Salman', 3, 2019)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'7', N'Zainab', 2, 2020)
INSERT [dbo].[Students] ([RollNo], [Name], [dept_id], [batch]) VALUES (N'8', N'Danial', 1, 2018)

go
create table Courses
(
CourseID int primary key,
CName varchar(40),
CreditHours int,
dept_id int Foreign key References Department(dept_id)
) 
GO
INSERT [dbo].[Courses] ([CourseID], [CName], CreditHours,dept_id) VALUES (1, N'Database Systems', 3,1)
INSERT [dbo].[Courses] ([CourseID], [CName], CreditHours,dept_id) VALUES (2, N'Data Structures', 3,2)
INSERT [dbo].[Courses] ([CourseID], [CName], CreditHours,dept_id) VALUES (3, N'Programing', 3,2)
INSERT [dbo].[Courses] ([CourseID], [CName], CreditHours,dept_id) VALUES (4, N'Basic Electronics', 3,3)
go

Create table Section
(
section_id int primary key,
CourseID int Foreign key References Courses(CourseID),
capacity int,
)
GO
INSERT into Section VALUES (1, 1,  45)
INSERT into Section  VALUES (2, 3, 30)
INSERT into Section VALUES (3, 2,  46)
INSERT into Section  VALUES (4, 4,60)
INSERT into Section VALUES (5, 4,  60)
INSERT into Section VALUES (6, 1, 50)

go

Create table Enrolled
(
Student_RollNo varchar(7) Foreign key References Students(RollNO),
section_id int Foreign key References Section(section_id),
)
GO
INSERT into Enrolled  VALUES (1, 2)
INSERT into Enrolled VALUES (2, 1)
INSERT into Enrolled VALUES (1, 3)
INSERT into Enrolled  VALUES (6, 4)
go

Create table Faculty
(
faculty_id int primary key,
name varchar(20),
dept_id int Foreign key References Department(dept_id)
)
GO
INSERT into Faculty VALUES (1, N'Ishaq Raza', 1)
INSERT into Faculty VALUES (2, N'Zareen Alamgir', 2)
INSERT into Faculty VALUES (3, N'Saima Zafar', 3)
go


create table Department
(
dept_id int primary key,
name varchar(20),
)
INSERT into Department VALUES ( N'1','CS' )
INSERT into Department VALUES ( N'2', 'BBA')
INSERT into Department VALUES (N'3','EE')



go

--q1
create table Auditing
(
Audit_id int primary key,
Last_Change_On date,
)

Create trigger s_trig
on dbo.Students
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On) Values(GETDATE())

Create trigger d_trig
on dbo.Department
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On) Values(GETDATE())

Create trigger f_trig
on dbo.Faculty
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On) Values(GETDATE())

--q2
alter table dbo.Auditing add [description] varchar(100)

alter trigger s_trig 
on dbo.Students
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On,[description]) Values(GETDATE(),'Student made a change')

alter trigger d_trig 
on dbo.Department
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On,[description]) Values(GETDATE(),'Change made in table Department')

alter trigger f_trig 
on dbo.Faculty
for update,insert, delete
as
declare @alterdate date
insert into Auditing (Last_Change_On,[description]) Values(GETDATE(),'Change made in table Faculty')

--q3
Create view q3
as 
Select section_id,S.CourseID,capacity,Cname,C.CreditHours,dept_id
from Section as S,Courses as C where S.CourseID=C.CourseID 

Create Trigger Register 
on Enrolled 
for Insert 
as 
Select * from q3 

--q4
Create Procedure q4
@rollno varchar(10), 
@secid int 
as 
Begin 
Insert into Enrolled values(@rollno,@secid) 
End 

execute q4
@rollno='1', 
@secid=4

--q5
create trigger q5
on Department 
instead of insert,update,delete 
as 
 print('Cannot change Department Table') 

 --q6 
Create Trigger q6
on Database 
for Drop_Table,Alter_Table 
as 
print 'You cannot alter or drop tables' 
rollback;
