CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    referee_id INT NULL
);

INSERT INTO users (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);


select * from users
where referee_id <> 2 or referee_id is null


CREATE TABLE Weather (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);

INSERT INTO Weather (id, recordDate, temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);




select w.id from Weather as w
full join (select * , DATEADD(DAY,1,recorddate) as yy from Weather) as w1
on w.recordDate = w1.yy 
where w.temperature > w1.temperature 

CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type VARCHAR(10),
    timestamp FLOAT
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);

select  distinct machine_id ,AVG( timestamp - res) over (partition by machine_id) as processing_time from (select *, LAG(timestamp) 
over (partition by machine_id order by process_id) as res from Activity) as a
where activity_type = 'end'

select * from activity


	SELECT a1.machine_id, AVG(a2.timestamp-a1.timestamp) as  processing_time
	FROM Activity a1
	JOIN Activity a2 
	ON a1.machine_id = a2.machine_id 
	AND a1.process_id = a2.process_id 
	AND a1.activity_type = 'start' 
	AND a2.activity_type = 'end'
	GROUP BY a1.machine_id;


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');

CREATE TABLE Subjects (
    subject_name VARCHAR(50) PRIMARY KEY
);

INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Physics'),
('Programming');

CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);

INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math');

select * from Subjects
select * from Students

select e.*,s.student_name, COUNT(*) from Examinations e
join Students s on e.student_id = s.student_id
group by e.student_id, e.subject_name, s.student_name
order by e.student_id



	select e.student_id ,e.student_name,ss.subject_name ,COUNT(ee.student_id)  from Students e
	cross join Subjects ss
	left join Examinations ee on ee.student_id = e.student_id and ss.subject_name = ee.subject_name
	group by e.student_id, ss.subject_name, e.student_name


order by e.student_id

select * from Examinations


CREATE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp DATETIME
);

INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

CREATE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES Signups(user_id)
);

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');


select * from Signups
select * from Confirmations

select s.user_id , coalesce(sum(case when c.action= 'Confirmed' then 1 else 0 end)/ COUNT(c.action),0)  from Confirmations as c
right join Signups as s on c.user_id = s.user_id
group by s.user_id

select s.user_id, case when count(c.action) = 0  then 0 else 
cast(cast(SUM(case when action = 'confirmed' then 1 else 0 end) as decimal(5,2))/ COUNT(c.action) as decimal(5,2))
end  as confirmation_rate  from Signups as s
left join Confirmations as c on s.user_id = c.user_id
group by s.user_id

select * from Signups s


SELECT s.user_id, case when count(c.action) = 0  then 0 else
       COALESCE(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(c.action), 0) end AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c ON s.user_id = c.user_id
GROUP BY s.user_id;






SELECT s.user_id, 
       CASE 
           WHEN COUNT(c.action) = 0 THEN 0 
           ELSE SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(c.action) 
       END AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c ON s.user_id = c.user_id
GROUP BY s.user_id;




select @@Servername


-- Prices jadvalini yaratish
CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT
);

-- UnitsSold jadvalini yaratish
CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);
-- Prices jadvaliga ma'lumot qo'shish
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);

-- UnitsSold jadvaliga ma'lumot qo'shish
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);


select * from Prices




select 
u.product_id, case when sum(units) is null then 0 else  
cast(SUM(units*price)/cast(sum(units) as decimal(5,2)) as decimal(5,2)) end  as average_price  from UnitsSold as u
left join Prices as p on u.product_id = p.product_id and purchase_date between  start_date and end_date
group by u.product_id


create database TestBase

use TestBase

if exists (select * from INFORMATION_SCHEMA.TABLES
where TABLE_NAME = 'Nomlar')
begin 
	drop table Nomlar
end 


select * from world_bank_dataset

create table Nomlar (id int , name varchar(max))


select  * from Nomlar


use Movies


select * from tblActor
s
drop table Employees

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(50)
);


INSERT INTO Employees (EmployeeID, Name, Position) VALUES 
(101, 'Alice', 'Manager'),
(102, 'Bob', 'Engineer'),
(104, 'Charlie', 'Analyst'),
(105, 'David', 'Engineer'),
(107, 'Emily', 'HR');


select * from Employees



WITH NumberedEmployees AS (
    SELECT EmployeeID, 
           LAG(EmployeeID) OVER (ORDER BY EmployeeID) AS PrevID,
           LEAD(EmployeeID) OVER (ORDER BY EmployeeID) AS NextID
    FROM Employees
)
SELECT PrevID + 1 AS MissingID, *
FROM NumberedEmployees
WHERE PrevID + 1 <> EmployeeID;




select * from Employees
--declare @minID int 
--declare @maxId int 

CREATE TABLE NumbersTable (
    Number INT
);
declare @minID int 
declare @maxId int 
set @minID = (select MIN(EmployeeID) from Employees)
set @maxId = (select max(EmployeeID) from Employees)


WHILE @minID <= @maxId  -- Change 10 to the desired upper limit
BEGIN
    INSERT INTO NumbersTable (Number) VALUES (@minID);
    SET @minID = @minID + 1;  -- Increment counter
END;





select n.Number from NumbersTable n
left join Employees as e on e.EmployeeID = n.Number
where n.Number not in (select EmployeeID from Employees)

with number as (
    select min(EmployeeID) as b
    from Employees
    union all
    select b + 1 
    from number
    where b + 1 <= (select max(EmployeeID) from  Employees )
)
select b from number
where b NOT IN (select EmployeeID from Employees)



