
--Question 1:(10 score)
/*
  split column FullName into 3 part ( Firstname, Middlename, and Lastname)
*/

create table Students(
	StudentID int,
	FullName varchar(100),
	Grade decimal(5,2)
)

insert into Students values 
(1,'James Alexander Hamilton',98.5),
(2,'Arthur George Mason',78.2),
(3,'Lily B Peters',81),
(4,'Kayne Thomas Derek',87.3),
(5,'April Dukane Paris',79.1),
(6,'Payton Carl Johnson',97.1)

--Solution:


select *, LEFT([FullName],CHARINDEX(' ', FullName)) as FirstName,
SUBSTRING(FullName, CHARINDEX(' ', FullName) + 1, 
CHARINDEX(' ', FullName + ' ', CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1) AS MiddleName,
RIGHT( FullName, LEN(fullname) - CHARINDEX(' ', FullName,CHARINDEX(' ', FullName)+1)) as LastName
from Students





----------------------------------------------------------------------------------------------------
--Question 2:(10 score)
/* 
   From the Employees table below, PER department compare the salaries
   of employees who were hired first with ones who were hired last and show the 
   difference.
*/

CREATE TABLE Employees (
    employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    department_id int,
    salary decimal(10, 2),
    hire_date date
)

INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (1, 'Alice', 'Johnson', 101, 75000.00, '2020-02-15'),
    (2, 'Bob', 'Smith', 102, 64000.00, '2019-07-22'),
    (3, 'Charlie', 'Brown', 103, 82000.00, '2021-03-18'),
    (4, 'Diana', 'Evans', 101, 92000.00, '2018-11-05'),
    (5, 'Eve', 'Campbell', 104, 56000.00, '2022-01-10'),
    (6, 'Frank', 'Harris', 102, 72000.00, '2020-05-29'),
    (7, 'Grace', 'Lee', 103, 81000.00, '2019-09-17'),
    (8, 'Henry', 'Green', 104, 59000.00, '2021-06-01'),
    (9, 'Isabella', 'Garcia', 101, 66000.00, '2020-12-08'),
    (10, 'Jack', 'White', 102, 87000.00, '2017-08-25'),
	(11, 'Joe', 'Smith', 101, 75000.00, '2017-08-25'),
	(12, 'Lily', 'Pete', 102, 72000.00, '2017-08-25')

--Solution:


select  first.department_id, firsthired - Lasthired as [Difference brtween fisrt and last salary] from (select department_id,  salary as firsthired from Employees
where hire_date in (select  MIN(hire_date) from Employees group by department_id)
group by department_id, salary) as first,(select department_id,  salary as Lasthired from Employees
where hire_date in (select  max(hire_date) from Employees group by department_id)
group by department_id, salary) as last
where  first.department_id =  last.department_id




select * from Employees





-------------------------------------------------------------------------------------
--Question 3:(10 score)
/*
	Using the employees table above, find rows where the employees receive 
	higher than or equal to the average salary of their department

	Show 2 solutions, 1 using Subqueries another using Window Functions
*/

--Solution:

select e.employee_id, e.first_name, e.last_name, e.department_id, e.salary, e.hire_date from Employees e
join (select *, AVG(salary) over (partition by department_id) as AVGs from Employees) as ee
on e.employee_id = ee.employee_id and e.salary >= ee.AVGs

select * from Employees as e
where salary >= (select AVG(salary) from Employees where  department_id= e.department_id)


-------------------------------------------------------------------------------------
--Question 4:(10 score)
/*
	Using the employees table above, find employee(s) who receive(s) the second highest 
	salary in their departments.
*/

--Solution:

select employee_id,first_name, last_name, department_id, salary, hire_date from 
(select *, DENSE_RANK() over (partition by department_id order by salary desc) as Ranking from Employees) a
where Ranking = 2




--------------------------------------------------------------------------------------

--Question 5: (10 points)
/*
	Create a function that calculates how many business days an employee has worked from 
	the day she/he was hired up until today.
	Use the created function in the table below to find the number of business days workedas
	as a seperate column Number_Of_Days Worked.
	Business Days are all days except weekends. No need to exlcude holidays.
*/
create table HR_Staff
(EmployeeID int,Employee_Name varchar(100),Hire_Date date,Salary float)

INSERT INTO HR_Staff (EmployeeID, Employee_Name, Hire_Date, Salary) VALUES
(1, 'Alice Johnson', '2015-06-10', 55000),
(2, 'Bob Smith', '2016-09-15', 60000),
(3, 'Carol White', '2017-01-22', 75000),
(4, 'David Brown', '2018-03-03', 52000),
(5, 'Emma Jones', '2019-07-25', 58000),
(6, 'Frank Black', '2020-10-30', 62000),
(7, 'Grace Green', '2021-05-18', 67000),
(8, 'Harry Blue', '2018-12-05', 71000),
(9, 'Ivy King', '2016-04-17', 54000),
(10, 'Jack Gold', '2022-01-01', 50000),
(11, 'Karen Stone', '2019-08-14', 60000),
(12, 'Leo Wood', '2020-02-20', 65000),
(13, 'Mia Scott', '2021-09-07', 63000),
(14, 'Nick Adams', '2015-11-03', 68000),
(15, 'Olivia Hall', '2017-02-13', 56000),
(16, 'Paul Carter', '2018-06-21', 59000),
(17, 'Quinn Turner', '2021-04-26', 72000),
(18, 'Rachel Evans', '2019-12-12', 53000),
(19, 'Sam Brown', '2016-07-09', 66000),
(20, 'Tina Lake', '2022-06-01', 64000);


select * from HR_Staff


create function Number_of_daysWorked ()
returns table
as
	return ( select *, datediff(day,hire_date,GETDATE()) 
	- (datediff(WEEK,hire_date,GETDATE())*2)
	as Number_OFdays from HR_Staff)


select * from Number_of_daysWorked()


