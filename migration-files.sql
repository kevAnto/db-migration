--This code is used to drop tables in case we need to recreate them

DROP  TABLE User1;
DROP  TABLE Student;
DROP  TABLE Instructor;
DROP  TABLE Administrator;
DROP  TABLE Account;
DROP  TABLE Course;
DROP  TABLE Enroll;
DROP  TABLE BiO_priority;
DROP  TABLE Region;

--This code is used to create the various tables for my database.

CREATE TABLE User1 (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
First_name VARCHAR(54) NOT NULL,
Last_name VARCHAR(54) NOT NULL,
Phone DECIMAL(15) NOT NULL,
Email VARCHAR(54) NOT NULL,
Address VARCHAR(54) NOT NULL,
Zip_code DECIMAL(12) NOT NULL,
City VARCHAR(54) NOT NULL);

CREATE TABLE Student (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
Date_admitted DATE NOT NULL,
Term VARCHAR(54) NOT NULL,
Phone DECIMAL(12) NOT NULL,
Acad_group VARCHAR(54) NOT NULL,
Status VARCHAR(54) NOT NULL,
Acad_plan VARCHAR (54) NOT NULL,
Email VARCHAR(54) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Administrator (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
Admin_type VARCHAR(24) NOT NULL,
Department VARCHAR(24) NOT NULL,
Role VARCHAR(24) NOT NULL,
Office VARCHAR(24) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Instructor (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
Office VARCHAR(24) NOT NULL,
Hire_date DATE NOT NULL,
Role VARCHAR(24) NOT NULL,
Subject VARCHAR (24) NOT NULL,
Phone DECIMAL(12) NOT NULL,
Extension DECIMAL(12) NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Account (
AccountID DECIMAL(12) NOT NULL PRIMARY KEY,
UserID DECIMAL(12) NOT NULL,
Account_type VARCHAR(24) NOT NULL,
Created_date DATE NOT NULL,
Description VARCHAR(54) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Bio_priority (
UserID DECIMAL(12) NOT NULL,
AddressID DECIMAL(12) NOT NULL PRIMARY KEY,
Preferred_address VARCHAR(54) NOT NULL,
First_name VARCHAR(54) NOT NULL,
Last_name VARCHAR(54) NOT NULL,
Birth_date DATE NOT NULL,
Country VARCHAR(24) NOT NULL,
State VARCHAR(24) NOT NULL,
City VARCHAR(24) NOT NULL,
County VARCHAR(24) NULL,
Postal_code DECIMAL(12) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Region(
UserID DECIMAL(12) NOT NULL,
AddressID DECIMAL(12) NOT NULL,
Region_name VARCHAR(24) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID), 
FOREIGN KEY (AddressID) REFERENCES Bio_priority(AddressID)); 


CREATE TABLE Course (
CourseID DECIMAL(12) NOT NULL PRIMARY KEY,
UserID DECIMAL(12) NOT NULL,
Course_type VARCHAR(54) NOT NULL,
Credit DECIMAL(255) NULL,
Status VARCHAR(24) NOT NULL,
Department VARCHAR(24) NOT NULL,
Grade VARCHAR(24) NULL,
Catalog VARCHAR(54) NOT NULL,
Units_taken DECIMAL(255) NULL,
Grade_base VARCHAR(24) NULL,
Class_nbr DECIMAL(12) NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID)); 

CREATE TABLE Enroll (
CourseID DECIMAL(12) NOT NULL,
UserID DECIMAL(12) NOT NULL,
Enroll_date DATE NOT NULL,
Course_type VARCHAR(24) NOT NULL,
Status VARCHAR(24) NOT NULL,
DESCRIPTION VARCHAR(54) NOT NULL,
FOREIGN KEY (UserID) REFERENCES User1(UserID), 
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)); 

COMMIT;

--This code is for the creation of indexes in my database.

CREATE INDEX StudentUserIDidx
ON Student(UserID); 

CREATE INDEX AdminUserIDidx
ON Administrator(UserID); 

CREATE INDEX InstructorUserIDidx
ON Instructor(UserID); 

CREATE INDEX AccountUserIDidx
ON Account(UserID); 

CREATE INDEX CourseUserIDidx
ON Course(UserID); 

CREATE INDEX Bio_priorityUserIDidx
ON Bio_priority(UserID); 

CREATE INDEX EnrollCourseIDidx
ON Enroll(CourseID); 

CREATE INDEX RegionUserIDidx
ON Region(UserID); 

CREATE INDEX RegionAddressIDidx
ON Region(AddressID); 

CREATE INDEX CourseTypeidx
ON Course(Course_type); 

CREATE INDEX Bio_prioritybirthdateidx
ON Bio_priority(Birth_date); 

CREATE INDEX AccountCreatedDateidx
ON Account(Created_date); 

commit;

--Iteration 5 project--

--Create AddUser1 stored procedure.

CREATE OR REPLACE FUNCTION AddUser1(UserID IN DECIMAL, first_name IN VARCHAR, last_name IN VARCHAR,
phone IN DECIMAL, Email IN VARCHAR, Address IN VARCHAR, Zip_code IN DECIMAL, city in VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
 INSERT INTO User1(userid, first_name, last_name, phone, email, address, zip_code, city)
 VALUES(userid, first_name, last_name, phone, email, address, zip_code, city);
END;
$proc$ LANGUAGE plpgsql 

--Execute AddUser1

 START TRANSACTION;
DO
 $$BEGIN
 EXECUTE AddUser1(1, 'John', 'Ngwa', 564-666-2945, 'johnngwa@gmail.com', '100 street Houston', 77771, 'Houston');
 END$$;
COMMIT TRANSACTION; 


--AddAccount stored procedure

CREATE OR REPLACE FUNCTION AddAccount(AccountID IN DECIMAL, userid IN DECIMAL, account_type IN VARCHAR,
created_date IN DATE, description IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
 INSERT INTO Account(Accountid, userid, account_type, created_date, description)
 VALUES(Accountid, userid, account_type, created_date, description);

END;
$proc$ LANGUAGE plpgsql 

--Executing the procedure above

START TRANSACTION;
DO
 $$BEGIN
 EXECUTE AddAccount(101, 1, 'Student Account', CAST('01-JAN-2020' AS DATE), 'First Account for students');
 END$$;
COMMIT TRANSACTION; 


--Add user 'Student' in stored procedure

CREATE OR REPLACE FUNCTION AddStudent(UserID IN DECIMAL, date_admitted IN DATE, Phone IN DECIMAL,
acad_group IN VARCHAR, Status IN VARCHAR, acad_plan in VARCHAR, Email IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
 INSERT INTO Student(Userid, date_admitted, phone, acad_group, status, acad_plan, email)
 VALUES(Userid, date_admitted, phone, acad_group, status, acad_plan, email);

END;
$proc$ LANGUAGE plpgsql; 
--Executing the procedure above

START TRANSACTION;
DO
 $$BEGIN
 EXECUTE AddStudent(1, CAST('01-JAN-2020' AS DATE), 240-546-4444, 'ADTED', 'Admitted', 'UNGD', 'Jeseline@gmail.com');
 END$$;
COMMIT TRANSACTION; 


--INSERT INTO TABLES

--User1 table

INSERT INTO User1 (userid,first_name,last_name,phone,email,address,zip_code,city)
VALUES 
(2,'Madeline','Anthony','9876634538','ultrices@Maecenas.org','P.O. Box 118, 318 Nam Street','71706','Muzaffargarh'),
(3,'Arthur','Matthew','8284590855','non@quisurnaNunc.co.uk','750-6872 Blandit St.','04119','Balfour'),
(4,'Arthur','Aladdin','1751182653','lectus.rutrum.urna@vitae.com','481-9053 Nam St.','29254','Leticia'),
(5,'Octavius','Fitzgerald','2799321447','ultricies@scelerisquesed.edu','433-5161 Ac St.','6327','Falciano del Massico'),
(6,'Zelda','Thane','7953548166','pede.nec.ante@ametultriciessem.net','371-365 Est, Rd.','634112','Fourbechies'),
(7,'Jada','Marsden','8934600207','morbi@aliquetProin.org','Ap #550-3448 Elit. Rd.','55164','Lanco'),
(8,'Maite','Brennan','8527167077','accumsan@vellectusCum.org','2556 Sagittis Rd.','426552','Panketal'),
(9,'Quamar','Silas','7012782022','mus.Proin.vel@vehiculaaliquetlibero.net','P.O. Box 493, 227 Penatibus Av.','10615','Southampton'),
(10,'Roth','Mannix','3126855584','Lorem.ipsum.dolor@Phaselluslibero.edu','133-4874 Id, St.','302954','Baulers');

--account table

INSERT INTO account (accountid,userid,account_type,created_date,description) 
VALUES (102,2,'student', CAST('02-JAN-2020' AS DATE),'Owner of account is a student'),
(103,3,'Administrator', CAST('03-JAN-2020' AS DATE),'The second account'),
(104,4,'Instructor',CAST('04-JAN-2020' AS DATE),'third account'),
(105,5,'student',CAST('05-JAN-2020' AS DATE),'Account creation type'),
(106,6,'Administrator',CAST('06-JAN-2020' AS DATE),'administrator account'),
(107,7,'Instructor',CAST('07-JAN-2020' AS DATE),'Instructor account'),
(108,8,'Administrator',CAST('08-JAN-2020' AS DATE),'Administrator account'),
(109,9,'Student',CAST('09-JAN-2020' AS DATE),'Student account'),
(110,10,'Instructor',CAST('10-JAN-2020' AS DATE),'Instructor account');

--student table

INSERT INTO student (userid,date_admitted, term, Phone,acad_group,status,acad_plan,Email) 
VALUES
(2, CAST('11-JAN-2020' AS DATE),'ADTED',2698188961,'Admitted','UNGD','GCP', 'eu.arcu@parturientmontes.co.uk'),
(3, CAST('12-JAN-2020' AS DATE),'ADTED',1592124061,'Admitted','UNGD','GCP','Suspendisse.ac.metus@orciinconsequat.net'),
(4,CAST('13-JAN-2020' AS DATE),'ADTED',5007398814,'Pending','UNGD', 'GCP','auctor.quis@vellectusCum.edu'),
(5,CAST('14-JAN-2020' AS DATE),'ADTED', 4487985429,'Admitted','UNGD','GCP','augue.scelerisque.mollis@dictum.org'),
(6,CAST('15-JAN-2020' AS DATE),'ADTED',5535518337,'Pending','UNGD', 'GCP','erat.in@idrisus.co.uk'),
(7,CAST('16-JAN-2020' AS DATE),'ADTED',6559651739,'Pending','UNGD', 'GCP','egestas.blandit@odio.org'),
(8,CAST('17-JAN-2020' AS DATE),'ADTED',8545832762,'Admitted','UNGD', 'GCP','augue@tinciduntDonecvitae.net'),
(9,CAST('18-JAN-2020' AS DATE),'ADTED',1609946360,'Admitted','UNGD', 'GCP','Mauris@aliquetdiam.edu'),
(10,CAST('19-JAN-2020' AS DATE),'ADTED',2534811484,'Pending','UNGD', 'GCP','suscipit@orci.net');

--Instructor table

INSERT INTO Instructor (userid,office,hire_date,role,subject,phone,extension) 
VALUES 
(1,'Tech Support',CAST('01-FEB-2020' AS DATE),'Learning','Human Resources','2611450189','6227195'),
(2,'Media Relations',CAST('02-FEB-2020' AS DATE),'Lecturer','Customer Service','7442141442','3439734'),
(3,'Payroll',CAST('03-FEB-2020' AS DATE),'Assistant','Web Development','3309833197','7112295'),
(4,'Finances',CAST('04-FEB-2020' AS DATE),'Assistant','Programming','5093600150','9023430'),
(5,'Media Relations',CAST('05-FEB-2020' AS DATE),'Professor','Human Resources','2869552701','3410878'),
(6,'Customer Relations',CAST('06-FEB-2020' AS DATE),'Assistant Lecture','Programming','3779491711','4908748'),
(7,'Customer Relations',CAST('07-FEB-2020' AS DATE),'Assistant','Customer Relations','9849903155','9179745'),
(8,'Finances',CAST('08-FEB-2020' AS DATE),'Assistant','Human Resources','6441153486','7875410'),
(9,'Payroll',CAST('09-FEB-2020' AS DATE),'Learning','Finances','1135425620','9760843'),
(10,'Finances',CAST('10-FEB-2020' AS DATE),'Student Services','Linux Administration','6737807404','8976766');

--Administrator Table

INSERT INTO Administrator (userid,admin_type,department,role,office)
VALUES 
(1,'Academic Advisement','Legal Department','Professor','International Students'),
(2,'Assistant','Public Relations','Financial Aid','Financial Aid'),
(3,'Assistant','Human Resources','Assistant Professor','Admissions'),
(4,'Admissions','Tech Support','Lecturer','HR'),
(5,'Assistant','Public Relations','Financial Aid','Advising'),
(6,'Academic Advisement','Finances','Lecturer','Rector''s office'),
(7,'Assistant','Public Relations','Financial Aid','International Students'),
(8,'Student Services','Media Relations','Professor','Financial Aid'),
(9,'Assistant','Customer Relations','Professor','Admissions'),
(10,'Admissions','Advertising','Assistant Professor','International Students');

--Course Table

INSERT INTO course (courseid,userid,course_type,credit,status,department,Grade,Catalog,units_taken,grade_base,class_nbr)
 VALUES
 (1005,1,'Computing',85,'Active','Accounting','A','Research and Development',85,'Technical Efficiency',119),
 (1001,2,'Web Development',80,'Inctive','Research and Development','A','Payroll',89,'Technical Efficiency',116),
 (1004,3,'Database Management',24,'Active','Human Resources','A','Media Relations',89,'Technical Efficiency',118),
 (1003,4,'Quality Assurance',91,'Inctive','Public Relations','A','Web Development',81,'Technical Efficiency',110),
 (1008,5,'Java',44,'Active','Legal Department','A','MS SQL',86,'Technical Efficiency',107),
 (1006,6,'Python',93,'Inctive','Quality Assurance','A','Research and Development',77,'Technical Efficiency',111),
 (1010,7,'MSSQL',13,'Active','Tech Support','A','Tech Support',90,'Technical Efficiency',106),
 (1002,8,'IT Support',52,'Inctive','Human Resources','A','Research and Development',47,'Technical Efficiency',105),
 (1007,9,'Backend Development',63,'Active','Human Resources','A','Linux Administration',85,'Technical Efficiency',117),
 (1009,10,'Database Management',21,'Active','Asset Management','A','Database Management',41,'Technical Efficiency',112);

--Bio_priority table

INSERT INTO Bio_Priority (userid,addressid,preferred_address,first_name,last_name,birth_date,country,state,city,county,postal_code) 
VALUES 
(1,277,'Ap #576-7621 Vestibulum St.','Blaze','Hickman',CAST('01-MAR-2020' AS DATE),'Rwanda','North Island','North Shore','Ulster','81961'),
(2,239,'P.O. Box 117, 3850 Aliquet Street','Malachi','Ryan',CAST('02-MAR-2020' AS DATE),'Mongolia','VLG','Cherepovets','AP','115436'),
(3,265,'P.O. Box 211, 8894 Donec Rd.','Gretchen','Downs',CAST('03-MAR-2020' AS DATE),'Iraq','LA','Lagos','Fr','852678'),
(4,217,'P.O. Box 680, 8394 Dictum Av.','Audra','Wood',CAST('04-MAR-2020' AS DATE),'Antigua and Barbuda','Quebec','Saint-Prime','Sokoto','43245'),
(5,221,'511-1312 Lorem Ave','Montana','Dunn',CAST('05-MAR-2020' AS DATE),'Spain','IM','Okigwe','South Island','559212'),
(6,266,'8623 Vestibulum Avenue','Kai','Boyer',CAST('06-MAR-2020' AS DATE),'Austria','North Island','Hastings','ARA','17849'),
(7,203,'Ap #422-4617 Commodo St.','Ashely','Monroe',CAST('07-MAR-2020' AS DATE),'Virgin Islands, British','Jalisco','Tonalá','JI','52047'),
(8,273,'5257 Vitae St.','Cruz','Campbell',CAST('08-MAR-2020' AS DATE),'Portugal','Munster','Cork','Lubelskie','978881'),
(9,218,'Ap #707-8559 Morbi Av.','Solomon','Maddox',CAST('09-MAR-2020' AS DATE),'Åland Islands','Bolívar','Cartagena','Nordrhein-Westphalen','13814'),
(10,200,'P.O. Box 575, 4788 Mattis Rd.','Macon','Poole',CAST('10-MAR-2020' AS DATE),'Myanmar','Connacht','Galway','Banten','624194');

--Enroll Table

INSERT INTO enroll (courseid,userid,enroll_date,course_type,status,Description) 
VALUES 
(1004,1,CAST('01-JAN-2020' AS DATE),'Finances','Enrolled','Enrollment for courses'),
(1007,2,CAST('02-JAN-2020' AS DATE),'MSSQL','Pending','Enrollment for courses'),
(1006,3,CAST('03-JAN-2020' AS DATE),'Finances','Pending','Enrollment for courses'),
(1005,4,CAST('04-JAN-2020' AS DATE),'Computing','Enrolled','Enrollment for courses'),
(1009,5,CAST('05-JAN-2020' AS DATE),'IT Support','Declined','Enrollment for courses'),
(1001,6,CAST('06-JAN-2020' AS DATE),'IT Support','Declined','Enrollment for courses'),
(1003,7,CAST('07-JAN-2020' AS DATE),'Finances','Enrolled','Enrollment for courses'),
(1010,8,CAST('08-JAN-2020' AS DATE),'Finances','Pending','Enrollment for courses'),
(1002,9,CAST('09-JAN-2020' AS DATE),'MSSQL','Enrolled','Enrollment for courses'),
(1008,10,CAST('10-JAN-2020' AS DATE),'Computing','Enrolled','Enrollment for courses');

--region table

INSERT INTO region (userid,addressid,region_name)
 VALUES 
 (1,200,'MN'),
 (2,266,'Arequipa'),
 (3,218,'South Gyeongsang'),
 (4,273,'Heredia'),
 (5,203,'SC'),
 (6,221,'UT'),
 (7,217,'Haute-Normandie'),
 (8,265,'VT'),
 (9,239,'Provence-Alpes-Côte'),
 (10,277,'New York');


--Admission_fees table


INSERT INTO admission_fees (userid,amount,payment_date) 
VALUES
 (1,'75.00',CAST('01-JAN-2020' AS DATE)),
 (2,'75.00',CAST('01-JAN-2020' AS DATE)),
 (3,'75.00',CAST('01-JAN-2020' AS DATE)),
 (4,'75.00',CAST('01-JAN-2020' AS DATE)),
 (5,'75.00',CAST('01-JAN-2020' AS DATE)),
 (6,'75.00',CAST('01-JAN-2020' AS DATE)),
 (7,'75.00',CAST('01-JAN-2020' AS DATE)),
 (8,'75.00',CAST('01-JAN-2020' AS DATE)),
 (9,'75.00',CAST('01-JAN-2020' AS DATE)),
 (10,'75.00',CAST('01-JAN-2020' AS DATE));


--Change History table creation


CREATE TABLE Admission_fees (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
Amount DECIMAL (8,2) NOT NULL,
Payment_date DATE NOT NULL,
FOREIGN KEY (UserID) REFERENCES student(UserID)); 

CREATE TABLE fees_change (
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
old_Amount DECIMAL (8,2) NOT NULL,
new_Amount DECIMAL (8,2) NOT NULL,
change_date DATE NOT NULL,
FOREIGN KEY (UserID) REFERENCES Admission_fees(UserID)); 

--Trigger on fees_change table

CREATE OR REPLACE FUNCTION FeesChangeFunction()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
 BEGIN
 INSERT INTO fees_change(userID, Old_amount, New_amount, Change_date)
 VALUES(COALESCE((SELECT MAX(userID)+1 FROM fees_change), 1),
 OLD.old_amount,
 NEW.new_amount,
 current_date);

 RETURN NEW;
 END;
$trigfunc$;

CREATE TRIGGER amountChangeTrigg3
BEFORE UPDATE OF old_amount ON fees_change
FOR EACH ROW
EXECUTE PROCEDURE feesChangeFunction();


-- Insert into change table

INSERT INTO fees_change(userid, old_amount, new_amount, change_date)
VALUES(1, 75.00, 80.00, CAST('01-JAN-2020' AS DATE));
INSERT INTO fees_change(userid, old_amount, new_amount, change_date, change_id)
VALUES
(2, 75.00, 80.00, CAST('02-JAN-2020' AS DATE), 301),
(3, 75.00, 80.00, CAST('03-JAN-2020' AS DATE), 302),
(4, 75.00, 80.00, CAST('03-JAN-2020' AS DATE), 303),
(5, 75.00, 80.00, CAST('03-JAN-2020' AS DATE), 304),
(6, 75.00, 80.00, CAST('04-JAN-2020' AS DATE), 305),
(7, 75.00, 80.00, CAST('05-JAN-2020' AS DATE), 306),
(8, 75.00, 80.00, CAST('05-JAN-2020' AS DATE), 307),
(9, 75.00, 80.00, CAST('01-JAN-2020' AS DATE), 308);

--Data changes recorded

UPDATE fees_change 
SET New_amount = 90
WHERE Userid =1;

UPDATE fees_change
SET new_amount = 60
WHERE Userid =1;

UPDATE fees_change
SET new_amount = 70
WHERE Userid =1;


--Creating questions and queries
--Question 1:1.	what is the list of students who have enrolled in the database management course so far. 
--what are their names, emails, and preferred addresses and are they still actively enrolled or not.

SELECT user1.last_name,user1.first_name, student.email, student.userid, course.course_type, course.status, bio_priority.preferred_address 
FROM course
JOIN Bio_priority ON bio_priority.userid = course.userid
JOIN Student ON student.userid = course.userid
JOIN User1 ON User1.userid = course.userid
WHERE course_type = 'Database Management';


--Question 2:2.	Which instructors are at the same time administrators who were hired after February 5th 2020.
-- What courses do they teach, and in what departments are they related to. 

SELECT user1.first_name, user1.last_name, Instructor.subject, administrator.department, instructor.hire_date 
FROM Instructor
JOIN Administrator ON Administrator.userid = Instructor.userid
JOIN user1 ON User1.userid = Instructor.userid
WHERE instructor.userid IN 
			(SELECT Administrator.userid 
			FROM Administrator
			JOIN Instructor ON Instructor.userid = Administrator.userid
			WHERE administrator.userid = instructor.userid
			AND hire_date > CAST('05-FEB-2020' AS DATE))
ORDER  BY user1.first_name, user1.last_name;

--Question 3: 3.What is the average amount of fees change recorded in 2020?  

SELECT  TRUNC(AVG(new_amount - Old_amount)) AS Change_average, fees_change.change_date
FROM fees_change
WHERE fees_change.change_date > CAST('02-JAN-2020' AS DATE)
GROUP BY fees_change.change_date;
			  
			  
			  








