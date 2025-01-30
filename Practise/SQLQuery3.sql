INSERT INTO #EmployeeSalaries (EmployeeName, Salary, SalaryPaidDate)
VALUES 
('John Doe', 2000, '2024-01-01'),
('John Doe', 2200, '2024-02-01'),
('John Doe', 2100, '2024-03-01'),
('Jane Smith', 3000, '2024-01-01'),
('Jane Smith', 3100, '2024-02-01'),
('Jane Smith', 2800, '2024-03-01'),
('Alice Brown', 1500, '2024-01-01'),
('Alice Brown', 1600, '2024-02-01'),
('Alice Brown', 1700, '2024-03-01');


CREATE TABLE #EmployeeSalaries (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    Salary DECIMAL(10,2),
    SalaryPaidDate DATE
);


select *,LAG(Salary, 1) over(partition by employeename order by (select null)) prev,
		(cast(Salary- LAG(Salary, 1) over(partition by employeename order by (select null)))*100/LAG(Salary, 1)
		over(partition by employeename order by (select null)) as decimal(3,1))  from #EmployeeSalaries



CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (ID, Name, Salary) VALUES
(1, 'John', 5000),
(2, 'Alice', 7000),
(3, 'Bob', 5000),
(4, 'Mike', 10000);


select * from (select *, DENSE_RANK() over (order by salary desc) as ee  from Employees) d
where ee = 2

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);

INSERT INTO Employees (ID, Name, Salary, Department) VALUES
(1, 'John', 5000, 'Sales'),
(2, 'Alice', 7000, 'HR'),
(3, 'Bob', 5000, 'HR'),
(4, 'Mike', 10000, 'IT'),
(5, 'Sam', 8000, 'IT');


select ID,Name,Salary,Department from (select *, RANK() over (partition by department order by salary) as b from Employees) a
where b = 1
	CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Product VARCHAR(50),
    Amount INT,
    Sale_Date DATE
);

INSERT INTO Sales (Sale_ID, Product, Amount, Sale_Date) VALUES
(1, 'Laptop', 1000, '2024-01-01'),
(2, 'Laptop', 1500, '2024-01-05'),
(3, 'Phone', 800, '2024-01-10'),
(4, 'Laptop', 1300, '2024-01-12');


select *, SUM(amount) over (partition by product order by sale_date) from Sales


CREATE TABLE Employees1 (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
);

INSERT INTO Employees1 (ID, Name, Salary) VALUES
(1, 'John', 5000),
(2, 'Alice', 7000),
(3, 'Bob', 6000),
(4, 'Mike', 10000);

select *, LaG(Salary, 1 ) over (order by salary desc ) from Employees1
drop table Employees

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    Join_Date DATE
);

INSERT INTO Employees (ID, Name, Salary, Join_Date) VALUES
(1, 'John', 5000, '2024-01-01'),
(2, 'Alice', 7000, '2024-02-01'),
(3, 'Bob', 6500, '2024-03-01'),
(4, 'Mike', 10000, '2024-04-01');


select ID,Name,Salary,Join_Date from (select *, LAG(Salary,1) over (order by join_date) as prev from Employees) as s
where Salary > prev


use Movies

alter view Stevenfilms as
select top 100 percent FilmName,FilmRunTimeMinutes ,(FilmBoxOfficeDollars - FilmBudgetDollars) as [Profit or Loss] , FilmOscarNominations,
	FilmOscarWins, LanguageName , StudioName , CountryName 	from tblFilm as f1, (select * from tblLanguage) as f2, (select * from tblStudio) f3, (select * from tblCountry) as f4
where FilmDirectorID = (select DirectorID from tblDirector
where DirectorName = 'steven spielberg'
) and f1.FilmLanguageID = f2.LanguageID and f1.FilmStudioID = f3.StudioID and f1.FilmCountryID = f4.CountryID 
order by FilmOscarWins

select * from tblStudio

select * from Stevenfilms
order by FilmOscarWins desc


-- Create a sample table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SalesPerson VARCHAR(50),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

-- Insert sample data into the Sales table
INSERT INTO Sales (SaleID, SalesPerson, SaleAmount, SaleDate)
VALUES
    (1, 'Alice', 200.00, '2023-01-01'),
    (2, 'Bob', 150.00, '2023-01-01'),
    (3, 'Alice', 300.00, '2023-01-02'),
    (4, 'Bob', 400.00, '2023-01-02'),
    (5, 'Charlie', 250.00, '2023-01-03'),
    (6, 'Alice', 350.00, '2023-01-03'),
    (7, 'Bob', 450.00, '2023-01-03');
-- Puzzle 2

-- Create a sample table for Employee Sales
CREATE TABLE EmployeeSales (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

-- Insert sample data into the EmployeeSales table
INSERT INTO EmployeeSales (EmployeeID, EmployeeName, Department, SaleAmount, SaleDate)
VALUES
    (1, 'Alice', 'Electronics', 200.00, '2023-01-01'),
    (2, 'Bob', 'Electronics', 150.00, '2023-01-01'),
    (3, 'Charlie', 'Electronics', 300.00, '2023-01-02'),
    (4, 'Alice', 'Electronics', 400.00, '2023-01-02'),
    (5, 'Bob', 'Electronics', 250.00, '2023-01-03'),
    (6, 'Charlie', 'Electronics', 350.00, '2023-01-03'),
    (7, 'David', 'Home Appliances', 600.00, '2023-01-01'),
    (8, 'Eve', 'Home Appliances', 450.00, '2023-01-02'),
    (9, 'Frank', 'Home Appliances', 700.00, '2023-01-03'),
    (10, 'Grace', 'Home Appliances', 800.00, '2023-01-03'),
    (11, 'Alice', 'Electronics', 500.00, '2023-01-04'),
    (12, 'Bob', 'Electronics', 350.00, '2023-01-04'),
    (13, 'Charlie', 'Electronics', 650.00, '2023-01-04'),
    (14, 'David', 'Home Appliances', 900.00, '2023-01-02'),
    (15, 'Eve', 'Home Appliances', 300.00, '2023-01-03');

select   Department, SaleAmount + acc , SaleDate from (select *, LEAD(SaleAmount) over (partition by department order by saledate) as acc  from EmployeeSales) a
group by saledate, department
SUM(SaleAmount) over (partition by department order by saledate)

-- Puzzle 3 

select * from (select *, RANK() over (partition by department order by saleamount desc) as top1 from EmployeeSales) as a
where top1 in (1,2)

--departmentdagi har bitta sotuv , departmentdagi ortacha sotuvdan qanchalik farq qiladi.

select *, case when Difference > 100 then concat(Difference,'% Less then average') else concat(Difference,' % more than average') end
				from (select *, cast(AVG(SaleAmount) over (partition by department)*100/SaleAmount as decimal(10,2)) as Difference from EmployeeSales) a


select *, cast( SaleAmount  - AVG(SaleAmount) over (partition by department)as decimal(6,2)) as Difference 
				from EmployeeSales	



200 --- 100
350 --- x









