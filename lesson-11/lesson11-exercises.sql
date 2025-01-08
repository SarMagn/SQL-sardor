use W3Resource	

select * from INFORMATION_SCHEMA.TABLES

select * from Movies.Movie
select * from Movies.Movie_cast



select mm.mov_title, 'John Doel' as Role from Movies.Movie as mm
full  join Movies.Movie_cast as mmc on mm.mov_id = mmc.mov_id
where role is null



select * from HR.Employees
select * from HR.Departments	



select HE.first_name + ' ' +  he.last_name as Full_name, hd.department_name from HR.Employees as HE
left join HR.Departments as HD on HE.department_id = HD.department_id
order by department_name asc




select HE.first_name + ' ' +  he.last_name as Full_name, hd.department_name, isnull(hl.city,'Remote') as Working_City from HR.Employees as HE
left join HR.Departments as HD on HE.department_id = HD.department_id
left join HR.Locations as hl on HD.location_id = hl.location_id

select * from HR.Locations


select * from HR.Employees
select * from HR.Departments

select * from SOCCER.player_mast
select * from SOCCER.soccer_country



select spm.player_name, ssc.country_name ,spm.posi_to_play, spm.playing_club from SOCCER.player_mast as spm
left join SOCCER.soccer_country as ssc on spm.team_id = ssc.country_id 
where ssc.country_name = 'Portugal'



select spm.player_name, ssc.country_name ,spm.posi_to_play, spm.playing_club from SOCCER.player_mast as spm
 join SOCCER.soccer_country as ssc on spm.team_id = ssc.country_id and ssc.country_name = 'Portugal'
 

 -- left ya'ni outer join bilan ishlatilganda and boshqacha ishlaydi
select spm.player_name, ssc.country_name ,spm.posi_to_play, spm.playing_club from SOCCER.player_mast as spm
 left join SOCCER.soccer_country as ssc on spm.team_id = ssc.country_id and ssc.country_name = 'Portugal'



 select * from SOCCER.match_details
 where team_id= 1214
 select * from SOCCER.soccer_country

 select  sc.country_name, sum(md.goal_score)as all_goals from SOCCER.match_details as md
 join SOCCER.soccer_country as sc on md.team_id = sc.country_id --and sc.country_name='France'
 GROUP BY	sc.country_name
 having sum(goal_score) > 5

 

 
 select  sc.country_name, sum(md.goal_score)as all_goals from SOCCER.match_details as md
 join SOCCER.soccer_country as sc on md.team_id = sc.country_id and sc.country_name='France'
 GROUP BY	sc.country_name

 
 select  sc.country_name,md.play_stage, md.win_lose  from SOCCER.match_details as md
 join SOCCER.soccer_country as sc on md.team_id = sc.country_id
 where md.play_stage = 'F' and md.win_lose = 'W'

 
 select  count(win_lose) from SOCCER.match_details as md
 where 

 select team_id , COUNT(win_lose) from SOCCER.match_details
 where win_lose = 'W'
 group by team_id

 select  sc.country_name , count(win_lose)from SOCCER.match_details as md1
 join SOCCER.soccer_country as sc on md1.team_id = sc.country_id
 where md1.play_stage = 'F' and md1.win_lose = 'W'
 group by sc.country_name

 
	 select A.country_name,  COUNT(SMD.win_lose) total_wins from (
	 select  sc.country_name, win_lose, team_id  from SOCCER.match_details as md
	 join SOCCER.soccer_country as sc on md.team_id = sc.country_id
	 where md.play_stage = 'F' and md.win_lose = 'W') as a
	  join SOCCER.match_details as smd on a.team_id = smd.team_id
	  group by country_name


select country_name, COUNT(win_lose) as TotalWins from SOCCER.soccer_country sc4
join SOCCER.match_details md4 on sc4.country_id = md4.team_id
where country_name =		(select country_name from SOCCER.match_details as md3
join SOCCER.soccer_country  sc3 on md3.team_id = sc3.country_id
where win_lose = 'W' and play_stage= 'F') and win_lose = 'W'
group by country_name


/*Puzzle 1 A value of 0 signifies the workflow failed, and a value of 1 signifies the workflow passed.
Write an SQL statement that transforms the following table into the expected output.*/

CREATE TABLE #WorkflowCases
(
Workflow  VARCHAR(100) PRIMARY KEY,
Case1     INTEGER NOT NULL DEFAULT 0,
Case2     INTEGER NOT NULL DEFAULT 0,
Case3     INTEGER NOT NULL DEFAULT 0
);
GO

INSERT INTO #WorkflowCases (Workflow, Case1, Case2, Case3) VALUES
('Alpha',0,0,0),('Bravo',0,1,1),('Charlie',1,0,0),('Delta',0,0,0);
GO


select * from #WorkflowCases

select Workflow, SUM(Case1+Case2+Case3) as SuccessfulCases from #WorkflowCases
group by Workflow

/*Puzzle 2
You are tasked with providing an audit of two shopping carts.
Write an SQL statement to transform the following tables into the expected output*/

CREATE TABLE #Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE #Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO #Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO #Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

select * from #Cart1
select * from #Cart2

select isnull(#Cart1.Item, 'Does not match' ) as FirstItem , isnull(#Cart2.Item, 'Does not match') as SecondItem from #Cart1
full join #Cart2 on #Cart1.Item = #Cart2.Item

/*Puzzle 3
Write an SQL statement given the following requirements.
For every customer that had a delivery to California, provide a result set of the customer orders that
were delivered to Texas*/

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);
GO

INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);
GO


select * from (select distinct CustomerID from #Orders
where DeliveryState = 'CA') as a
join #Orders as o on a.CustomerID = o.CustomerID
where DeliveryState = 'TX'




/*Puzzle 4
Your customer phone directory table allows individuals to set up a home, cellular, or work phone
number.
Write an SQL statement to transform the following table into the expected output
*/

CREATE TABLE #PhoneDirectory
(
CustomerID   INTEGER,
[Type]       VARCHAR(100),
PhoneNumber  VARCHAR(12) NOT NULL,
PRIMARY KEY (CustomerID, [Type])
);
GO

INSERT INTO #PhoneDirectory (CustomerID, [Type], PhoneNumber) VALUES
(1001,'Cellular','555-897-5421'),
(1001,'Work','555-897-6542'),
(1001,'Home','555-698-9874'),
(2002,'Cellular','555-963-6544'),
(2002,'Work','555-812-9856'),
(3003,'Cellular','555-987-6541');
GO

select * from (select CustomerID, Type , PhoneNumber  from #PhoneDirectory) as source_table
pivot (max(phonenumber) for type in([Cellular],[Home],[Work])) as pivottable

 


/*Puzzle 5
You work for a manufacturing company and need to track inventory adjustments from the warehouse.
Some days the inventory increases, on other days the inventory decreases.
Write an SQL statement that will provide a running balance of the inventory
*/


CREATE TABLE #Inventory
(
InventoryDate       DATE PRIMARY KEY,
QuantityAdjustment  INTEGER NOT NULL
);
GO

INSERT INTO #Inventory (InventoryDate, QuantityAdjustment) VALUES
('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150),
('7/4/2018',50),('7/5/2018',-75);
GO


select InventoryDate, QuantityAdjustment    from #Inventory

select  InventoryDate,
    QuantityAdjustment, (
select SUM(QuantityAdjustment) from #Inventory as innertable 
where innertable.InventoryDate <= outertable.inventorydate 
) as RunningTotal
from #inventory as outertable




SELECT 
    InventoryDate,
    QuantityAdjustment,
    (
        SELECT SUM(QuantityAdjustment)
        FROM #Inventory AS inner_table
        WHERE inner_table.InventoryDate <= outer_table.InventoryDate
    ) AS RunningBalance
FROM #Inventory AS outer_table;



select DATEDIFF(DAY,'2002-06-06',GETDATE()) as DaysILived , DATENAME(WEEKDAY,DATEDIFF(DAY,'2002-06-06',GETDATE())) as DayofMyBirth

select DATEDIFF(DAY,'1976-07-31',GETDATE()), DATENAME(WEEKDAY,DATEDIFF(DAY,'1976-07-31',GETDATE()))


select dateadd(MONTH, 1, GETDATE())-DATEDIFF(DAY,,GETDATE())