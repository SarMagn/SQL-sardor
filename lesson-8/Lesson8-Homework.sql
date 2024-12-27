Write a query which will find maximum value from multiple columns of the table.
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
)
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91)


select year1,max((MAX(Max1)),( MAX(max2)), (MAX(max3))) from TestMax
group by Year1


SELECT year1 AS Years , max(max1) AS Max_Value  FROM (SELECT Year1, Max1 FROM TestMax
UNION all 
SELECT Year1, Max2 FROM TestMax
UNION all 
SELECT year1, max3 FROM TestMax) rowd
GROUP BY year1 

--=======================================
CREATE TABLE FruitCount
(
    Name VARCHAR(20),
    Fruit VARCHAR(25)
);
--Insert Data
INSERT INTO FruitCount(Name, Fruit) 
VALUES
    ('Neeraj', 'MANGO'),
    ('Neeraj', 'MANGO'),
    ('Neeraj', 'MANGO'),
    ('Neeraj', 'APPLE'),
    ('Neeraj', 'ORANGE'),
    ('Neeraj', 'LICHI'),
    ('Neeraj', 'LICHI'),
    ('Neeraj', 'LICHI'),
    ('Isha', 'MANGO'),
    ('Isha', 'MANGO'),
    ('Isha', 'APPLE'),
    ('Isha', 'ORANGE'),
    ('Isha', 'LICHI'),
    ('Gopal', 'MANGO'),
    ('Gopal', 'MANGO'),
    ('Gopal', 'APPLE'),
    ('Gopal', 'APPLE'),
    ('Gopal', 'APPLE'),
    ('Gopal', 'ORANGE'),
    ('Gopal', 'LICHI'),
    ('Mayank', 'MANGO'),
    ('Mayank', 'MANGO'),
    ('Mayank', 'APPLE'),
    ('Mayank', 'APPLE'),
    ('Mayank', 'ORANGE'),
    ('Mayank', 'LICHI');


select  Name, (
select  COUNT(Fruit) from FruitCount
where fruit = 'Mango'
group by Name) as MangoCount from FruitCount
group by name

select * from FruitCount


select name, COUNT(fruit) from FruitCount
where Fruit='apple'
group by name


select name, COUNT(Fruit) from FruitCount
where Fruit = 'LICHI'
group by Name

select name, COUNT(fruit) from FruitCount
where Fruit = 'Orange'
group by Name


select distinct f.Name, MangoCount, AppleCount, LICHICount, ORANGECount from FruitCount as F
join (select  FruitCount.Name, COUNT(Fruit) as MangoCount from FruitCount
where fruit = 'Mango'
group by Name) as mango on f.Name = mango.name
join ( 
select name, COUNT(fruit) as AppleCount from FruitCount
where Fruit='apple'
group by name  ) as Apple on F.Name = Apple.Name
join (
select name, COUNT(Fruit) as LICHICount from FruitCount
where Fruit = 'LICHI'
group by Name ) as LICHI on F.Name=LICHI.Name 
join ( 
select name, COUNT(fruit) as ORANGECount from FruitCount
where Fruit = 'Orange'
group by Name ) as ORANGE on F.Name = ORANGE.Name
