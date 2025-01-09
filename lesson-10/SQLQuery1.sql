select @@SERVERNAME as ServerName

use W3Resource

select * from INFORMATION_SCHEMA.TABLES

--First

select SUM(purch_amt) from Inventory.Orders

--Second


select avg(purch_amt) from Inventory.Orders


--Third





select  COUNT(distinct salesman_id) from Inventory.Orders


--Fourth

select  COUNT(customer_id) from Inventory.Customer

--fifth

select COUNT(customer_id) from Inventory.Customer
where grade is not null

--sixth

select  max(purch_amt) from Inventory.Orders


--Seventh

select  min	(purch_amt) from Inventory.Orders


--Eighth

select city, max(grade) from Inventory.Customer
group by city 

--Ninth

select  customer_id, MAX(purch_amt) from Inventory.Orders
group by customer_id

--Tenth

select  customer_id, ord_date, MAX(purch_amt) as max from Inventory.Orders
GROUP BY ord_date, customer_id

--Eleventh

select  salesman_id, MAX(purch_amt) from Inventory.Orders
where ord_date = '2012-08-17'
group by salesman_id

--Twelfth

select customer_id, ord_date, MAX(purch_amt) from Inventory.Orders
group by ord_date, customer_id
having MAX(purch_amt) > 2000

--Thirteenth

select customer_id, ord_date, MAX(purch_amt) as max from Inventory.Orders
group by customer_id, ord_date
having MAX(purch_amt) between 2000 and 6000

--Fourteenth

select customer_id, ord_date, MAX(purch_amt) from Inventory.Orders
group by customer_id, ord_date
having MAX(purch_amt) in (2000,3000,5760,6000)

--Fifteenth

select customer_id ,MAX(purch_amt) as MAx from Inventory.Orders
where customer_id between 3002 and 3007
group by customer_id

--Sixteenth


select customer_id ,MAX(purch_amt) as MAx from Inventory.Orders
where customer_id between 3002 and 3007
group by customer_id
having MAX(purch_amt) > 1000

--Seventeenth

select salesman_id ,MAX(purch_amt) as MAx from Inventory.Orders
where salesman_id between 5003 and 5008
group by salesman_id

--Eighteenth

select COUNT(ord_no) from Inventory.Orders
where ord_date = '2012-08-17'

--Nineteenth

select COUNT(salesman_id) from Inventory.Salesman

--Twentieth

select ord_date, salesman_id, COUNT(ord_no) as count from Inventory.Orders
group by ord_date, salesman_id

--Twenty-first

select AVG(pro_price) from item_mast

--Twenty-second

select COUNT(pro_id) as 'Number of Products' from item_mast
where pro_price > 350

--Twenty-third

select pro_com as 'Company ID' ,AVG(pro_price) as 'Average Price' from item_mast
group by pro_com

--Twenty-fourth

select sum(dpt_allotment) as SUM from dbo.emp_department


--Twenty-fifth

select emp_dept, COUNT(emp_idno) as Count from dbo.emp_details
group by emp_dept