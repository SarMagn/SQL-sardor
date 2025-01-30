--book

use Northwind

select * from INFORMATION_SCHEMA.TABLES
select * from Products

--1

select * from Shippers

--2 

select * from Categories

--3

select FirstName, LastName, HireDate from Employees 
WHERE Title = 'Sales Representative'
--4
select FirstName, LastName, HireDate  from Employees
where Title = 'Sales Representative' and Country = 'USA'

--5 
select * from Orders
where EmployeeID = '5'

--6 
select SupplierID, ContactName, ContactTitle from Suppliers
where ContactTitle <> 'Marketing Manager'

--7

select ProductID, ProductName from Products
where ProductName like '%queso%'

--8 

select OrderID, CustomerID , ShipCountry from Orders
where ShipCountry in ('France','Belgium')

--9 

select OrderID, CustomerID , ShipCountry from Orders
where ShipCountry in ('Mexico','Brazil','Argentina','Venezuela')

--10

select FirstName, LastName, Title , BirthDate from Employees
order by BirthDate asc

--11

select FirstName, LastName, Title , convert(date,BirthDate,102) as [Birth date] from Employees
order by BirthDate asc

--12

select FirstName + ' ' + LastName as [Full Name] from Employees

--13

select OrderID, ProductID, UnitPrice, Quantity, UnitPrice * Quantity as [Total Price] from OrderDetails
order by OrderID, ProductID

--14

select COUNT(customerid) from Customers

--15

select MIN(OrderDate) from Orders

--16

select distinct Country from Customers

--17

select ContactTitle, COUNT(CustomerID) as [count] from Customers
group by ContactTitle
order by count desc

--18

select p.ProductID, p.ProductName , s.CompanyName  from Products as p
join Suppliers as s on p.SupplierID = s.SupplierID

--19

select o.OrderID, CONVERT(DATE,o.OrderDate) AS OrderDate, sh.CompanyName as [Compane name of the shipper] from Orders as o
join Shippers as sh on o.ShipVia = sh.ShipperID and o.OrderID < 10300
order by o.OrderID

--20

select CategoryID, COUNT(ProductID) as [count] from Products
group by CategoryID
order by count desc

--21

select Country, City, COUNT(CustomerID) as [Count of customers]	 from Customers
group by Country , City
order by [Count of customers] desc

--22

select ProductID, ProductName , UnitsInStock , ReorderLevel from Products	
where ReorderLevel > UnitsInStock

--23

select ProductID, ProductName , UnitsInStock , UnitsOnOrder,  ReorderLevel, Discontinued from Products
where UnitsInStock + UnitsOnOrder <= ReorderLevel and Discontinued = 0

--24

select Region, CustomerID from  Customers
group by Region, CustomerID
order by case when Region is null then 1 else 0 end 

--25

select  top 3 ShipCountry , avg(Freight) as [avg freight] from Orders
group by ShipCountry
order by avg(Freight) desc

--26

select  top 3 ShipCountry , avg(Freight) as [avg freight] from Orders
where year(OrderDate) = 2015
group by ShipCountry
order by avg(Freight) desc

--27

select  top 3 ShipCountry , avg(Freight) as [avg freight] from Orders
where OrderDate between '1/1/2025' and '12/13/2015'
group by ShipCountry
order by avg(Freight) desc

select * from Orders
order by OrderDate

--28

select  top 3 ShipCountry , avg(Freight) as [avg freight] from Orders
where OrderDate > dateadd(month,-12,(select MAX(orderdate) from Orders)) 
group by ShipCountry
order by avg(Freight) desc

--29

select * from Orders
select e.EmployeeID, e.LastName, o.OrderID, p.ProductName, od.Quantity from Employees as e 
join Orders as o on e.EmployeeID = o.EmployeeID
join OrderDetails as od on od.OrderID = o.OrderID
join Products as p on p.ProductID = od.ProductID

select * from OrderDetails
select * from Orders
select * from Products

--30

select c.CustomerID , o.CustomerID from Customers as c
left join Orders as o on c.CustomerID = o.CustomerID 
where o.CustomerID is null

--31

select a.EmployeeID,c.CustomerID from (select * from Orders where EmployeeID = 4) as a 
right join Customers as c on a.CustomerID = c.CustomerID
where EmployeeID is null

--32

/*select * from (select a.CustomerID , c.CompanyName, a.OrderID, od.UnitPrice * od.Quantity as [TotalPrice] from (select * from Orders
where YEAR(OrderDate) = 2016) as a 
join Customers as c on a.CustomerID = c.CustomerID
join OrderDetails as od on od.OrderID = a.OrderID) as abc
where TotalPrice >= 10000*/

select a.CustomerID , c.CompanyName, a.OrderID, sum(od.UnitPrice * od.Quantity) as [TotalPrice] from (select * from Orders
where YEAR(OrderDate) = 2016) as a 
join Customers as c on a.CustomerID = c.CustomerID
join OrderDetails as od on od.OrderID = a.OrderID
group by a.CustomerID, c.CompanyName, a.OrderID 
having SUM(od.UnitPrice * od.Quantity) >= 10000


--33

select CustomerID, SUM([Total Price]) as Totaller from (select OrderID ,SUM(UnitPrice * Quantity) as [Total Price] from OrderDetails group by OrderID) as a, (
select CustomerID, OrderID from Orders where year(OrderDate) = 2016  group by CustomerID, OrderID) as b
where a.OrderID = b.OrderID 
group by CustomerID
having SUM([Total Price]) >= 15000

--34

select *, (UnitPrice * Quantity * (1-Discount)) as [TotalPriceWithDiscount] from OrderDetails

select CustomerID, SUM([Total Price]) as [TotallerWithoutDisc], sum([TotalPriceWithDiscount]) from (select OrderID ,SUM(UnitPrice * Quantity) as [Total Price],sum(UnitPrice * Quantity * (1-Discount)) as [TotalPriceWithDiscount] from OrderDetails group by OrderID) as a, (
select CustomerID, OrderID from Orders where year(OrderDate) = 2016  group by CustomerID, OrderID) as b
where a.OrderID = b.OrderID 
group by CustomerID
having SUM([Total Price]) >= 10000 and SUM(TotalPriceWithDiscount) >=10000

--35

select EmployeeID, OrderID, OrderDate from Orders
where OrderDate  = eomonth(OrderDate)

--36

select top 10 OrderID, COUNT(ProductID) as totalline from OrderDetails
group by OrderID
order by totalline desc

--37

select top 2 percent OrderID from (select OrderID,  RAND(OrderID) as s from Orders) as a

--38

select OrderID ,Quantity from OrderDetails
where Quantity >= 60 
group by OrderID,Quantity
having COUNT(*) > 1

--39

select * from OrderDetails
where OrderID in (select OrderID from OrderDetails
where Quantity >= 60
group by OrderID , Quantity
having COUNT(*) > 1)

--40

select o.OrderID,o.ProductID,o.UnitPrice,o.Quantity, o.Discount from OrderDetails as o
join(select distinct OrderID from OrderDetails
where Quantity >= 60
group by OrderID , Quantity
having COUNT(*) > 1) as od on o.OrderID = od.OrderID
order by o.OrderID, o.ProductID

--41

select OrderID, convert(date,OrderDate) as [Order Date], convert(date, RequiredDate) as [Required Date] , convert(DATE,ShippedDate) as [Shipped date] from Orders
where ShippedDate >= RequiredDate

--42

select OrderID from Orders
where ShippedDate >= RequiredDate

select LastName, count(o.OrderID) as [Count]  from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
join Employees as e on e.EmployeeID = o.EmployeeID
group by LastName

--43


select LastName, count(o.OrderID) as [LateOrders], alls.allcount as [All orders]  from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
join Employees as e on e.EmployeeID = o.EmployeeID
join (select EmployeeID, count(OrderID) as allcount from Orders
group by EmployeeID) as alls on alls.EmployeeID = o.EmployeeID
group by LastName, alls.allcount


--44



select LastName, count(o.OrderID) as [LateOrders], alls.allcount as [All orders]  from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
right join Employees as e on e.EmployeeID = o.EmployeeID
left join (select EmployeeID, count(OrderID) as allcount from Orders
group by EmployeeID) as alls on alls.EmployeeID = o.EmployeeID
group by LastName, alls.allcount

--45



select LastName, count(o.OrderID) as [LateOrders], isnull(alls.allcount,0) as [All orders]  from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
right join Employees as e on e.EmployeeID = o.EmployeeID
left join (select EmployeeID, count(OrderID) as allcount from Orders
group by EmployeeID) as alls on alls.EmployeeID = o.EmployeeID
group by LastName, alls.allcount

--46


select LastName, count(o.OrderID) as [LateOrders], isnull(alls.allcount,0) as [All orders], 
isnull(cast(count(o.OrderID) as float)/alls.allcount,0)   as PercentLateOrders
from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
right join Employees as e on e.EmployeeID = o.EmployeeID
left join (select EmployeeID, count(OrderID) as allcount from Orders
group by EmployeeID) as alls on alls.EmployeeID = o.EmployeeID
group by LastName, alls.allcount


--47


select LastName, count(o.OrderID) as [LateOrders], isnull(alls.allcount,0) as [All orders], 
cast(isnull(cast(count(o.OrderID) as float)/alls.allcount,0) as decimal(4,2))
from Orders as o
join (select OrderID from Orders
where ShippedDate >= RequiredDate) as a on o.OrderID = a.OrderID
right join Employees as e on e.EmployeeID = o.EmployeeID
left join (select EmployeeID, count(OrderID) as allcount from Orders
group by EmployeeID) as alls on alls.EmployeeID = o.EmployeeID
group by LastName, alls.allcount

--48   , 49 


with ordercte as (
select OrderID , CustomerID from Orders
where year(OrderDate) = 2016), 
detailsCTE as(
select OrderID, sum(UnitPrice* Quantity) as TotalSales from OrderDetails
group by OrderID),
customersCTE as( select customerid, Companyname from Customers )
select  o.customerid,c.Companyname,  sum(d.totalsales) as TotalSales,
			case when sum(d.totalsales) between 0 and 1000 then 'Low'
			when sum(d.totalsales) between 1000 and 5000 then 'Medium'
			when sum(d.totalsales) between 5000 and 10000 then 'High'
			when sum(d.totalsales) > 10000 then 'Very high'
			end  as CustomerGroup
			from ordercte as o
join detailscte as d on o.orderid = d.orderid
join customersCTE as c on o.customerid = C.customerid
group by o.customerid, c.companyname



--50


with ordercte as (
select OrderID , CustomerID from Orders
where year(OrderDate) = 2016), 
detailsCTE as(
select OrderID, sum(UnitPrice* Quantity) as TotalSales from OrderDetails
group by OrderID),
customersCTE as( select customerid, Companyname from Customers ),
allcustomergroup as(
select  o.customerid as CustomerIDs,c.Companyname,  sum(d.totalsales) as TotalSales,
			case when sum(d.totalsales) between 0 and 1000 then 'Low'
			when sum(d.totalsales) between 1000 and 5000 then 'Medium'
			when sum(d.totalsales) between 5000 and 10000 then 'High'
			when sum(d.totalsales) > 10000 then 'Very high'
			end  as CustomerGroup
			from ordercte as o
join detailscte as d on o.orderid = d.orderid
join customersCTE as c on o.customerid = C.customerid
group by o.customerid, c.companyname),
percentageCTE as (
select customerGroup, COUNT(CustomerIDs) as TotalinGroup
from allcustomergroup
group by customerGroup 
), 
lastCTE as (
select *, cast(TotalinGroup as float) / cast(SUM(TotalinGroup) over() as float)  as Percantage
from percentageCTE)
select * from lastcte 


--51

with Orders2016 as (
Select Customers.CustomerID as CustomerID
,Customers.CompanyName as CompanyName ,TotalOrderAmount = SUM(Quantity *
UnitPrice) From Customers join Orders on Orders.CustomerID =
Customers.CustomerID
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
Where year(OrderDate) = 2016
Group By Customers.CustomerID
,Customers.CompanyName),
thereCTE as (
select Orders2016.CustomerId, Orders2016.CompanyName, Orders2016.TotalOrderAmount , c.CustomerGroupName from Orders2016 
join CustomerGroupThresholds as c on Orders2016.TotalOrderAmount >= c.RangeBottom and Orders2016.TotalOrderAmount <= c.RangeTop
)
select * from thereCTE

--52

with countryCTE as(
select distinct Country from Customers
union  
select distinct Country from Suppliers
)
select * from countryCTE

--53 

select distinct s.Country as [Supplier Country], c.Country as [Customer Country]  from Customers as c
full join Suppliers as s on c.Country = s.Country

--54


with countryCTE as(
select distinct Country from Customers
union  
select distinct Country from Suppliers
), 
ToatalcCTE as (
select country, COUNT(CustomerID) as [Total Customers] from Customers
group by Country
),
ToatalsCTE as (
select country, COUNT(SupplierID) as [Total Suppliers] from Suppliers
group by Country
)
select cc.Country, ISNULL([Total Customers],0) as [Total Customers] , ISNULL([Total Suppliers], 0) as [Total Suppliers] from countryCTE as cc
full join ToatalcCTE as tc on tc.Country = cc.Country
full join ToatalsCTE as ts on ts.Country = cc.Country

--55


select ShipCountry , CustomerID, OrderID  , convert(date,OrderDate) as OrderDate  from Orders
where OrderDate in (
select  min(OrderDate) as OrderDate from Orders
group by ShipCountry )

--56


with allCTe as(
select Init.CustomerID as CustomerId, Init.OrderID as [Initial OrderId] ,Init.OrderDate as [Initial OrderDate],
next.OrderID as [Next OrderID], next.OrderDate as [Next Orderdate], DATEDIFF(DAY, Init.OrderDate, next.OrderDate) as DaysBetween
from Orders as Init
join Orders as next on Init.CustomerID = next.CustomerID
where Init.Orderid < next.Orderid 
 )
select * from allCTe
where DaysBetween <= 5 



-57

with ResultCTE as(
select CustomerID, OrderDate, LEAD(OrderDate,1) over (partition by customerid order by orderdate) as [Next order],
 datediff(day,OrderDate,LEAD(OrderDate,1) over (partition by customerid order by orderdate)) as [Days between]
from Orders)
select * from ResultCTE
where [Days between] <= 5







