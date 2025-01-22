select * from INFORMATION_SCHEMA.TABLES


use W3Resource

select * from Inventory.Orders
select * from Inventory.Salesman

--first 

select * from Inventory.Orders
where salesman_id = (select salesman_id from Inventory.Salesman where name = 'Paul Adam')


--second

select * from Inventory.Orders
where salesman_id = (select salesman_id from Inventory.Salesman where city = 'London')

--third

select * from Inventory.Orders
where salesman_id = (select salesman_id from Inventory.Orders where customer_id = '3007')

--fourth

select * from Inventory.Orders
where purch_amt > (select avg(purch_amt) from Inventory.Orders where ord_date = '2012-10-10')

--fifth


select * from Inventory.Orders
where salesman_id = (select salesman_id from Inventory.Salesman where city = 'New york')


--sixth

select commission from Inventory.Salesman
where salesman_id = (select salesman_id from Inventory.Customer where city = 'Paris')

--seventh 

select * from Inventory.Customer
where customer_id = (select salesman_id - 2001 from Inventory.Salesman where name = 'Mc Lyon')


--eighth

select count(customer_id) from Inventory.Customer
where grade > (select avg(grade) from Inventory.Customer )

--ninth

select * from Inventory.Salesman
where commission = (select MAX(commission) from Inventory.Salesman)

--tenth

select * from Inventory.Customer
where customer_id in (select customer_id from Inventory.Orders where ord_date = '2012-08-17')

--eleventh

select * from Inventory.Customer
select * from Inventory.Salesman
where salesman_id in  (select salesman_id from Inventory.Customer  group by salesman_id having COUNT(salesman_id) > 1)


--twelvth

select * from Inventory.Orders
where purch_amt > (select avg(purch_amt) from inventory.Orders)

--therteenth

select * from Inventory.Orders

select * from Inventory.Orders
where purch_amt >= (select avg(purch_amt) from inventory.Orders)

--fourteenth

select * from Inventory.Orders
where 

select ord_date , SUM(purch_amt) as sum from Inventory.Orders
group by ord_date
having SUM(purch_amt) >= 1000

--15

select * from Inventory.Customer
where exists (select * from Inventory.Customer where city = 'London')

--16 

select * from Inventory.Salesman
where salesman_id in (select salesman_id from Inventory.Customer
group by salesman_id
having count(customer_id) > 1
)


--17 


select * from Inventory.Salesman
where salesman_id in (select salesman_id from Inventory.Customer
group by salesman_id
having count(customer_id) = 1
)

--18


select * from Inventory.Salesman
where salesman_id in (
select distinct salesman_id from Inventory.Orders
where customer_id in (select customer_id from Inventory.Orders
group by customer_id
having count(ord_no) > 1
))


select * from Inventory.Customer
select * from Inventory.Salesman
--19

select * from Inventory.Salesman
where city = any (select city from Inventory.Customer )

--20



select * from Inventory.Salesman
where city = any (select city from Inventory.Customer )

--21

select * from Inventory.Salesman as s
where  exists (select * from Inventory.Customer as c where s.name < c.cust_name)

--22
 
select * from Inventory.Customer as c
where grade > any (select grade from Inventory.Customer as cc where cc.city <= 'New York' )


--23

select * from Inventory.Orders
where purch_amt > any (select purch_amt from Inventory.Orders where ord_date = '2012-09-10')

--24

select * from Inventory.Customer
select * from Inventory.Orders as o
where purch_amt < any (select purch_amt from Inventory.Customer as c, Inventory.Orders as oo 
							where oo.customer_id = c.customer_id and c.city = 'London' )

--25

select * from Inventory.Orders
where purch_amt < any (
			select MAX(purch_amt) from Inventory.Customer as c , Inventory.Orders as oo
			where c.customer_id = oo.customer_id and city = 'London'
			)

--26

select * from Inventory.Customer
where grade > all (select grade from Inventory.Customer where city = 'New York')

--27

/*
select oo.salesman_id , SUM(oo.purch_amt) from Inventory.Salesman as s, Inventory.Orders as oo, Inventory.Customer as cc1
where s.salesman_id = oo.salesman_id and oo.salesman_id in (select  c.salesman_id from Inventory.Orders as o , Inventory.Customer as c
			where o.customer_id = c.customer_id 
			group by c.salesman_id) and cc1.salesman_id = s.salesman_id and cc1.city = s.city
group by oo.salesman_id */

select s.name, s.city, Sum from Inventory.Salesman as s, (select salesman_id ,MAX(purch_amt) as Sum from Inventory.Orders group by salesman_id) as sub
where s.salesman_id = sub.salesman_id and s.city in (select  city from Inventory.Customer )


--28


select * from Inventory.Customer
where grade <> all (select grade from Inventory.Customer where city = 'London' and grade is not null)

--29


select * from Inventory.Customer
where grade <> all (select grade from Inventory.Customer where city = 'paris' and grade is not null)


--31

select * 





















