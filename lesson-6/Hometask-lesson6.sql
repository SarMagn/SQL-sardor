use W3Resource

--bu vazifalarni websaytni o'zidagi editorda yozgaman

--exc:1

select salesman_id as ID, name, city from salesman
where city = 'London'
union 
(select customer_id, cust_name, city from customer
where city='London')

--exc:2
select distinct salesman_id, city from customer
union
select distinct salesman_id, city from salesman
order by salesman_id

--exc:3
select salesman_id, customer_id from orders
union
select salesman_id, customer_id from customer

--qoganini joint ni organib keyin qilaman


-- 1. Combine full names from `users` and `clients` tables.

select full_name from users
union
select full_name from clients

-- 2. Retrieve unique dates from `orders` and `payments` tables.

select order_id,order_date from orders
union
select payment_id, payment_date from payments

-- 3. Get all unique email addresses from `users` and `employees` tables.

select email from users
union
select email from Employees

-- 4. Retrieve unique cities from `clients` and `suppliers` tables.

select city from clients
union
select city from suppliers

-- 5. Get all unique names from `employees` and `managers` tables.

select name from Employees
union
select name from managers

-- 6. Retrieve unique product and service names from `products` and `services` tables.

select product_name as Name from products
union
select service_name from services

-- 7. Retrieve unique addresses from `students` and `teachers` tables.

select address from students
union
select address from teachers

-- 8. Retrieve unique titles from `movies` and `books` tables.

select title from Movies
union
select title from books

-- 9. Retrieve unique transport types from `public_transport` and `private_transport` tables.

select transport_type from public_transport
union
select transport_type from private_transport

-- 10. Retrieve unique process and event names from `processes` and `events` tables.

select process_name from processes
union
select event_name from events

-- 11. Retrieve email addresses that are present in both `users` and `employees` tables.

select email from users
intersect
select email from employees

-- 12. Retrieve cities that are present in both `clients` and `suppliers` tables.

select city from clients
intersect
select city from suppliers

-- 13. Retrieve dates that are present in both `orders` and `payments` tables.

select order_date from orders
intersect
select payment_date from payments

-- 14. Retrieve full names that are present in both `users` and `clients` tables.

select full_name from users
intersect
select full_name from clients

-- 15. Retrieve names that are present in both `students` and `teachers` tables.

select name from students
intersect
select name from teachers

-- 16. Retrieve email addresses from `users` table that are not present in `employees` table.

select email from users
except
select email from employees

-- 17. Retrieve cities from `clients` table that are not present in `suppliers` table.

select city from clients
except
select city from suppliers

-- 18. Retrieve dates from `orders` table that are not present in `payments` table.

select order_date from orders
except
select payment_date from payments

-- 19. Retrieve full names from `users` table that are not present in `clients` table.

select full_name from users
except
select full_name from clients

-- 20. Retrieve names from `students` table that are not present in `teachers` table.

select name from students
except
select name from teachers

-- 21. Use CASE to categorize orders as 'High', 'Medium', or 'Low' based on the order amount.

select *, case when order_amount = 150 then 'Low' 
			when order_amount=200 then 'Medium' 
			when order_amount=350 then 'High' 
			end as Category from orders

-- 22. Use CASE to determine the grade of students based on their score.

select * , case when score = 78 then 3 
				when score=85 then 4 
				when score = 92 then 5 
				end as Grade from students order by grade

-- 23. Use CASE to classify employees' salary as 'Above Average', 'Average', or 'Below Average'.

select *, case when salary = 60000 then 'Above Average' 
				when salary = 55000 then 'Average' 
				when salary=50000 then 'Below average' 
				end as Classification from employees

-- 24. Use CASE to assign a discount level to products based on their price.

select *, case when price=300 then '5% discount' 
				when price=600 then '10% discount'
				when price=800 then '20% discount'
				end as NewYearDiscout from products


-- 25. Use CASE to label movies as 'Classic', 'Modern', or 'Upcoming' based on the release year.

select *, case when movie_id=1 then 'Classical' 
				when movie_id=2 then 'Modern'
				when movie_id= 3 then 'Upcoming'
				end as Label from movies 

-- 26. Use IIF to check if the quantity in stock is greater than 100 and label as 'High' or 'Low'.

select * from stock

-- 27. Use IIF to determine if a student's attendance is 'Satisfactory' or 'Unsatisfactory'.

select *, IIF(attendance<=75,'Unsatisfactory',
				iif(attendance>=80,'Satisfactory','Average')) as Condition from students

-- 28. Use IIF to check if an employee(table:Employees1) is eligible for a bonus based on their performance score.

select * , iif(performanceScore >= 75,'Eligible for bonus',
								'Not eligible for bonus') as BonusChecker from employees1

-- 29. Use IIF to mark whether an order(Table: Orders1) is 'Complete' or 'Pending' or 'Delayed' based on the shipment status.

select *, IIF(ShipmentStatus='shipped' and PaymentStatus='Paid','Complete',
				iif(ShipmentStatus='Not Shipped'or PaymentStatus='unpaid' ,'Pending','Delayed')) as DeliveryStatus from orders1

-- 30. Use IIF to categorize products as 'In Stock' or 'Out of Stock' based on the availability.

select *, IIF(stockquantity>MinimumStockLevel, 'In stock','Out of stock') as Category from products1






use MyDatabase


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO users (user_id, full_name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Carol White', 'carol@example.com');

CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO clients (client_id, full_name, city) VALUES
(1, 'David Green', 'New York'),
(2, 'Eve Brown', 'Los Angeles'),
(3, 'Frank Black', 'Chicago');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, order_date, order_amount) VALUES
(1, '2024-01-01', 150.00),
(2, '2024-02-15', 200.00),
(3, '2024-03-30', 350.00);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    payment_date DATE
);

INSERT INTO payments (payment_id, payment_date) VALUES
(1, '2024-01-05'),
(2, '2024-02-20'),
(3, '2024-04-01');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, name, email, salary) VALUES
(1, 'George Martin', 'george@example.com', 50000),
(2, 'Hannah Lewis', 'hannah@example.com', 60000),
(3, 'Ian Clark', 'ian@example.com', 55000);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    city VARCHAR(100)
);

INSERT INTO suppliers (supplier_id, city) VALUES
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Los Angeles');

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO managers (manager_id, name) VALUES
(1, 'Jack Wilson'),
(2, 'Kathy Robinson'),
(3, 'Liam Walker');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop', 800.00),
(2, 'Smartphone', 600.00),
(3, 'Tablet', 300.00);

CREATE TABLE services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    service_price DECIMAL(10, 2)
);

INSERT INTO services (service_id, service_name, service_price) VALUES
(1, 'Consulting', 200.00),
(2, 'Maintenance', 150.00),
(3, 'Support', 100.00);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100),
    score INT,
    attendance INT
);

INSERT INTO students (student_id, name, address, score, attendance) VALUES
(1, 'Mike Harris', '123 Elm St', 85, 90),
(2, 'Nancy Adams', '456 Maple St', 92, 80),
(3, 'Olivia Scott', '789 Oak St', 78, 70);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100)
);

INSERT INTO teachers (teacher_id, name, address) VALUES
(1, 'Paul Young', '123 Elm St'),
(2, 'Quincy Turner', '456 Maple St'),
(3, 'Rachel King', '101 Pine St');

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT
);

INSERT INTO movies (movie_id, title, release_year) VALUES
(1, 'The Great Adventure', 1999),
(2, 'Modern Times', 2010),
(3, 'Future World', 2023);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100)
);

INSERT INTO books (book_id, title) VALUES
(1, 'The Old Man and the Sea'),
(2, 'To Kill a Mockingbird'),
(3, '1984');

CREATE TABLE public_transport (
    transport_id INT PRIMARY KEY,
    transport_type VARCHAR(50)
);

INSERT INTO public_transport (transport_id, transport_type) VALUES
(1, 'Bus'),
(2, 'Tram'),
(3, 'Subway');

CREATE TABLE private_transport (
    transport_id INT PRIMARY KEY,
    transport_type VARCHAR(50)
);

INSERT INTO private_transport (transport_id, transport_type) VALUES
(1, 'Car'),
(2, 'Bicycle'),
(3, 'Motorcycle');

CREATE TABLE processes (
    process_id INT PRIMARY KEY,
    process_name VARCHAR(100)
);

INSERT INTO processes (process_id, process_name) VALUES
(1, 'Manufacturing'),
(2, 'Packaging'),
(3, 'Shipping');

CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100)
);

INSERT INTO events (event_id, event_name) VALUES
(1, 'Conference'),
(2, 'Workshop'),
(3, 'Seminar');


CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    PerformanceScore INT,
    Salary DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO Employees1 (EmployeeID, EmployeeName, PerformanceScore, Salary)
VALUES
(1, 'Alice', 95, 50000.00),
(2, 'Bob', 75, 40000.00),
(3, 'Charlie', 60, 35000.00),
(4, 'Diana', 85, 45000.00),
(5, 'Eve', 50, 30000.00);


CREATE TABLE Orders1 (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(50),
    ShipmentStatus NVARCHAR(20), -- Values: 'Shipped', 'Not Shipped'
    PaymentStatus NVARCHAR(20), -- Values: 'Paid', 'Unpaid'
    DeliveryDate DATE
);

-- Insert sample data
INSERT INTO Orders1 (OrderID, CustomerName, ShipmentStatus, PaymentStatus, DeliveryDate)
VALUES
(1, 'Alice', 'Shipped', 'Paid', '2024-12-20'),
(2, 'Bob', 'Not Shipped', 'Paid', '2024-12-30'),
(3, 'Charlie', 'Shipped', 'Unpaid', '2024-12-15'),
(4, 'Diana', 'Shipped', 'Paid', '2024-12-24'),
(5, 'Eve', 'Not Shipped', 'Unpaid', NULL);


CREATE TABLE Products1 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    StockQuantity INT,
    MinimumStockLevel INT
);

-- Insert sample data
INSERT INTO Products1 (ProductID, ProductName, StockQuantity, MinimumStockLevel)
VALUES
(1, 'Laptop', 10, 5),
(2, 'Smartphone', 0, 10),
(3, 'Tablet', 3, 2),
(4, 'Headphones', 0, 0),
(5, 'Monitor', 15, 10);
