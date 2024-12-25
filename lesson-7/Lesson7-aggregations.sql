

select cast(avg(salary) as decimal(8,2)) as average_salary
from HR.Employees

select COUNT(department_id) as num_dep,  
count(distinct department_id) as realdepnum, 
count (*) as star_id
from HR.Employees 

select MAX(salary), from HR.Employees

select * from HR.Employees



select ord_date,
		SUM(purch_amt) as daily_total
from Inventory.Orders
group by ord_date


select 
		salesman_id,
		SUM(purch_amt) as Total_sales
from Inventory.Orders
group by salesman_id
order by Total_sales 


Select * from Inventory.Orders 


select 
		 ord_date, salesman_id,
		SUM(purch_amt) as Total_sales
from Inventory.Orders
group by ord_date,salesman_id
order by ord_date 


-- Step 1: Create the FactsSales Table
CREATE TABLE FactsSales (
    SalesID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    ProductName NVARCHAR(50),
    ProductPrice DECIMAL(10, 2),
    SalesDate DATE,
    Quantity INT,
    SalesmanID INT
);

-- Step 2: Insert 100 Rows of Sample Data
INSERT INTO FactsSales (ProductID, ProductName, ProductPrice, SalesDate, Quantity, SalesmanID)
VALUES
-- Day 1 Data
(1, 'Laptop', 750.00, '2024-12-23', 2, 101),
(2, 'Smartphone', 500.00, '2024-12-23', 5, 102),
(3, 'Tablet', 300.00, '2024-12-23', 3, 103),
(4, 'Headphones', 50.00, '2024-12-23', 10, 104),
(5, 'Monitor', 200.00, '2024-12-23', 1, 105),
-- Repeat similar entries to fill 100 rows
(6, 'Keyboard', 30.00, '2024-12-23', 8, 106),
(7, 'Mouse', 20.00, '2024-12-23', 15, 107),
(8, 'Printer', 120.00, '2024-12-23', 2, 108),
(9, 'Speaker', 45.00, '2024-12-23', 7, 109),
(10, 'External Hard Drive', 100.00, '2024-12-23', 3, 110),

-- Day 2 Data
(1, 'Laptop', 750.00, '2024-12-24', 1, 101),
(2, 'Smartphone', 500.00, '2024-12-24', 3, 102),
(3, 'Tablet', 300.00, '2024-12-24', 2, 103),
(4, 'Headphones', 50.00, '2024-12-24', 5, 104),
(5, 'Monitor', 200.00, '2024-12-24', 4, 105),
-- Repeat similar entries to fill 100 rows
(6, 'Keyboard', 30.00, '2024-12-24', 10, 106),
(7, 'Mouse', 20.00, '2024-12-24', 20, 107),
(8, 'Printer', 120.00, '2024-12-24', 1, 108),
(9, 'Speaker', 45.00, '2024-12-24', 4, 109),
(10, 'External Hard Drive', 100.00, '2024-12-24', 2, 110),

-- Day 3 Data
(1, 'Laptop', 750.00, '2024-12-25', 1, 101),
(2, 'Smartphone', 500.00, '2024-12-25', 4, 102),
(3, 'Tablet', 300.00, '2024-12-25', 5, 103),
(4, 'Headphones', 50.00, '2024-12-25', 6, 104),
(5, 'Monitor', 200.00, '2024-12-25', 2, 105),
-- Repeat similar entries to fill 100 rows
(6, 'Keyboard', 30.00, '2024-12-25', 7, 106),
(7, 'Mouse', 20.00, '2024-12-25', 10, 107),
(8, 'Printer', 120.00, '2024-12-25', 3, 108),
(9, 'Speaker', 45.00, '2024-12-25', 8, 109),
(10, 'External Hard Drive', 100.00, '2024-12-25', 4, 110);

-- Repeat for the remaining rows to reach 100 total entries.



select  SalesmanID, SUM(Sales) as TotalSales from(
select *, ProductPrice * Quantity as Sales from FactsSales) as A
group by  SalesmanID
order by TotalSales desc


select * from(
select *, ProductPrice * Quantity as Sales from FactsSales) as A


/* select 
from
*/ 


create table city_population ( district_id int, district_name varchar(30),population decimal(10,2),year varchar(20))

insert into city_population values 
                   (1,'Chilonzor',2500,2012),
           (2,'Yakkasaroy',1500,2012),
           (3,'Mirobod',3000,2012),
           (4,'Yashnobod',1000,2012),
           (5,'Bektemir',2000,2012),
           (1,'Chilonzor',2800,2013),
           (2,'Yakkasaroy',1900,2013),
           (3,'Mirobod',2000,2013),
           (4,'Yashnobod',5000,2013),
           (5,'Bektemir',1500,2013)




select * from (
select District_name, population, year from city_population) as source_table 
pivot( sum(population) for year in([2012],[2013] )) 
city_population

--row da year, column da district_name

select * from(
select YEAR, population, district_name from city_population ) as source_table2
pivot( sum(population) for district_name in ([Bektemir],[Chilonzor],[Mirobod],[Yakkasaroy],[Yashnobod]) ) city_population


