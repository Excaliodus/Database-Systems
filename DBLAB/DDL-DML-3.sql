CREATE TABLE Student
(
RollNum char(8) NOT NULL,
Name varchar(50),
Gender varchar(15),
Phone int
);
CREATE TABLE Attendence
(
RollNum char(8) NOT NULL,
Date date,
Status char(1),
ClassVenue int
);
CREATE TABLE ClassVenue
(
ID int NOT NULL,
Building varchar(20),
RoomNum int,
Teacher varchar(50)
);
CREATE TABLE Teacher
(
Name varchar(50) Not Null,
Designation varchar(25),
Department varchar(50)
);
INSERT INTO Student(RollNum, Name, Gender, Phone)
VALUES
('L164123', 'Ali Ahmad', 'Male', 0333-3333333),
('L164124', 'Rafia Ahmed', 'Female', 0333-3456789 ),
('L164125', 'Basit Junaid', 'Male', 0345-3243567);

INSERT INTO Attendence(RollNum, Date, Status, ClassVenue)
VALUES
('L164123', '2016-2-22', 'P', 2),
('L164124', '2016-2-23', 'A', 1),
('L164125', '2016-3-4', 'P', 2);

INSERT INTO ClassVenue(ID,Building, RoomNum, Teacher)
VALUES
(1, 'CS', 2, 'Sarim Baig'),
(2, 'Civil', 7, 'Bismillah Jan');

INSERT INTO Teacher(Name, Designation, Department)
VALUES
('Sarim Baig', 'Assistant Prof.', 'Computer Science'),
('Bismillah Jan', 'Lecturer', 'Civil Eng.'),
('Kashif zafar', 'Professor', 'Electrical Eng.');

ALTER TABLE Student ADD CONSTRAINT PK_Student PRIMARY KEY (RollNum);
ALTER TABLE Attendence ADD CONSTRAINT PK_Attendence PRIMARY KEY (RollNum);
ALTER TABLE ClassVenue ADD CONSTRAINT PK_ClassVenue PRIMARY KEY (ID);
ALTER TABLE Teacher ADD CONSTRAINT PK_Teacher PRIMARY KEY (Name);

Alter Table Attendence add constraint FK_STUDENT foreign key (RollNum) references
Student (RollNum) on delete No Action on update Cascade
Alter Table Attendence add constraint FK_ClassVenue foreign key (CLassVenue) references
ClassVenue (ID) on update Cascade
Alter Table ClassVenue add constraint FK_Teacher foreign key (Teacher) references
Teacher (Name) on update Cascade

alter table Student add WarningCount int;
alter table Student drop column Phone;

INSERT INTO Student(RollNum, Name, Gender, WarningCount)
VALUES
('L162334', 'Fozan Shahid', 'Male', 3.2);
--VALID but it takes warining count as 3 not 3.1


INSERT INTO ClassVenue(ID,Building, RoomNum, Teacher)
VALUES
(3, 'CS', 5, 'Ali');
--INVALID because no teacher with name Ali is registered in the table of Teachers. To make this command you have to insert a new row in Table Teacher with name Ali


UPDATE Teacher
SET Name='Dr. Kashif Zafar'
WHERE Name= 'Kashif zafar'
--VALID


DELETE FROM Student
WHERE RollNum='L162334'
--VALID


DELETE FROM Student
WHERE RollNum='L164123'
--INVALID because its foreign key is present in table of attendence to make it a valid command first the row with this rollnumber should be deleted from table of Attendence

DELETE FROM Attendence
WHERE RollNum='L164124' AND Status='A'
--VALID


Alter Table Teacher add constraint UNIQUE_CONSTRAINT_Teacher Unique (Name)

alter table Student add Constraint STUDENT_CHECK_Gender
check (Gender='Male' OR Gender='Female')

alter table Attendence add Constraint STUDENT_CHECK_Attendance
check (Status='P' OR Status='A')