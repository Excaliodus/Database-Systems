Create database Neon
use Neon

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


go
--q1
create trigger del_trig
on Students
instead of delete
as begin
print 'You dont have permission to delete the student'
end 
go
delete from Students where Students.Name='Ali'

--q2
create trigger insert_trig
on Courses
instead of insert
as begin
print 'You dont have permission to Insert a new Course'
end 
go
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (50, N'Data Structures', NULL, 3)

--q3
create table Notify
(
NotificationID int Not null,
StudentID varchar(7) Foreign key References Students(RollNo),
[Notification] varchar(50), 
)

go
CREATE TRIGGER registration_success on Notify
AFTER INSERT ON Registration
FOR EACH ROW
BEGIN
    DECLARE notification VARCHAR(255);
    IF NEW.status = 'successful' THEN
        SET [Notification] = CONCAT('Your registration for course ', NEW.course_code, ' is successful.');
    ELSE
        SET [Notification] = CONCAT('Your registration for course ', NEW.course_code, ' has been rejected.');
    END IF;
    INSERT INTO Notify  VALUES (1,'1', [Notification]);
END;


--Q3 
create table Notify 
(NotifictionID int primary key, 
StudentID varchar(7) Foreign key References Students(RollNo), 
Notification_String varchar(max));

create trigger q3  
on Registration 
instead of insert 
as begin 
	declare @rno int,
	@sem varchar(50),
	@course int,
	@sec char(1),
	@g float
	select @rno = RollNumber, @course = CourseID, @g = GPA, @sem = Semester, @sec = Section from inserted
	if exists(select* from Registration where RollNumber = @rno and CourseID = @course)
		begin
			if( (select AvailableSeats from Courses_Semester where CourseID = @course and Semester = @sem) > 0)
				begin
					Insert into Registration values(@sem, @rno, @course, @sec, @g)
					print 'Successful'
					Insert Into Notify (StudentID, Notification_String) values(@rno,'Succesful Registration')
				end
			else
				begin 
					print 'Unsuccessful'
					Insert Into Notify (StudentID, Notification_String) values(@rno,'UnSuccesful Registration')
				end
		end
	else
		begin 
			print 'Unsuccessful'
			Insert Into Notify (StudentID, Notification_String) values(@rno,'UnSuccesful Registration')
		end
end


--q4
create trigger fee_trig
 ON Registration
 after insert
as BEGIN
  DECLARE @fee_due int
  SELECT @fee_due= c.Totaldues from ChallanForm as c, Registration where Registration.RollNumber=c.RollNumber
  IF (@fee_due > 20000) 
  begin
    print 'Cannot enroll student with more than 20,000 fee charges due.'
	end 
	else
	print'enrolled'
	end
	go

INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'4', 40, N'D',1)

--q5
create procedure q5_1
@cid int,  
@semester varchar(max),
@Aseats int,
@sec varchar(max),
@instructorid int,
@deptartment varchar(max),
@status int output
as
if exists(Select * from Courses_Semester where CourseID=@cid  and @semester=Semester and @sec=Section and @Aseats=AvailableSeats and @instructorid=InstructorID and @deptartment=Department and AvailableSeats<10)
Begin
set @status=1
end
else
Begin
set @status=0  
end

Create Trigger Q5
on Courses_Semester
instead of delete
as
begin  
declare @courseid int,@sem varchar(max),@seats int,@section varchar(max),@instid int,@dept varchar(max)
select @sem=Semester,@courseid=CourseID,@section=Section,@instid=InstructorID,@seats=AvailableSeats,@dept=Department from deleted
declare @st int
execute Q5_1
@cid=@courseid,
@semester=@sem,
@Aseats=@seats,
@sec=@section,
@instructorid=@instid,
@deptartment=@dept,
@status=@st output

if(@st=1)
print 'Not possible'
else  
Begin
select @sem=Semester,@courseid=CourseID,@section=Section,@instid=InstructorID,@seats=AvailableSeats,@dept=Department from deleted
delete from Courses_Semester where InstructorID=@instid and CourseID= @courseid and Semester=@sem and Section=@section and AvailableSeats=@seats and Department=@dept
end
end

delete from Courses_Semester where AvailableSeats=0 and Semester='Spring2017'

	
create trigger del_trig
on Students
instead of drop,Update
as begin
print 'You dont have permission to delete the student'
end 
go
delete from Students where Students.Name='Ali'

--q6
create trigger q6 
on database 
for 
drop_table,alter_table 
as begin 
	print'You are not allowed to drop or alter table' 
end

 disable trigger q6 on Students  
 disable trigger q6 on Courses
 disable trigger q6 on Registration
 disable trigger q6 on Semester 
 disable trigger q6 on Courses_Semester 
 disable trigger q6 on ChallanForm 

