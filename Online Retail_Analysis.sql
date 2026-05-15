/*
==================================================================================
We'll develop a project for a "Fictional online Retail Company". 
This project will cover creating a database, tables, and indexes, inserting data,
and writing various queries for reporting and data analysis.
==================================================================================

Project Overview: Fictional online Retail Company
--------------------------------------
A.	Database Design
	-- Database Name: onlineRetailDB

B.	Tables:
	-- Customers: Stores customer details.
	-- Products: Stores product details.
	-- Orders: Stores order details.
	-- OrderItems: Stores details of each item in an order.
	-- Cateries: Stores product cateries.

C.	insert Sample Data:
	-- Populate each table with sample data.

D. Write Queries:
	-- Retrieve data (e.g., customer orders, popular products).
	-- Perform aggregations (e.g., total sales, average order value).
	-- join tables for comprehensive reports.
	-- Use subqueries and common table expressions (CTEs).
*/

/* LET'S GET STARTED */

-- Create the database
create database onlinedb;

-- Use the database
use onlinedb;

-- Create the Customers table
create table Customers (
    CustomerID int primary key auto_increment, FirstName varchar(50), LastName varchar(50), Email varchar(100), Phone varchar(50),
    Address varchar(255), City varchar(50), State varchar(50), ZipCode varchar(50), Country varchar(50),
    CreatedAt datetime default current_timestamp
);

-- Create the Products table
create table Products (
	ProductID int primary key auto_increment ,	ProductName varchar(100), CateryID int, Price decimal(10,2),
	Stock int, CreatedAt datetime default current_timestamp
);

-- Create the Cateries table
create table Cateries (
	CateryID int primary key auto_increment, CateryName varchar(100), Descrip varchar(255)
);

-- Create the Orders table
create table Orders (
	OrderId int primary key auto_increment, CustomerId int, OrderDate datetime default current_timestamp,
	TotalAmount decimal(10,2), foreign key (CustomerID) references Customers(CustomerID)
);

-- Alter / Rename the Column Name
alter table Orders rename column CustomerId to CustomerID;

-- Create the OrderItems table
create table OrderItems (
	OrderItemID int primary key auto_increment, OrderID int, ProductID int, Quantity int, Price decimal(10,2),
	foreign key (ProductID) references Products(ProductID), foreign key (OrderId) references Orders(OrderID)
);

-- insert sample data into Cateries table
insert into Cateries (CateryName, Descrip) 
values 
('Electronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electronic Books');

-- insert sample data into Products table
insert into Products(ProductName, CateryID, Price, Stock)
values 
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

-- insert sample data into Customers table
insert into Customers(FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
values 
('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield', 
'IL', '62701', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison', 
'WI', '53703', 'USA'),
('harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA');

-- insert sample data into Orders table
insert into Orders(CustomerId, OrderDate, TotalAmount)
values 
(1, current_timestamp, 719.98),
(2, current_timestamp, 49.99),
(3, current_timestamp, 44.98);

-- insert sample data into OrderItems table
insert into OrderItems(OrderID, ProductID, Quantity, Price)
values 
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1,  49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);

-- Query 1: Retrieve all orders for a specific customer
select o.OrderID, o.OrderDate, o.TotalAmount, oi.ProductID, p.ProductName, oi.Quantity, oi.Price
from Orders o
join OrderItems oi on o.OrderID = oi.OrderID
join products p on oi.ProductID = p.ProductID
where o.CustomerId = 1;

-- Query 2: Find the total sales for each product
select p.ProductID, p.ProductName, SUM(oi.Quantity * oi.Price) as TotalSales
from OrderItems oi
join Products p 
on oi.ProductID = p.ProductID
group by p.ProductID, p.ProductName
order by TotalSales desc;

-- Query 3: Calculate the average order value
select avg(TotalAmount) as avg_order_value from Orders;

-- Query 4: List the top 5 customers by total spending
select c.CustomerID, c.FirstName, c.LastName, sum(o.TotalAmount) as TotalSpent
from Customers c join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName, c.LastName
order by TotalSpent desc limit 5;

-- Query 5: Retrieve the most popular product catery
select CateryId, CateryName, TotalQuantitySold, rn
from (
    select c.CateryId, c.CateryName, sum(oi.Quantity) as TotalQuantitySold,
    row_number() over (order by sum(oi.Quantity) desc) as rn
    from OrderItems oi 
    join Products p on oi.ProductID = p.ProductID
    join Cateries c on p.CateryId = c.CateryId
    group by c.CateryId, c.CateryName
) as sub where rn = 1;

----- to insert a product with zero stock
insert into Products(ProductName, CateryId, Price, Stock) values ('Keyboard', 1, 39.99, 0);

-- Query 6: List all products that are out of stock, i.e. stock = 0
select * from Products where Stock = 0;

select ProductID, ProductName, Stock from Products where Stock = 0;

-- with catery name
select p.ProductID, p.ProductName, c.CateryName, p.Stock 
from Products p join Cateries c
on p.CateryID = c.CateryID
where Stock = 0;

-- Query 7: Find customers who placed orders in the last 30 days
select distinct c.CustomerID, c.FirstName, c.LastName,
    c.Email, c.Phone from Customers c join Orders o
    on c.CustomerID = o.CustomerID
where o.OrderDate >= DATE_SUB(NOW(), interval 30 DAY);

-- Query 8: Calculate the total number of orders placed each month
select year(OrderDate) as OrderYear, month(OrderDate) as OrderMonth,
count(OrderID) as TotalOrders from Orders group by year(OrderDate), 
month(OrderDate) order by OrderYear, OrderMonth;

-- Query 9: Retrieve the details of the most recent order
select c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
from Customers c join Orders o
on o.CustomerID = c.CustomerID
order by o.OrderDate DESC limit 1;

-- Query 10: Find the average price of products in each catery
-- FYR: Query 6
-- select p.ProductID, p.ProductName, c.CateryName, p.Stock 
-- from Products p join Cateries c
-- on p.CateryID = c.CateryID
-- where Stock = 0;
select c.CateryID, c.CateryName, round(avg(p.Price),2) as AveragePrice 
from Cateries c join Products p on c.CateryID = p.ProductID
group by c.CateryID, c.CateryName;

-- Query 11: List customers who have never placed an order

insert into Customers
(FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country) values
('Rahul', 'Sharma', 'rahul.sharma@example.com','999-888-7777', '12 MG Road', 'Delhi', 'Delhi', '110001', 'India');

select c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, O.OrderID, o.TotalAmount
from Customers c left join Orders o on c.CustomerID = o.CustomerID where o.TotalAmount is null;

-- Query 12: Retrieve the total quantity sold for each product
select p.ProductID, p.ProductName, SUM(oi.Quantity) as TotalQuantitySold
from OrderItems oi join Products p on oi.ProductID = p.ProductID
group by p.ProductID, p.ProductName order by p.ProductName;

-- Query 13: Calculate the total revenue generated from each catery
select c.CateryID, c.CateryName, SUM(oi.Quantity * oi.Price) as TotalRevenue
from OrderItems oi join Products p on oi.ProductID = p.ProductID join Cateries c
on c.CateryID = p.CateryID group by c.CateryID, c.CateryName order by TotalRevenue DESC;

-- Query 14: Find the highest-priced product in each catery
select c.CateryID, c.CateryName, p1.ProductID, p1.ProductName, p1.Price
from Cateries c join Products p1 on c.CateryID = p1.CateryID
where p1.Price = (select Max(Price) from Products p2 where p2.CateryID = p1.CateryID)
order by p1.Price desc;

-- Query 15: Retrieve orders with a total amount greater than a specific value (e.g., $500)
select o.OrderID, c.CustomerID, c.FirstName, c.LastName, o.TotalAmount from Orders o join Customers c
on o.CustomerID = c.CustomerID where o.TotalAmount >= 49.99 order by o.TotalAmount DESC;

-- Query 16: List products along with the number of orders they appear in
select p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount from Products p join OrderItems oi
on p.ProductID = oi.ProductID group by p.ProductID, p.ProductName order by OrderCount DESC;

-- Query 17: Find the top 3 most frequently ordered products
select p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount
from OrderItems oi join  Products p on oi.ProductID = p.ProductID
group by  p.ProductID, p.ProductName order by OrderCount desc limit 3;

-- Query 18: Calculate the total number of customers from each country
select Country, COUNT(CustomerID) AS TotalCustomers
from Customers group by Country order by TotalCustomers DESC;

-- Query 19: Retrieve the list of customers along with their total spending
select c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
from Customers c join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName, c.LastName;

-- Query 20: List orders with more than a specified number of items (e.g., 5 items)
select o.OrderID, c.CustomerID, c.FirstName, c.LastName, COUNT(oi.OrderItemID) AS NumberOfItems
from Orders o join OrderItems oi on o.OrderID = oi.OrderID join Customers c on o.CustomerID = c.CustomerID
group by o.OrderID, c.CustomerID, c.FirstName, c.LastName HAVING COUNT(oi.OrderItemID) >= 1
order by NumberOfItems;

