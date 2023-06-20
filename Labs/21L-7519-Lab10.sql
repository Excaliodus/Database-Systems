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



GO

--Question1--

CREATE TABLE Auditing
(
Audit_id INT PRIMARY KEY,
Last_Change_On DATE,
)

CREATE TRIGGER Student_Trig
ON dbo.Students
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On)
VALUES(GETDATE())

CREATE TRIGGER Department_Trig
ON dbo.Department
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On)
VALUES(GETDATE())

CREATE TRIGGER Faculty_Trig
ON dbo.Faculty
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On)
VALUES(GETDATE())

--Question2--

ALTER TABLE dbo.Auditing ADD [description] VARCHAR(100)

ALTER TRIGGER Student_Trig 
ON dbo.Students
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On,[description]) 
VALUES(GETDATE(),'Student made a change')

ALTER TRIGGER Department_Trig 
ON dbo.Department
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On,[description])
VALUES(GETDATE(),'Change made in table Department')

ALTER TRIGGER Faculty_Trig 
ON dbo.Faculty
FOR UPDATE,
	INSERT,
	DELETE
AS
DECLARE @datechange DATE
INSERT INTO Auditing (Last_Change_On,[description])
VALUES(GETDATE(),'Change made in table Faculty')

--Question3--

CREATE VIEW Question3
AS 
SELECT section_id,S.CourseID,capacity,Cname,C.CreditHours,dept_id
FROM SECTION AS S,Courses AS C
WHERE S.CourseID=C.CourseID

CREATE TRIGGER Register 
ON Enrolled 
FOR INSERT 
AS 
SELECT *
FROM Question3 

--Question4--

CREATE PROCEDURE Question4
@RollNumber VARCHAR(10), 
@SectionID INT 
AS 
BEGIN 
	INSERT INTO Enrolled
	VALUES(@RollNumber,@SectionID) 
END 

EXECUTE Question4
@RollNumber='1', 
@SectionID=4

--Question5--

CREATE TRIGGER Question5
ON Department 
INSTEAD OF INSERT,
		UPDATE,
		DELETE 
AS 
PRINT('Cannot change Department Table') 

 --Question6--
 
CREATE TRIGGER Question6
ON DATABASE 
FOR Drop_Table,Alter_Table 
AS 
PRINT 'You cannot alter or drop tables' 
ROLLBACK;
