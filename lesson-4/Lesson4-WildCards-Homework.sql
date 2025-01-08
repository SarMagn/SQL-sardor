use W3Resource

select * from INFORMATION_SCHEMA.TABLEs
order by TABLE_NAME

--first


select * from Inventory.Salesman
where city in ('Paris','Rome')


--second


select * from Inventory.Salesman
where city in ('Paris','Rome')


--third


select * from Inventory.Salesman
where city not in ('Paris','Rome')

--fourth

select * from Inventory.Customer
where customer_id in (3007,3008,3009)

--fifth

select * from Inventory.Salesman
where commission between 0.12 and 0.14

--sixth

select * from Inventory.Orders
where (purch_amt between 500 and 4000) and purch_amt not between 948.50 and 1943.43


--seventh

select * from Inventory.Salesman
--where name like '[A,L]%'
where name between 'A' and 'L'


--eighth


select * from Inventory.Salesman
where name not between 'A' and 'M'

--ninth

select * from Inventory.Customer
where cust_name like 'B%'

--tenth

select * from Inventory.Customer
where cust_name like '%N'


--eleventh

select * from Inventory.Salesman
where name like 'N__l%'

--twelfth



select * from testtable
where column1 like '%/_%' escape '/'
order by column1


--thirteenth



select * from testtable
where column1 not like '%_%'






create table testtable(column1 varchar(100))

insert into testtable values	('A001/DJ-402\44_/100/2015'),('A001_\DJ-402\44_/100/2015'),
('A001_DJ-402-2014-2015'),
('A002_DJ-401-2014-2015'),
('A001/DJ_401'),
('A001/DJ_402\44'),
('A001/DJ_402\44\2015'),
('A001/DJ-402%45\2015/200'),
('A001/DJ_402\45\2015%100'),
('A001/DJ_402%45\2015/300'),
('A001/DJ-402\44')

drop table testtable

--twentyth

select * from Inventory.Customer
where grade is null


--twenty first

select * from Inventory.Customer
where grade is not null



--twenty second

select * from dbo.emp_details
where emp_lname like 'D%'



