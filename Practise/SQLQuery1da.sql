select * from INFORMATION_SCHEMA.TABLES


select coalesce(studentid,'Unknown') as StudentID ,  Name, Subject, Grade,  coalesce(Semester,'Not found') from dbo.StudentsGrades


alter table dbo.studentsGrades drop constraint Unique_subject 

insert into StudentsGrades(subject) values ('Math')

select * from StudentsGrades
union all
select * from customers

SELECT *  
FROM hr.Employees e  
CROSS JOIN hr.Departments d;



SELECT * FROM hr.Employees e 


-- Create tables
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products10 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Sales INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Insert data into Categories
INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books');

-- Insert data into Products
INSERT INTO Products10 (ProductID, ProductName, CategoryID, Sales)
VALUES
(1, 'Laptop', 1, 5000),
(2, 'Smartphone', 1, 7000),
(3, 'T-Shirt', 2, 2000),
(4, 'Jeans', 2, 2000),
(5, 'Novel', 3, 1500),
(6, 'Textbook',  3, 3000);


select CategoryName, ProductName ,MAX(Sales)  from Categories as c
join Products10 as p on c.CategoryID = p.CategoryID
group by c.CategoryID, CategoryName, ProductName

------------------------------




CREATE TABLE #Employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO #Employees (Id, Name, Salary) VALUES
(1, 'Menny', 60000),
(2, 'Kai', 50000),
(3, 'Jae Li', 60000),
(4, 'David', 50000),
(5, 'Eve', 70000),
(6, 'Frank', 70000);

--Find the most common salary


insert into #Employees values(
7, 'Dimarco', 70000)


with cte as (
select top 1 COUNT(Salary) as [Count of employees] , Salary from #Employees
group by Salary	
order by [Count of employees] desc)
select Salary from cte


CREATE TABLE #EmployeeDepartmentHistory (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    DepartmentId INT,
    EffectiveDate DATE,
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id)
);

INSERT INTO #EmployeeDepartmentHistory (Id, EmployeeId, DepartmentId, EffectiveDate) VALUES
(1, 1, 1, '2022-01-01'),
(2, 1, 2, '2023-01-01'),
(3, 2, 1, '2022-01-01'),
(4, 2, 1, '2023-01-01'),
(5, 3, 2, '2022-01-01'),
(6, 3, 1, '2023-01-01');

--Employees who have changed their departments


with cte1 as ( 
select *, isnull(LaG(DepartmentId) over (partition by employeeId order by departmentId) ,DepartmentId) as [NextDept] 
from #EmployeeDepartmentHistory),
cte2 as (
select * from cte1
where DepartmentId <> NextDept 
), cte3 as (
select * from #EmployeeDepartmentHistory
where EmployeeId in (select EmployeeId from cte2)),
cte4 as (
select distinct Id, EmployeeId, DepartmentId as Prevdept, lead(DepartmentId) over (partition by employeeId order by id) as Nextdept from cte3
)
select *  from cte4
where Nextdept is not null

select * from #EmployeeDepartmentHistory


select *, isnull(LaG(DepartmentId) over (partition by employeeId order by departmentId) ,DepartmentId) as [NextDept] 
from #EmployeeDepartmentHistory



CREATE TABLE SalaryHistory (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    Salary DECIMAL(10, 2),
    EffectiveDate DATE
);

INSERT INTO SalaryHistory (Id, EmployeeId, Salary, EffectiveDate) VALUES
(1, 1, 60000, '2022-01-01'),
(2, 1, 58000, '2023-01-01'),
(3, 2, 50000, '2022-01-01'),
(4, 2, 52000, '2023-01-01'),
(5, 3, 70000, '2022-01-01'),
(6, 3, 65000, '2023-01-01'),
(7, 4, 80000, '2022-01-01'),
(8, 4, 85000, '2023-01-01');

with cte as (
select Id, EmployeeId, Salary,EffectiveDate , isnull(LAG(Salary) over (partition by employeeid order by id),0) as [PrevSalary] 
from SalaryHistory),
cte1 as (
select *, PrevSalary - Salary  as difference from cte
)
select EmployeeId from cte1
where difference > 0



with cte as (
select *, isnull(LAG(Salary) over (partition by employeeid order by id),0) as [NextSalary] from SalaryHistory)
select * from cte



select *, LaG(DepartmentId) over (partition by employeeId order by departmentId) from #EmployeeDepartmentHistory






use Movies

select * from tblFilm

select * from INFORMATION_SCHEMA.TABLES




alter proc DailyFilm (@Filmtime int)
as
declare @FilmID as int
begin
	if not exists ( select * from sys.tables where name = 'SuggestedFilm' )
	begin
		select FilmID , FilmName , FilmReleaseDate  ,
		LanguageName , CountryName  ,  FilmRunTimeMinutes , 
		FilmOscarNominations, CAST(null as varchar(max)) as Suggestions,CAST(null as varchar(max)) as SuggestedTime 
		into SuggestedFilm from tblFilm as tf
			join tblLanguage as tl on tf.FilmLanguageID = tl.LanguageID 
			join tblCountry as tc on tf.FilmCountryID = tc.CountryID
 	end
	select top 1 @FilmID = FilmID from SuggestedFilm
	where FilmRunTimeMinutes < @Filmtime and Suggestions is  null
	order by FilmOscarNominations desc

	if @FilmID is not null
	begin
	update SuggestedFilm
	set Suggestions = 'Suggested', SuggestedTime = GETDATE()
	where FilmID = @FilmID

	select FilmID, FilmName, FilmReleaseDate, LanguageName, CountryName, FilmRunTimeMinutes, FilmOscarNominations
	from SuggestedFilm
	where FilmID = @FilmID
	end
	else 
	begin
	update SuggestedFilm
	set Suggestions = null, SuggestedTime= null
	end

end


exec DailyFilm '120'




select * from SuggestedFilm

drop table SuggestedFilm



select * from msdb.dbo.sysmail_allitems
order by send_request_date desc







DECLARE @Body NVARCHAR(MAX)

SET @Body = 
    '<html><body>' +
    '<h2>Movie Suggestions</h2>' +
    '<table border="1" cellpadding="5" cellspacing="0" style="border-collapse:collapse;">' +
    '<tr><th>FilmID</th><th>FilmName</th><th>FilmReleaseDate</th><th>LanguageName</th><th>CountryName</th><th>FilmRunTimeMinutes</th><th>FilmOscarNominations</th></tr>'

SET @Body = @Body + '</table></body></html>'

SELECT @Body = @Body + 
    '<tr><td>' + top 1 CAST(FilmID AS VARCHAR) + '</td>' +
    '<td>' + FilmName + '</td>' +
    '<td>' + CAST(FilmReleaseDate AS VARCHAR) + '</td>' +
    '<td>' + LanguageName + '</td>' +
    '<td>' + CountryName + '</td>' +
    '<td>' + CAST(FilmRunTimeMinutes AS VARCHAR) + '</td>' +
    '<td>' + CAST(FilmOscarNominations AS VARCHAR) + '</td></tr>'
FROM SuggestedFilm

exec msdb.dbo.sp_send_dbmail
	@profile_name = 'Daily Movies',
	@recipients = 'sardorjonumidvich@gmail.com',
	@subject = 'Movie',
	@body = @Body,
    @body_format = 'HTML';



--------------------------------------------------------------------------------------------------------------------




DECLARE @Body NVARCHAR(MAX)
DECLARE @Filmtime INT = 120

-- Start the HTML body
SET @Body = 
    '<html><body>' +
    '<h2>Movie Suggestions</h2>' +
    '<table border="1" cellpadding="5" cellspacing="0" style="border-collapse:collapse;">' +
    '<tr><th>FilmID</th><th>FilmName</th><th>FilmReleaseDate</th><th>LanguageName</th><th>CountryName</th><th>FilmRunTimeMinutes</th><th>FilmOscarNominations</th></tr>'

-- Execute the stored procedure on the linked server and build the HTML table
DECLARE @TempBody NVARCHAR(MAX) = ''

SELECT @TempBody = @TempBody + 
    '<tr><td>' + CAST(FilmID AS NVARCHAR) + '</td>' +
    '<td>' + FilmName + '</td>' +
    '<td>' + CAST(FilmReleaseDate AS NVARCHAR) + '</td>' +
    '<td>' + LanguageName + '</td>' +
    '<td>' + CountryName + '</td>' +
    '<td>' + CAST(FilmRunTimeMinutes AS NVARCHAR) + '</td>' +
    '<td>' + CAST(FilmOscarNominations AS NVARCHAR) + '</td></tr>'
FROM OPENQUERY([Sardors-laptop\SQLSERVER2025], 'SELECT FilmID, FilmName, FilmReleaseDate, LanguageName, CountryName, FilmRunTimeMinutes, FilmOscarNominations FROM Movies.dbo.DailyFilm WHERE FilmRunTimeMinutes = 120')

-- Append the generated table rows to the body
SET @Body = @Body + @TempBody + '</table></body></html>'

-- Send the email with the HTML body
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Daily Movies',
    @recipients = 'sardorjonumidvich@gmail.com',
    @subject = 'Movie List',
    @body = @Body,
    @body_format = 'HTML';



-------------------------------------------------------------------------------------------------------------------------------------------------


select * from sys.servers

EXEC sp_serveroption 'Sardors-laptop\SQLSERVER2025', 'DATA ACCESS', TRUE;

exec sp_helpserver

	EXEC msdb.dbo.sp_addrolemember 'DatabaseMailUser', 'SARDORS-LAPTOP\Sardor';
select * from rolemem

	SELECT * FROM msdb.dbo.sysmail_event_log
ORDER BY log_date DESC;

SELECT * FROM msdb.dbo.sysmail_event_log
ORDER BY log_date DESC;



DECLARE @Body NVARCHAR(MAX)

SET @Body = 
    '<html><body>' +
    '<h2>Movie Suggestions</h2>' +
    '<table border="1" cellpadding="5" cellspacing="0" style="border-collapse:collapse;">' +
    '<tr><th>FilmID</th><th>FilmName</th><th>FilmReleaseDate</th><th>LanguageName</th><th>CountryName</th><th>FilmRunTimeMinutes</th><th>FilmOscarNominations</th></tr>'

-- Concatenate the rows of the table using FOR XML PATH
SELECT @Body = @Body + 
    '<tr><td>' + CAST(FilmID AS VARCHAR) + '</td>' +
    '<td>' + FilmName + '</td>' +
    '<td>' + CAST(FilmReleaseDate AS VARCHAR) + '</td>' +
    '<td>' + LanguageName + '</td>' +
    '<td>' + CountryName + '</td>' +
    '<td>' + CAST(FilmRunTimeMinutes AS VARCHAR) + '</td>' +
    '<td>' + CAST(FilmOscarNominations AS VARCHAR) + '</td></tr>'
FROM SuggestedFilm

-- Close the table and body tags
SET @Body = @Body + '</table></body></html>'

-- Send the email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Daily Movies',
    @recipients = 'sardorjonumidvich@gmail.com',
    @subject = 'Movie List',
    @body = @Body,
    @body_format = 'HTML';

-------------------------------------------------------------------------------------------------------------------------------------------------



DECLARE @Body NVARCHAR(MAX)
DECLARE @Filmtime INT = 120

-- Start the HTML body
SET @Body = 
    '<html><body>' +
    '<h2>Movie Suggestions</h2>' +
    '<table border="1" cellpadding="5" cellspacing="0" style="border-collapse:collapse;">' +
    '<tr><th>FilmID</th><th>FilmName</th><th>FilmReleaseDate</th><th>LanguageName</th><th>CountryName</th><th>FilmRunTimeMinutes</th><th>FilmOscarNominations</th></tr>'

-- Create a temporary table to store results from the linked server
IF OBJECT_ID('tempdb..#TempResults') IS NOT NULL DROP TABLE #TempResults;
CREATE TABLE #TempResults (
    FilmID INT,
    FilmName NVARCHAR(255),
    FilmReleaseDate DATE,
    LanguageName NVARCHAR(100),
    CountryName NVARCHAR(100),
    FilmRunTimeMinutes INT,
    FilmOscarNominations INT
);

-- Execute the stored procedure on the linked server and insert results into the temp table
INSERT INTO #TempResults
EXEC [Sardors-laptop\SQLSERVER2025].Movies.dbo.DailyFilm @Filmtime;

-- Generate the HTML table rows
DECLARE @TempBody NVARCHAR(MAX) = ''
SELECT @TempBody = @TempBody + 
    '<tr><td>' + CAST(FilmID AS NVARCHAR) + '</td>' +
    '<td>' + FilmName + '</td>' +
    '<td>' + CAST(FilmReleaseDate AS NVARCHAR) + '</td>' +
    '<td>' + LanguageName + '</td>' +
    '<td>' + CountryName + '</td>' +
    '<td>' + CAST(FilmRunTimeMinutes AS NVARCHAR) + '</td>' +
    '<td>' + CAST(FilmOscarNominations AS NVARCHAR) + '</td></tr>'
FROM #TempResults;

-- Append the generated table rows to the body
SET @Body = @Body + @TempBody + '</table></body></html>'

-- Send the email with the HTML body
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Daily Movies',
    @recipients = 'sardorjonumidvich@gmail.com',
    @subject = 'Daily Oscar Nominated Movies',
    @body = @Body,
    @body_format = 'HTML';

-- Drop the temporary table
DROP TABLE #TempResults;
	

-------------------------------------------------------------------------------------------------------------------------------------------------





exec msdb.dbo.sp_send_dbmail
    @profile_name = 'Daily Movies',
    @recipients = 'sardorjonumidvich@gmail.com',
    @subject = 'GAga',
    @query = 'exec Movies.dbo.DailyFilm 150',
    @attach_query_result_as_file = 1,
    @query_attachment_filename = 'Movies.csv',
    @query_result_separator = ',',
    @query_result_width = 1000,
    @query_result_no_padding = 1,
	@body = 'The financial report for the month is attached.',  -- Body
    @body_format = 'HTML'




--------------------------------------------------------------------------------------------------------------------------------------------------

 
CREATE TABLE RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)
GO
 
INSERT INTO RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')
GO
 
SELECT *, (select COUNT(*) from rankingpuzzle as r1 where r1.id <= r.id and r1.vals = 'Product' ) FROM RankingPuzzle r

select r.*, RANK() over (order by r.id) from rankingpuzzle  as r
where r.vals = 'Product'
	SELECT 
		r.*,   COUNT(*) OVER (PARTITION BY r.vals) AS ProductCount,
		RANK() OVER (ORDER BY r.id) AS ProductRank
	FROM 
		RankingPuzzle r
	WHERE 
		r.vals = 'Product';


		SELECT 
    r.*, 
    COUNT(*) OVER (PARTITION BY r.vals) AS ProductCount,
    RANK() OVER (ORDER BY r.id) AS ProductRank
FROM 
    RankingPuzzle r
WHERE 
    r.vals = 'Product';




--------------------------------------------------------------------------------------------------------------------------------------------------


	CREATE TABLE SkuData
(
     SKU BIGINT
    ,ColorId BIGINT 
    ,Price DECIMAL(30,4)
    ,YM INT
)
GO
 
INSERT INTO SkuData VALUES
(1, 1,10,201801),
(1, 1,12,201804),  /* Price changed in 2018 April */
(2, 1,80,201704),  /* Started in the 2017 April */
(3, 1,28,201704),  /* Price changed for this product 4 times*/
(3, 1,20,201804),
(3, 1,19,201806),
(3, 1,27,201808)

 
SELECT * FROM SkuData
GO



--------------------------------------------------------------------------------------------------------------------------------------------------



 
DECLARE @Dt DATE = '2018-08-10' , @Tm Time = '07:48:46.4566667'
select cast(@Dt as datetime) + CAST(@Tm as datetime)



--------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.tbl_sales
(  
    EmpName VARCHAR(256),
    SaleDate DATETIME,
    SaleAmount DECIMAL(18,2),
    IsActive BIT
)
GO
 
INSERT INTO tbl_sales VALUES
('Pawan',GETDATE(),2500.00,1),
('Pawan',GETDATE(),3000.00,1),
('Avtaar',GETDATE(),800.00,1),
('Avtaar',GETDATE(),1000.00,1),
('Kishan',GETDATE(),2800.00,1),
('Kishan',GETDATE(),3000.00,1),
('Nimit',GETDATE(),500.00,1),
('Nimit',GETDATE(),800.00,1),
('K',GETDATE(),1000.00,0),
('L',GETDATE(),1000.00,0),
('M',GETDATE(),500.00,0),
('J',GETDATE(),2500.00,0)
GO
 
SELECT EmpName, sum(SaleAmount), STRING_AGG(EmpName, '-') FROM tbl_sales
group by  IsActive 


select 'InActive' as EmpName ,SUM(SaleAmount) as TotalAmount from tbl_sales
where IsActive = 0
union all
select EmpName, SUM(SaleAmount) as TotalAmount from tbl_sales
where IsActive = 1 
group by EmpName


select case when IsActive = 0 then 'InActive' else EmpName end as EmpNames, SUM(SaleAmount) as TotalSales from tbl_sales
group by (case when IsActive = 0 then 'InActive' else EmpName end )


--------------------------------------------------------------------------------------------------------------------------------------------------



CREATE TABLE FirstTab
(
     ID INT
)
GO
 
INSERT INTO FirstTab VALUES
(1),
(2),
(NULL)
GO
 
SELECT * FROM FirstTab
GO
 
CREATE TABLE SecondTab
(
    ID INT 
)
GO
 
INSERT INTO SecondTab VALUES
(1),
(3),
(NULL)

 
SELECT  * FROM SecondTab as s
left join  FirstTab as f on s.ID = f.ID
SELECT * FROM FirstTab
SELECT * FROM SecondTab 

drop table FirstTab
drop table SecondTab

--------------------------------------------------------------------------------------------------------------------------------------------------



CREATE TABLE FirstTab
(
	 ID INT
	,[Name] VARCHAR(10)
)
GO

INSERT INTO FirstTab VALUES
(5,'Pawan'),
(6,'Sharlee'),
(7,'Krish'),
(NULL,'Avtaar')
GO

SELECT * FROM FirstTab
GO

CREATE TABLE SecondTab
(
	ID INT	
)
GO

INSERT INTO SecondTab VALUES
(5),
(NULL)
GO


SELECT * FROM FirstTab
SELECT * FROM SecondTab

select COUNT(*) from FirstTab as f
where f.ID not in (select id from SecondTab as s where ID is null)


SELECT COUNT(*) 
FROM FirstTab a WHERE a.Id NOT IN ( SELECT Id FROM SecondTab WHERE Id = 5 )
 
 --510
--------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Counta
(
      a1 VARCHAR(1)
    , a2 VARCHAR(1)
    , a3 VARCHAR(1)
)
GO
 
INSERT INTO Counta VALUES
('a','d','a'),
('c','e','f'),
('a','a','s'),
('a','','a'),
('a','a','s')
GO

SELECT *, sum(case when a1 = 'a' then 1 else 0 end) over () +
SUM(case when a2 = 'a' then 1 else 0 end ) over ()+
SUM(case when a3 = 'a' then 1 else 0 end ) over () as CountA
FROM Counta


 --509
--------------------------------------------------------------------------------------------------------------------------------------------------

 
CREATE TABLE RankingPuzzle1
(
     ID INT
    ,Vals VARCHAR(10)
)
GO
 
INSERT INTO RankingPuzzle1 VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')
GO

 
SELECT *, sum(case when Vals = 'Product' then 1 else 0 end) over (order by id) FROM RankingPuzzle1 



 --508
--------------------------------------------------------------------------------------------------------------------------------------------------

create table Familyhirarhy (
id int , Vals varchar(max)	
 )

INSERT INTO Familyhirarhy(ID, vals	)
VALUES 
    (1, '\Pawan'),
    (2, '\Pawan\Kumar'),
    (3, '\Pawan\Kumar\Khowal'),
    (4, '\Pawan\Kumar\Khowal\SQL'),
    (5, '\Pawan\Khowal'),
    (6, '\Sharlee'),
    (7, '\Sharlee\Diwan');



select *, CHARINDEX('\', Vals, 2) from Familyhirarhy


 --506
--------------------------------------------------------------------------------------------------------------------------------------------------
	  
CREATE TABLE T1N1
(
     Id INT
    ,Vals Varchar(10)
)
GO
 
INSERT INTO T1N1 VALUES
(1,'Pawan'),
(2,'Sharlee'),
(3,'Harry')
GO
 
CREATE TABLE T1N2
(
     Id INT
    ,Vals Varchar(10)
)
GO
 
INSERT INTO T1N2 VALUES
(1,'Kumar'),
(2,'Diwan')
GO
 
SELECT  IDs, Names from( select   ISNULL(t1.Id, t2.Id) as IDs, ISNULL(t1.Vals,t2.Vals) as Names,
COUNT(*) OVER (PARTITION BY ISNULL(t2.Id,t1.Id)) sorting
FROM T1N1 t1
full join T1N2  t2 on t1.Id = t2.Id and t1.Vals = t2.Vals) as aa
where sorting > 1


 --505
--------------------------------------------------------------------------------------------------------------------------------------------------

	

