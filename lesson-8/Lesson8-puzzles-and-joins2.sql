create table phone_director (customer_id int , Type varchar(30), phone_number varchar(50))


insert into phone_director values ( 1001,'Cellular','555-897-5421'),
                                  ( 1001,'Work','555-897-5421'),
                  ( 1001,'Home','555-897-5421'),
                  ( 2002,'Cellular','555-897-5421'),
                  ( 2002,'Work','555-897-5421'),
                  ( 3003,'Cellular','555-897-5421')

select * from phone_director

select customer_id,isnull(Cellular,'Unknown') as Cellular ,ISNULL(Work,'Unknown') as Work,ISNULL(Home,'Unknown') as Home from(
select customer_id, Type, phone_number from phone_director) as source_table
pivot(max(phone_number) for Type in ([Cellular],[Work],[Home]) ) as A


--PUZZLE 1:
/*
USING THE SalesCustomer TABLE BELOW,
FIND THE TOTAL SALES AS A Total_Sales COLUMN FOR
CUSTOMERS WHO PAID MORE THAN 200000 IN TOTAL.
*/

CREATE TABLE [dbo].[SalesCustomer](
  [CustomerID] [int] NOT NULL,
  [Sales] [money] NULL
) 

INSERT [dbo].[SalesCustomer] ([CustomerID], [Sales]) VALUES 
(30118, 36878.2723),(30118, 27290.9456),(30118, 40248.2376),(30118, 49576.7444),
(30118, 43214.8509),(30118, 36830.6141),(30118, 35194.5141),(30118, 44437.3562),
(30117, 68826.1277),(30117, 82495.6988),(30117, 86193.0846),(30117, 88730.5249),
(30117, 106618.264),(30117, 88479.4098),(30117, 112859.9318),(30117, 97424.9805),
(30117, 62770.1045),(30117, 61426.8586),(30117, 49116.1883),(30117, 14860.6446),
(30116, 47520.5830),(30116, 55317.9431),(30116, 51390.8958),(30116, 57441.8455),
(30115, 757.0030),(30115, 213.0271),(30115, 1650.7273),(30115, 757.0030),
(30115, 861.7436),(30115, 2069.7699),(30115, 2949.1326),(30115, 775.4107),
(30114, 641.7458),(30114, 201.2336),(30114, 4510.4959),(30114, 3315.8040),
(30114, 516.5278),(30114, 986.2091),(30114, 392.1097),(30114, 2570.9074)


select CustomerID, SUM(Sales) as Total_Sales from dbo.SalesCustomer
group by CustomerID
having sum(sales)>200000


--PUZZLE 2:
/*
USING THE Students TABLE BELOW,
FIND THE NAME OF THE STUDENT WHO GOT
HIGHEST NUMBER OF GRADE "A" WHEN COUNTED.
THE OUTPUT SHOULD CONTAIN ONLY THE NAME OF THE STUDENT.
*/

CREATE TABLE [dbo].[Students1](
  [Name] [varchar](100),
  [Subject] [varchar](100),
  [Grade] [char](1)
) 

INSERT [dbo].[Students1] ([Name], [Subject], [Grade]) VALUES
('Josh', 'Physics', 'A'),('Josh', 'Accounting', 'A'),('Josh', 'IT', 'A'),
('Josh', 'Math', 'C'),('Karen', 'Physics', 'A'),('Karen', 'Accounting', 'B'),
('Karen', 'IT', 'A'),('Patric', 'Physics', 'A'),('Patric', 'Accounting', 'B'),
('Patric', 'IT', 'C')


select top 1 Name from Students1
where Grade='A'
group by Name
order by count(Grade) desc




--RDBMS --  relational database management system --

create table department (depart_id int, depart_name varchar(30))

insert into department values (1,'HR'),(2,'Finance'),(3,'Marketing')


create table employee (emp_id int, emp_name varchar(30), salary decimal(10,2))

alter table employee
add depart_id int

insert into employee values (1,'Sam',2000,2),(2,'Max',1500,1),(3,'Bob',1700,3)

select * from employee
select * from department

select E.emp_name, D.depart_name from employee as E
join department as D
on E.depart_id = D.depart_id

select  department_id, SUM(salary) as Total_salary from HR.Employees
where department_id=90
group by department_id

select Department_id, MAX(salary) as MaxSalary , 
						count(employee_id) as EmployeeCount,
						count(distinct manager_id) as NumManagers from hr.Employees
--where salary = 30
group by department_id
having department_id in (30,90,100)

select AVG(Salary) from hr.employees

SELECT department_id, AVG(salary) 
FROM
		HR.Employees
GROUP BY 
		department_id

SELECT AVG(salary) from HR.Employees 
where salary > (SELECT AVG(salary) from HR.Employees)




SELECT * from HR.Employees 
where salary > (SELECT AVG(salary) from HR.Employees)



(SELECT department_id, AVG(salary) from HR.Employees 
where salary > (SELECT AVG(salary) from HR.Employees)
group by department_id)



SELECT department_id, AVG(salary) 
FROM
		HR.Employees
GROUP BY 
		department_id
HAVING 
		avg(salary) > (SELECT AVG(salary) from HR.Employees )

		
SELECT department_id, AVG(salary) 
FROM
		HR.Employees
GROUP BY 
		department_id


select employee_id,last_name, salary from HR.Employees
Where  salary in (
select  MAX(salary) from HR.Employees
GROUP BY department_id)

select  MAX(salary) from HR.Employees
GROUP BY department_id

--Inner join


select * from uzbnumbers


create table UzbNumbers(Number int,Name varchar(30))
create table EngNumbers(Number int,Name varchar(30))
create table RusNumbers(Number int,Name nvarchar(30))

insert into UzbNumbers values (6,'Olti'),(2,'Ikki'),(3,'Uch'),(1,'Bir')
insert into EngNumbers values (1,'One'),(2,'Two'),(3,'Three'),(4,'Four')
insert into RusNumbers values (1,N'Один'),(2,N'Два'),(3,N'Три'),(5,N'Пять')

drop table RusNumbers

delete from uzbnumbers
where number = 4

select *  from UzbNumbers
select *  from EngNumbers
select *  from RusNumbers

select UzbNumbers.Number, UzbNumbers.Name, EngNumbers.Name from UzbNumbers
join EngNumbers on UzbNumbers.Number = EngNumbers.Number 


select u.Number as Number, u.Name as UzbName ,
				e.Name as EngName, r.name as RusName from UzbNumbers as u
join EngNumbers as e on u.Number = e.Number
join rusnumbers as r on e.Number = r.number

--left join

select * from UzbNumbers
left join EngNumbers on UzbNumbers.Number = EngNumbers.Number

--right join

select * from UzbNumbers
right join EngNumbers on UzbNumbers.Number = EngNumbers.Number


--Full join

select * from UzbNumbers
full join EngNumbers on UzbNumbers.Number = EngNumbers.Number


--Cross join

create table presents(name varchar(50), id int primary key)

create table students2(name varchar(50), present_id int foreign key references presents(id))


insert into presents values ('Laptop', 1 ), ('Mobile Phone', 2)

exec sp_help 'students2'

alter table students2
drop constraint FK__students2__prese__2EDAF651

alter table students2
drop column present_id


insert into students2 values ('Mark'),('Venessa'),('Macs'),('Bob')

select * from students2
select * from presents

select * from students2 
cross join presents


select * from HR.Employees
select * from HR.Departments	
select * from HR.Locations

select employee_id, first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,e.manager_id,e.department_id,department_name from HR.Employees e
left join HR.Departments h on e.department_id = h.department_id


select e.*  , h.department_name, l.street_address from HR.Employees e
 join HR.Departments h on e.department_id = h.department_id
 join HR.Locations l on h.location_id = l.location_id

 select * from movies.Movie

 select * from Movies.Actor

 select * from Movies.Movie_cast


  select mm.mov_title, trim(ma.act_fname) + ' ' + ma.act_lname as full_name, mc.role from Movies.Movie_cast mc
left  join  movies.Movie mm on mc.mov_id = mm.mov_id
left join Movies.Actor ma on mc.act_id = ma.act_id


select * from Movies.Movie_cast mc
FULL JOIN Movies.Actor ma on mc.act_id=ma.act_id
where role is null

select sc.country_id, sc.country_name from SOCCER.soccer_country sc
join (select * from SOCCER.match_details 
where play_stage ='F' and win_lose = 'W') Winner on sc.country_id = Winner.team_id
select * from SOCCER.soccer_country

select * from SOCCER.match_details md
join SOCCER.soccer_country sc on md.team_id = sc.country_id 
where play_stage ='F' and win_lose = 'W'


create table Item (
					ITEM_NO CHAR(12) not null,
					ITEM_DESC CHAR(30) null )

create table ORDERED(CUST_NO CHAR(15)not null, ITEM_NO CHAR(12)not null, QTY_ORDERED INT NULL)

INSERT INTO Item (ITEM_NO, ITEM_DESC) 
values (1,'Large Bags'), 
		(2,'Medium Bags'),
		(3,'Large Boxes'),
		(4,'Medium Boxes')

Insert into ORDERED (CUST_NO,ITEM_NO,QTY_ORDERED) values
(1,1,10),
(1,2,15),
(1,4,20),
(2,3,30),
(2,4,40),
(3,1,20),
(3,2,50),
(3,3,10)

select * from Item
select * from ORDERED

delete from Item
where ITEM_DESC='Medium Bags'

truncate table item


select * from Item
select * from ORDERED

select * from ORDERED o
full JOIN Item i on o.ITEM_NO = i.ITEM_NO


select * from ORDERED 
left join (select ordered.ITEM_NO as oin,Item.ITEM_NO from ORDERED
cross join Item) gg on ORDERED.ITEM_NO = gg.oin


SELECT DISTINCT CUST_NO FROM ORDERED



select cus.CUST_NO,isnull(o.ITEM_NO,0) as ITEM_NO ,isnull(o.QTY_ORDERED,0) as QTY_ORDERED from (SELECT	* from (select distinct cust_no from ORDERED) customers
cross join Item) cus
left join ORDERED o  on CUS.CUST_NO = o.CUST_NO and O.ITEM_NO = cus.ITEM_NO


