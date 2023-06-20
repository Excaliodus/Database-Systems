
go
create table Students
(RollNo varchar(7) primary key
,Name varchar(30)
,WarningCount int
,Department varchar(15)
)
GO
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'1', N'Ali', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'2', N'Bilal', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'3', N'Ayesha', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'4', N'Ahmed', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'5', N'Sara', 0, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'6', N'Salman', 1, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'7', N'Zainab', 2, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'8', N'Danial', 1, N'CS')

go
create table Courses
(
CourseID int primary key,
CourseName varchar(40),
PrerequiteCourseID int,
CreditHours int
) 
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (10, N'Database Systems', 20, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (20, N'Data Structures', 30,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (30, N'Programing', NULL,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (40, N'Basic Electronics', NULL,3)
go

go
Create table Instructors 
(
InstructorID int Primary key,
Name varchar(30),
Department varchar(7) ,
)
GO
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (100, N'Ishaq Raza', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (200, N'Zareen Alamgir', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (300, N'Saima Zafar', N'EE')
go
Create table Semester
(
Semester varchar(15) Primary key,
[Status] varchar(10),
)
GO
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Fall2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2017', N'InProgress')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Summer2016', N'Cancelled')
go
Create table Courses_Semester
(
InstructorID int Foreign key References Instructors(InstructorID),
CourseID int Foreign key References Courses(CourseID),
Semester varchar(15) Foreign key References Semester(Semester), 
Section varchar(1) ,
AvailableSeats int,
Department varchar(2)
)
GO
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'D', 45, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'C', 0, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (100, 10, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2016', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2016', N'A', 0, N'CS')

go



create table Registration
(
Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
CourseID int Foreign key References Courses(CourseID), 
Section varchar(1),
GPA float
)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'1', 20, N'A', 3.3)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'2', 20, N'B', 4)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2016', N'1', 30, N'A', 1.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'6', 40, N'D',0.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'6', 40, N'D',1)


go

Create table ChallanForm
(Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
TotalDues int,
[Status] varchar(10)
)
GO
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'1', 100000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'2', 13333, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'3', 5000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'4', 20000, N'Pending')


select * from Students
select * from Courses
select * from Instructors
select * from Registration
select * from Semester
select * from Courses_Semester
select * from ChallanForm 

--Q1--

CREATE TRIGGER delete_students
on Students 
INSTEAD OF DELETE
AS
BEGIN 
PRINT 'You don’t have the permission to delete the student' 
END

--Q2--

CREATE TRIGGER insert_courses
ON Courses
INSTEAD OF INSERT
AS
BEGIN 
PRINT 'You don’t have the permission to Insert a new Course' 
END

--Q3--

CREATE TABLE Notify	(NotifictionID INT PRIMARY KEY, StudentID VARCHAR(7) FOREIGN KEY REFERENCES Students(RollNo), Notification_String VARCHAR(max));

CREATE TRIGGER REGISTER_NOTIF
ON Registration
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @rno INT,
	@sem VARCHAR(50),
	@course INT,
	@sec CHAR(1),
	@g FLOAT
	SELECT @rno = RollNumber, @course = CourseID, @g = GPA, @sem = Semester, @sec = SECTION
	FROM inserted
	IF EXISTS	(SELECT* 
				FROM Registration
				WHERE RollNumber = @rno AND CourseID = @course)
		BEGIN
		IF(	(SELECT AvailableSeats
			FROM Courses_Semester
			WHERE CourseID = @course AND Semester = @sem) > 0)
				BEGIN
					INSERT INTO Registration VALUES(@sem, @rno, @course, @sec, @g)
					PRINT 'Successful'
					INSERT INTO Notify (StudentID, Notification_String) VALUES(@rno,'Succesful Registration')
				END
		ELSE
			BEGIN 
				PRINT 'Unsuccessful'
				INSERT INTO Notify (StudentID, Notification_String) VALUES(@rno,'UnSuccesful Registration')
			END
		END
	ELSE
		BEGIN 
			PRINT 'Unsuccessful'
			INSERT INTO Notify (StudentID, Notification_String) VALUES(@rno,'UnSuccesful Registration')
		END
END

--Q4--

CREATE PROCEDURE FEE_CHARGE
@rollnum INT, 
@status INT OUTPUT 
AS 
IF EXISTS	(SELECT * 
			FROM ChallanForm
			WHERE RollNumber=@rollnum AND TotalDues<20000 AND Status='Pending') 
	BEGIN 
		SET @status=1 
	END 
ELSE 
	BEGIN 
		SET @status=0  
	END 

CREATE TRIGGER FEE_CHARGE_TRIG
ON Registration 
INSTEAD OF INSERT 
AS
BEGIN  
	DECLARE @rollno INT 
	SELECT @rollno=RollNumber FROM inserted   
	DECLARE @st INT 
	EXECUTE FEE_CHARGE
	@rollnum=@rollno, 
	@status=@st OUTPUT 
	IF(@st=0) 
		PRINT 'Charges due are greater than 20000' 
	ELSE  
		BEGIN
			DECLARE @sem VARCHAR(MAX),@courseid INT,@SECTION VARCHAR(MAX),@gpa FLOAT  
			SELECT @sem=Semester,@courseid=CourseID,@SECTION=SECTION,@gpa=GPA
			FROM inserted
			INSERT INTO Registration VALUES (@sem,@rollno,@courseid,@SECTION,@gpa)
		END 
END 

--Q5--

CREATE PROCEDURE DELETE_COURSE_SEM
@cid INT,  
@semester VARCHAR(MAX),
@Aseats INT,
@sec VARCHAR(MAX),
@instructorid INT,
@deptartment VARCHAR(MAX),
@status INT OUTPUT 
AS 
IF EXISTS	(SELECT *
			FROM Courses_Semester
			WHERE CourseID=@cid  AND @semester=Semester AND @sec=SECTION AND @Aseats=AvailableSeats AND @instructorid=InstructorID AND @deptartment=Department AND AvailableSeats<10) 
	BEGIN 
		SET @status=1 
	END 
ELSE 
	BEGIN 
		SET @status=0  
	END 

CREATE TRIGGER DELETE_COURSE_SEM_TRIG
ON Courses_Semester 
INSTEAD OF DELETE 
AS
BEGIN  
	DECLARE @courseid INT,@sem VARCHAR(MAX),@seats INT,@SECTION VARCHAR(MAX),@instid INT,@dept VARCHAR(MAX)
	SELECT @sem=Semester,@courseid=CourseID,@SECTION=SECTION,@instid=InstructorID,@seats=AvailableSeats,@dept=Department
	FROM deleted
	DECLARE @st int 
	EXECUTE DELETE_COURSE_SEM
	@cid=@courseid, 
	@semester=@sem,
	@Aseats=@seats,
	@sec=@SECTION,
	@instructorid=@instid,
	@deptartment=@dept,
	@status=@st OUTPUT 
	IF(@st=1) 
		PRINT 'Not possible' 
	ELSE  
		BEGIN	
			SELECT @sem=Semester,@courseid=CourseID,@SECTION=SECTION,@instid=InstructorID,@seats=AvailableSeats,@dept=Department
			FROM deleted
			DELETE
				FROM Courses_Semester
				WHERE InstructorID=@instid AND CourseID= @courseid AND Semester=@sem AND SECTION=@SECTION AND AvailableSeats=@seats AND Department=@dept
		END 
END 

--Q6--

CREATE TRIGGER INSRUCT_MODIF
ON DATABASE 
FOR 
drop_table,alter_table 
AS
BEGIN 
PRINT'You are not allowed to drop or alter table' 
END

DISABLE TRIGGER INSRUCT_MODIF ON Students  
DISABLE TRIGGER INSRUCT_MODIF ON Courses
DISABLE TRIGGER INSRUCT_MODIF ON Registration
DISABLE TRIGGER INSRUCT_MODIF ON Semester 
DISABLE TRIGGER INSRUCT_MODIF ON Courses_Semester 
DISABLE TRIGGER INSRUCT_MODIF ON ChallanForm 