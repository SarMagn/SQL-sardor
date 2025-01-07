use W3Resource

select * from INFORMATION_SCHEMA.TABLES
order by TABLE_NAME

-- FIrst

select * from Inventory.Customer
order by salesman_id

select iss.name, cust_name, ic.city from Inventory.Customer as ic
join Inventory.Salesman as iss on ic.salesman_id = iss.salesman_id
select * from Inventory.Salesman

--Second

select IO.ord_no, purch_amt, cust_name from Inventory.Customer as ic
join  (select * from Inventory.Orders
where purch_amt between 500 and 2000) as IO on ic.customer_id = IO.customer_id

select * from Inventory.Customer
select * from Inventory.Orders

--Third


select cust_name, IC.city, name, commission from Inventory.Customer as IC
join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id


select * from Inventory.Salesman

--Fourth

select * from Inventory.Customer
select * from Inventory.Salesman


select cust_name, IC.city, name, commission  from Inventory.Customer as IC
join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id
where ISS.commission > 0.12

--Fifth


select * from Inventory.Customer
select * from Inventory.Salesman

select cust_name, IC.city, name, commission  from Inventory.Customer as IC
join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id
where ISS.commission > 0.12 and IC.city <> ISS.city

--Sixth


select ord_no, ord_date, purch_amt, cust_name, grade, iss.salesman_id, commission from Inventory.Orders as IC
join Inventory.Customer as IO on IC.customer_id = IO.customer_id
join inventory.salesman as ISS on iss.salesman_id = IO.salesman_id

select * from Inventory.Orders
select * from Inventory.Customer
select * from Inventory.Salesman

--Seventh

select ISS.*, IC.customer_id, cust_name, grade,  ord_no, ord_date, purch_amt from Inventory.Salesman as ISS
join Inventory.Customer as IC on ISS.salesman_id = IC.salesman_id
join Inventory.Orders as IO on IC.salesman_id = IO.salesman_id

--Eighth

select cust_name, IC.city, grade, ISS.name, ISS.city from Inventory.Customer as IC
join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id 
order by ic.customer_id

--Ninth

select cust_name, IC.city, grade, ISS.name, ISS.city from Inventory.Customer as IC
join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id
where grade < 300

--Tenth

select cust_name,IC.city, ord_no, ord_date, purch_amt from Inventory.Customer as Ic 
left outer join Inventory.orders as Io on IO.salesman_id = IC.salesman_id
order by ord_date


--Eleventh

select cust_name, iss.city, ord_no, ord_date, purch_amt as orderAmount , ISS.name, commission  from Inventory.Customer as IC 
left join Inventory.Orders as IO on IC.salesman_id = IO.salesman_id
left join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id

 
--Twelfth

select * from Inventory.Customer

select IC.salesman_id, name, Iss.city from Inventory.Salesman as ISS
join Inventory.Customer as IC on ISS.salesman_id = IC.salesman_id
order by ic.salesman_id

--Thirteenth

select name as 'Salesman' , cust_name  , IC.city, grade, ord_no, ord_date, purch_amt from Inventory.Customer as IC 
right join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id
right join Inventory.Orders as IO on Io.customer_id = Ic.customer_id
order by Salesman

--Fourteenth

select distinct IC.*, ISS.* ,  io.ord_no, IO.purch_amt from Inventory.Customer as IC
right join Inventory.Salesman as ISS on IC.salesman_id = ISS.salesman_id
left join Inventory.Orders as IO on io.customer_id = ic.customer_id
where purch_amt > 2000 and grade is not null


--Fifteenth

select a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt from Inventory.Customer as a
right join Inventory.Orders as b on a.customer_id = b.customer_id


--Sixteenth

select cus.cust_name, cus.city, ord_no, ord_date, purch_amt from Inventory.Customer as cus
full join Inventory.Orders as ord on cus.customer_id = ord.customer_id
where grade is not null

--Seventeenth

select * from Inventory.Salesman
cross join inventory.customer

--Eighteenth

select * from Inventory.Salesman
cross join Inventory.Customer 
where Inventory.Salesman.city is not null


--Nineteenth


select * from Inventory.Salesman
cross join Inventory.Customer as c
where Inventory.Salesman.city is not null and  c.grade is not null

--Twentieth


select * from Inventory.Salesman as s
cross join Inventory.Customer as c
where s.city is not null and  c.grade is not null and s.city <> c.city

--Twenty-first

select * from dbo.item_mast as im
join company_mast1 as cm on im.pro_com = cm.com_id

create table company_mast1(com_id int, com_name varchar(30) )
insert into company_mast1 values (11, 'Samsung'), (12, 'iBall'), (13,'Epison'), (14, 'Zebronics'), (15, 'Asus'), (16, 'Frontech')


--Twenty-second

select * from dbo.item_mast

select pro_name as ItemName,  pro_price as Price, com_name from item_mast as im
join company_mast1 as cm on im.pro_com = cm.com_id

--Twenty-third


select com_name, AVG(pro_price) as 'Average_price' from (
select cm.com_name, pro_price from dbo.item_mast as im
join company_mast1 as cm on im.pro_com = cm.com_id) as a
group by com_name

--Twenty-fourth

select com_name, AVG(pro_price) from item_mast as im
join company_mast1 as cm on im.pro_com = cm.com_id
group by com_name
having avg(pro_price)>=350

--Twenty-fifth

select com_name, MAX(pro_price) from item_mast as im
join company_mast1 as cm on im.pro_com = cm.com_id
group by com_name



--Twenty-sixth

select * from INFORMATION_SCHEMA.TABLES
order by TABLE_NAME

select * from dbo.emp_details

create table emp_department (dpt_code int, dpt_name varchar(30), dpt_allotment int)
insert into emp_department values (57,'IT', 65000), (63,'Finance', 15000 ), (47, 'HR', 240000), (27, 'RD', 55000), (89, 'QC', 75000)

select * from emp_details as ed
join emp_department as ede on ed.emp_dept = ede.dpt_code

--Twenty-seventh

select emp_fname as FirstName ,  emp_lname as LastName , dpt_name as Department , dpt_allotment as AmountAlloted from emp_details as ed
join emp_department as ede on ed.emp_dept = ede.dpt_code

--Twenty-eighth


select emp_fname as FirstName, emp_lname as LastName from emp_details as ed
join emp_department as ede on ed.emp_dept = ede.dpt_code
where dpt_allotment > 50000


--Twenty-ninth


select dpt_name from emp_details as ed
join emp_department as ede on ed.emp_dept = ede.dpt_code
group by dpt_name
having COUNT(dpt_name)> 2






