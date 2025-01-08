create database HomeTaskbase

create table Edu_school(Teachers varchar(30), Salary int)

select * from teachers_salary

insert into Edu_school values ('Jonh', $75000)
insert into Edu_school values ('Emily', 88500), ('Micheal', 62000), ('Sophia', 94200), ('Liam', 80000)

exec sp_rename 'Edu_school', 'Teachers_salary'

select * from teachers_salary

alter table teachers_salary 
add Ielts_score smallint 
 
update teachers_salary
set ielts_score = 7.5
where Teachers = 'Jonh'

alter table teachers_salary 
alter column Ielts_score Float 

update teachers_salary 
set ielts_score = 8.0
where Teachers = 'Emily'

update teachers_salary 
set ielts_score = 8.5
where teachers = 'Micheal'

update teachers_salary 
set ielts_score = 9
where teachers = 'Sophia' 

select * from teachers_salary


update teachers_salary 
set ielts_score = 6.5
where teachers = 'Liam' 

begin transaction 
update teachers_salary 
set Teachers = 'First name'

rollback

alter table teachers_salary
add Degree varchar(30) default 'Bachelor';

alter table teachers_salary
drop column Degree;

update teachers_salary
set Degree = 'Bachelor'

select * from teachers_salary


update teachers_salary
set Degree = 'Masters'
where Salary = 88500 or salary=94200

alter table teachers_salary
add Age int default 27;


update teachers_salary
set age = 27
where teachers= 'Jonh'


update teachers_salary
set age = 26
where teachers= 'Emily'

update teachers_salary
set age = 24
where teachers= 'Micheal'


update teachers_salary
set age = 29
where teachers= 'Sophia'


update teachers_salary
set age = 28
where teachers= 'Liam'

alter table teachers_salary
drop column Degree

ALTER TABLE teachers_salary
DROP COLUMN age;

select DEGREE from teachers_salary


select * from teachers_salary


create table Students(StudentId int, Firstname varchar(30), LastName varchar(30), Email varchar(100), EnrollmentDate date)

select * from Students		

insert into Students(LastName) values ('Lala')

truncate table students 

insert into Students values (42, 'Jonh', 'Doe', 'JonhDoe@gmail.com', '2023-08-10')


insert into Students values (33, 'Jane', 'Smith', 'JaneSmith@email.com', '2023-09-15'), (22, 'Alice', 'Aamon', 'AliceAamon@mail.ru', '2023-12-22'), (52, 'Bane', 'Yu zhong', 'BaneYuZhong@gmail.com', '2023-10-27')

insert into Students values (66, 'Odetta', 'Sun', 'OdettaSun@email.com', '2023-08-23')


create table Courses(CourseId int, courseName varchar(30), Instructor varchar(30), Duration int, Price int)

select * from Courses

exec sp_rename 'Courses.courseName', 'CourseName', 'COLUMN'

insert into Courses values (102, 'Data science', 'Johnson M.', 90, 400), (103, 'Cyber Security', 'Abdulwahid I.', 90, 550), (104, 'Digital Marketing', 'Dr, White', 65, 350), (105, 'Graphic Design', 'Ms. Green', 45, 250)

insert into Courses values (105, 'Machine Learning', 'Dr. Nolan', 45, 300)



create table Instructor_certifications(CertificationId int, InstructorName varchar(30), CertificationTitle varchar(30), IssuingOrganization varchar(30), CertificationDate varchar(30))

select * from Courses


insert into Instructor_certifications values (195163, 'Sarah Brown', 'Digital Marketing','Marketing Hub','2021-10-20'), (233993, 'Mark White', 'Full stack developer','Coding Academy','2023-02-01'), (942766, 'Lisa Green', 'UX/UI Desidner','Design Academy','2021-11-30'), (975324, 'David Black', 'Data scientist','Data Camp','2023-03-25')

create table ClassSchedule(CourseCode varchar(10), InstructorName varchar(30), DayOfWeek varchar(30), TimeSlot varchar(30), RoomLocation varchar(30))

select * from ClassSchedule

insert into ClassSchedule values ('C102', 'Sarah Brown', 'Tuesday, Thursday, Sunday', '2:20 PM', 'Room B203'), ('C103', 'Mark White', 'Monday, Thursday, Friday', '11:15 AM', 'Room C305'), ('C104', 'Lisa Green', 'Monday, Wednesday, Sunday', '1:40 PM', 'Room D401'), ('C105', 'David Black', 'Tuesday, Thursday, Sunday', '10:45 AM', 'Room E505')


create table LibraryBooks(BookId int, Title varchar(100), Author varchar(100), Genre varchar(100), AvaibilityStatus varchar(100))

select * from LibraryBooks

insert into LibraryBooks values (1, 'The Great Gatsby', 'F. Scott', 'Fiction', 'Aviable'), (2, 'Atomic Habits', 'James Clear', 'Classic', 'Aviable'), (3, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 'Checked Out'), (4, 'Moby-Dick', 'Herman Melville', 'Adventure', 'Aviable'), (5, 'The Catcher in hte Rye', 'J.D. Salinger', 'Fiction', 'Cheched Out'), (6, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 'Aviable')

create table EmployeeAttendance(EmployeeId int, EmployeeName varchar(100), Date date, Status varchar(100), Hoursworked int)

select * from EmployeeAttendance

insert into EmployeeAttendance values (102, 'Sarah Breon', '0', 'Absent', 7) 

insert into EmployeeAttendance values (103, 'Emily Clark', '2023-12-01', 'Absent',7), (104,'Mark Tylor','2023-12-01','Present',8)

insert into employeeattendance values (105,'Ixia Alpha','2023-12-01','Present',6)

create table StudentsGrades(StudentId varchar(30),Name varchar(30), Subject varchar(30), Grade varchar(30), Semester varchar(30))

select * from StudentsGrades

insert into StudentsGrades values ('S003','Carol White','History','C','Spring 2024'),('S002','Bob Green','Science','B','Fall 2023'), ('S004','David Black','Literature','A','Fall 2024'), ('S005','Emma Blue','Art','A','Fall 2023')


create table WeatherDate(Date varchar(30), Location varchar(30), Temprature_C int, Humidity_Percentage int, WindSpeed_km int)

select * from WeatherDate

insert into WeatherDate values ('','Tokyo',10,60,15), ('','Paris',12,80,25), ('','Sydney',22,65,30), ('','Moscow',-5,85,10)

update WeatherDate
set Date = '2024-12-01'

insert into WeatherDate values ('','New York',5,70,20), ('','Tashkent',4,55,32) 

create table Products(ProductID int, Name varchar(30), Category varchar(30), Quantity varchar(30), Price varchar(30))

alter table products
alter column Price int

insert into Products values ('P002','Smartphone','Electronics',200,600), ('P003','Chair','Furniture',100,100), ('P004','Desk','Furniture',100,100), ('P005','Headphones','Accessories',150,50) 

select * from Products
insert into Products values ('P006','Tablet','Electronics',30,350), ('P007','Coffee Maker','Appliances',80,120)


