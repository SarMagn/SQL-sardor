create database Lesson13

use lesson13


select CURRENT_TIMESTAMP

select dateadd(day, 12 , '2002-06-06') 

select dateadd(MONTH, 2 , '2002-06-06')

select DATEADD(SECOND, 300, '2002-06-06')

select DATEADD(MINUTE, 3 , '2002-06-06')

select DATEADD(QUARTER, 1 , '2002-06-06')

select DATEDIFF(MONTH, '2022-08-01', '2024-04-24')
select DATEDIFF(MONTH, '2024-08-01', '2024-04-24')

select DATEFROMPARTS(2028, 5, 23)

select DATENAME(month, '2024-11-25')
select DATENAME(YEAR, '2024-11-25')
select DATENAME(yy, '2024-11-25')
select DATENAME(mm, '2024-11-25')   -- month
select DATENAME(m, '2024-11-25')    -- month
select DATENAME(DAYOFYEAR, '2024-11-25') --day of the year

select DATENAME(WEEKDAY, '2024-11-25')   -- weekday


select datepart(YEAR, '2024-11-25')
select datepart(WEEKDAY, '2024-11-25')
select datepart(TZOFFSET, '2024-11-25')
select datepart(ISO_WEEK, '2024-11-25')

select day('2024-11-25')

select day('2022-06-28')


select GETDATE()

select GETUTCDATE() as w

select ISDATE('salom')

select ISDATE('2024')


select month('2022-06-28')
select year('2022-06-28')
select day('2022-06-28')

select SYSDATETIME()

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE
);

INSERT INTO Orders (OrderID, OrderDate)
VALUES 
(1, '2025-01-01'),
(2, '2024-12-15'),
(3, '2024-07-04');

select OrderID, DAY(OrderDate) as DayOfOrder, MONTH(OrderDate) as  MonthOfOrder, YEAR(OrderDate) as YearOfOrder  from Orders

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name NVARCHAR(50),
    BirthDate DATE
);

INSERT INTO Users (UserID, Name, BirthDate)
VALUES 
(1, 'Alice', '1990-05-10'),
(2, 'Bob', '1985-09-20'),
(3, 'Charlie', '2000-01-15');

select Name, DATEDIFF(YEAR, BirthDate , GETDATE()) as AgeofUser from Users
select * from Users

CREATE TABLE #Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE
);

INSERT INTO #Orders (OrderID, OrderDate)
VALUES 
(1, GETDATE() - 2),
(2, GETDATE() - 8),
(3, GETDATE() - 5);


select * from #Orders
where DATEDIFF(DAY , OrderDate, GETDATE()) < 7
select * from #Orders

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    AttendanceDate DATE
);

INSERT INTO Attendance (AttendanceID, AttendanceDate)
VALUES 
(1, '2025-01-13'),
(2, '2025-01-10'),
(3, '2025-01-09');


select *, DATENAME(WEEKDAY, AttendanceDate) as WeekDay from Attendance

CREATE TABLE Events (
    EventID INT PRIMARY KEY,
    EventDate DATE
);

INSERT INTO Events (EventID, EventDate)
VALUES 
(1, '2025-02-15'),
(2, '2025-03-01'),
(3, '2025-03-10');

select *, DATEADD(DAY, 30 , EventDate) as [After 30 days], DATEADD(DAY, -15, EventDate ) as [Before 15 days] from Events

CREATE TABLE Years (
    Year INT PRIMARY KEY
);

INSERT INTO Years (Year)
VALUES 
(2020),
(2021),
(2024),
(2025);

select * from Years
where Year % 4 = 0 or YEAR % 400 = 0 and Year % 100 <> 0


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE
);

INSERT INTO Transactions (TransactionID, TransactionDate)
VALUES 
(1, '2025-01-15'),
(2, '2025-05-21'),
(3, '2025-09-10');

select *, DATEPART(QUARTER, TransactionDate) as Quarter, DATEPART(WEEK, TransactionDate) as Week  from Transactions

CREATE TABLE Logs (
    LogID INT PRIMARY KEY,
    StartTime DATETIME,
    EndTime DATETIME
);

INSERT INTO Logs (LogID, StartTime, EndTime)
VALUES 
(1, '2025-01-15 08:00:00', '2025-01-15 12:30:00'),
(2, '2025-01-15 14:00:00', '2025-01-15 17:45:00'),
(3, '2025-01-15 09:15:00', '2025-01-15 13:00:00');

select *, datediff(HOUR, StartTime , EndTime) as DifferenceinHours from Logs


CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    BookingDate DATE
);

INSERT INTO Bookings (BookingID, BookingDate)
VALUES 
(1, '2024-03-15'),
(2, '2024-07-20'),
(3, '2024-12-01');


select * from Bookings
where	BookingDate between '2024-01-01' and '2024-12-31'

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SaleDate DATE
);

INSERT INTO Sales (SaleID, SaleDate)
VALUES 
(1, '2025-01-01'),
(2, '2025-02-14'),
(3, '2025-03-25');

select *, format(SaleDate, 'dd-MM-yyyy') as [DD-MM-YYYY],
		FORMAT(SaleDAte, 'Month dd,yyyy') as [MONTH DD,YYYY],
		FORMAT(SaleDate, 'yyyy/MM/dd') as [YYYY/MM/DD] from Sales


select ASCII('a') as da

select CHAR(97)

select CHARINDEX('t', 'Customer')

select CONCAT('Sardor','Ismatov','Age','22')

select CONCAT_WS('-','Sardor','Ismatov','Age','22')

select SOUNDEX('Sardor'), SOUNDEX('Sarvar')

select DIFFERENCE('Sardor', 'Sarvar')

select FORMAT(3241332, '###-##-##')

select LEFT('SardorIsmatovAge22', 6)
declare @sardor as varchar
select @sardor 



select lower('SaRdOr')



select upper('SaRdOr')

select TRIM('###' from '        # Sar#dor#      ')
select TRIM(
Sardor

SELECT PATINDEX('%lll%', 'W3Schools.com')

SELECT QUOTENAME('abcdef')

SELECT QUOTENAME('abcdef', '()')

select REPLACE('Sardor Ismatov', 'a' , 'i')

select REPLACE('Abc Abc Abc','ab', 'df')


select REPLICATE('Sardor', 4)

select REVERSE(REPLICATE('Sardor', 4))

SardorSardorSardorSardor

select REVERSE('SardorSardorSardorSardor')

select SPACE(10)
          
select STUFF('IsmatovSardorUmidjonO''gli', 8,6,'Samir')


select substring('IsmatovSardorUmidjonO''gli', 8, 6)




