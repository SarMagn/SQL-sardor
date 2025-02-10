



declare @string  as varchar(max)
set @string = 'Sardor' 


select LEN(@string)
select DATALENGTH(@string)


SELECT SUBSTRING('CustomerName', 1, 5) AS ExtractString



select ROUND(45.356,0) as Column1
select ROUND(45.356,1) as Column1
select ROUND(45.356,2) as Column1

select ABS(-343) as column1


select POWER(4,3) 
\


select FLOOR(2.6)
select FLOOR(-2.6)
select FLOOR(2)



select ceiling(2.6)
select ceiling(-2.6)
select ceiling(2)

select GETDATE()
select datename(WEEKDAY,GETDATE())


SELECT DATEDIFF(month, '2017/08/25', '2011/08/25')

select DATEADD(DAY,2 ,'2025-01-23')


SELECT 
    UPPER(LEFT(FirstName, 1)) + LOWER(SUBSTRING(FirstName, 2, LEN(FirstName))) AS ProperCaseFirstName,
    UPPER(LEFT(LastName, 1)) + LOWER(SUBSTRING(LastName, 2, LEN(LastName))) AS ProperCaseLastName,
    Email,
    LEFT(Phone, 3) + '-' + SUBSTRING(Phone, 4, 3) + '-' + RIGHT(Phone, 4) AS FormattedPhone,
    REPLACE(Address, 'Street', 'St.') AS ShortAddress,
    CHARINDEX('@', Email) AS EmailAtPosition,
    LEN(Email) AS EmailLength
FROM Customers;


SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    ROUND(Salary * 1.10, 2) AS IncreasedSalary,  -- 10% salary increase
    CEILING(Salary / 1000) * 1000 AS SalaryRoundedUp, -- Rounds up to the nearest 1000
    FLOOR(Salary / 1000) * 1000 AS SalaryRoundedDown, -- Rounds down to the nearest 1000
    POWER(YearsOfExperience, 2) AS ExperienceSquared, -- Square of years of experience
    SQRT(Salary) AS SalarySquareRoot, -- Square root of the salary
    ABS(Bonus - 500) AS BonusDifference, -- Absolute difference from 500
    RAND(EmployeeID) * 100 AS RandomBonus -- Random bonus (seeded by EmployeeID)
FROM Employees;


SELECT 
    EmployeeID,
    FirstName,
    LastName,
    BirthDate,
    HireDate,
    
    -- Calculate Employee Age
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
    
    -- Calculate Years Worked
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked,
    
    -- Find Next Work Anniversary
    DATEADD(YEAR, DATEDIFF(YEAR, HireDate, GETDATE()) + 1, HireDate) AS NextAnniversary,
    
    -- Extract Day, Month, and Year from HireDate
    DAY(HireDate) AS HireDay,
    MONTH(HireDate) AS HireMonth,
    YEAR(HireDate) AS HireYear,

    -- Format HireDate as 'Month Day, Year'
    FORMAT(HireDate, 'MMMM dd, yyyy') AS FormattedHireDate,

    -- Determine the Next Performance Review (1st Monday of Next Quarter)
    DATEADD(QUARTER, 1, DATEFROMPARTS(YEAR(GETDATE()), ((MONTH(GETDATE()) - 1) / 3 + 1) * 3 + 1, 1)) AS NextReviewDate
FROM Employees;

declare @name varchar(max) = 'sArDoR'
select upper(LEFT(@name,1)) + LOWER(SUBSTRING(@Name,2,len(@name)))


SELECT * FROM Employees WHERE UPPER(LastName) = 'SMITH';

SELECT * FROM Orders 
WHERE OrderDate >= '2023-01-01' AND OrderDate < '2024-01-01';

SELECT * FROM Orders WHERE YEAR(OrderDate) = 2023;


SELECT d.CustomerID, d.OrderCount
FROM (
    -- Derived Table: Count orders per customer
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
) AS d
WHERE d.OrderCount > 5;

SELECT d.CustomerID, d.OrderCount
FROM (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    WHERE OrderDate >= '2024-01-01' AND OrderDate <= '2024-01-31'
    GROUP BY CustomerID
) AS d
WHERE d.OrderCount > 5;



WITH EmployeeHierarchy AS (
    -- Anchor Query: Get the top-level manager (employees with no manager)
    SELECT EmployeeID, Name, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive Query: Get employees reporting to previous level employees
    SELECT e.EmployeeID, e.Name, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
-- Final Select: Retrieve full hierarchy
SELECT * FROM EmployeeHierarchy;




WITH CTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1 as Number1 FROM CTE  -- No stopping condition!
	where Number < 500
)
SELECT * FROM CTE;

WITH CustomerSales AS (
    -- Step 1: Aggregate total sales per customer
    SELECT 
        CustomerID, 
        SUM(Amount) AS TotalSpent
    FROM Sales
    GROUP BY CustomerID
)
-- Step 2: Filter customers who spent more than $500
SELECT * 
FROM CustomerSales
WHERE TotalSpent > 500;


WITH EmployeeHierarchy AS (
    -- Step 1: Anchor Query - Select CEO (Employee with no Manager)
    SELECT 
        EmployeeID, 
        EmployeeName, 
        ManagerID, 
        1 AS HierarchyLevel
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Step 2: Recursive Query - Select Employees Reporting to Managers
    SELECT 
        e.EmployeeID, 
        e.EmployeeName, 
        e.ManagerID, 
        eh.HierarchyLevel + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;



DECLARE @EmployeeTable TABLE (
    EmployeeID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert Data
INSERT INTO @EmployeeTable VALUES (1, 'Alice', 7000.00), (2, 'Bob', 7500.00);

-- Select Data
SELECT * FROM @EmployeeTable;



select * from tblFilm

create view FilmsContainsJintheirname
as 
(select * from tblFilm
where FilmName like '%j%')

select * from FilmsContainsJintheirname


create function NominatedFilmTable (@CountofNominations int)
returns table
as
	return( select FilmName from tblFilm
	where FilmOscarNominations = @CountofNominations)



select * from NominatedFilmtable(10)

create function FullName (@FirstName varchar(50), @LastName varchar(50))
returns varchar(max)
as 
begin
	return concat(@firstName,' ', @lastNAme)
end


select dbo.fullname('Sardor', 'Ismatov')


create procedure GetNominatedFilms
@Nominations int
as
begin 
	select * from tblFilm
	where FilmOscarNominations <= @Nominations
end 

exec GetNominatedFilms '10'


CREATE PROCEDURE AddFilm  
    @FilmName NVARCHAR(100),  
    @Nominations INT  
AS  
BEGIN  
    BEGIN TRANSACTION  
    BEGIN TRY  
        INSERT INTO tblFilm (FilmName, FilmOscarNominations)  
        VALUES (@FilmName, @Nominations);  
        
        COMMIT TRANSACTION;  -- Save changes  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  -- Undo changes in case of error  
        PRINT 'Error occurred. Transaction rolled back.';  
    END CATCH  
END;



DECLARE @CountofNominations INT = 5;
SELECT FilmName FROM tblFilm WHERE FilmOscarNominations = @CountofNominations;


	MERGE INTO Sales AS target  
	USING Sales_Updates AS source  
	ON target.SaleID = source.SaleID  -- Matching condition

	WHEN MATCHED AND target.SalesAmount <> source.SalesAmount THEN  
		UPDATE SET target.SalesAmount = source.SalesAmount  -- Update existing records

	WHEN NOT MATCHED THEN  
		INSERT (SaleID, ProductID, SalesAmount)  
		VALUES (source.SaleID, source.ProductID, source.SalesAmount);  -- Insert new records



MERGE INTO Customers AS target  
USING Customer_Updates AS source  
ON target.CustomerID = source.CustomerID  -- Matching Condition

WHEN MATCHED AND (target.CustomerName <> source.CustomerName  
                  OR target.Email <> source.Email) THEN  
    UPDATE SET target.CustomerName = source.CustomerName,  
               target.Email = source.Email  -- Update Existing Customers

WHEN NOT MATCHED THEN  
    INSERT (CustomerID, CustomerName, Email)  
    VALUES (source.CustomerID, source.CustomerName, source.Email);  -- Insert New Customers



	MERGE INTO Products AS target  
USING Product_Updates AS source  
ON target.ProductID = source.ProductID  -- Matching Condition

-- 🔹 Update existing records if details have changed
WHEN MATCHED AND (target.ProductName <> source.ProductName  
                  OR target.Price <> source.Price) THEN  
    UPDATE SET target.ProductName = source.ProductName,  
               target.Price = source.Price  

-- 🔹 Insert new products if they don't exist in the target table
WHEN NOT MATCHED THEN  
    INSERT (ProductID, ProductName, Price)  
    VALUES (source.ProductID, source.ProductName, source.Price)  

-- 🔹 Delete products from the target table if they are not in the source table
WHEN NOT MATCHED BY SOURCE THEN  
    DELETE;


select * from tblFilm
where exists (select FilmOscarNominations from tblFilm where FilmOscarNominations = 16)

with cTE as(
select * , RANK() over (order by filmruntimeminutes desc) as Ranking  from tblFilm)
select * from cTE
where ranking = 1



SELECT dep_id, emp_name, salary, 
       PERCENT_RANK() OVER (ORDER BY salary ) AS rank
FROM Employee.employees


select * from Employee.employees



select *, NTILE(30) over (order by filmid) from tblFilm


SELECT order_id, order_date, sales_amount,  
       SUM(sales_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS running_total  
FROM sales;

SELECT order_id, order_date, sales_amount,  
       SUM(sales_amount) OVER (ORDER BY order_date ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS future_sales  
FROM sales;


SELECT order_id, order_date, sales_amount,  
       SUM(sales_amount) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_total  
FROM sales;


