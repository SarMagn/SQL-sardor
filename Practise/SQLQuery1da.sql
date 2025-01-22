select * from INFORMATION_SCHEMA.TABLES


select coalesce(studentid,'Unknown') as StudentID ,  Name, Subject, Grade,  coalesce(Semester,'Not found') from dbo.StudentsGrades


alter table dbo.studentsGrades drop constraint Unique_subject 

insert into StudentsGrades(subject) values ('Math')

select * from StudentsGrades
union all
select * from customers

SELECT *  
FROM hr.Employees e  
CROSS JOIN hr.Departments d;



SELECT * FROM hr.Employees e 


-- Create tables
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products10 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Sales INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Insert data into Categories
INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books');

-- Insert data into Products
INSERT INTO Products10 (ProductID, ProductName, CategoryID, Sales)
VALUES
(1, 'Laptop', 1, 5000),
(2, 'Smartphone', 1, 7000),
(3, 'T-Shirt', 2, 2000),
(4, 'Jeans', 2, 2000),
(5, 'Novel', 3, 1500),
(6, 'Textbook',  3, 3000);


select CategoryName, ProductName ,MAX(Sales)  from Categories as c
join Products10 as p on c.CategoryID = p.CategoryID
group by c.CategoryID, CategoryName, ProductName

