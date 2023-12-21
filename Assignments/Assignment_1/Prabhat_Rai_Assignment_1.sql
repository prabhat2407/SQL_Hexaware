--Q1.1
CREATE DATABASE TechShop;
USE TechShop;
/*Q2.1 Write SQL scripts to create the mentioned tables with appropriate data types, constraints, 
and relationships.*/

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

/*Q3.a Insert at least 10 sample records into each of the following tables.
Customers Table*/
INSERT INTO [dbo].[Customers] VALUES (1, 'Prabhat', 'Rai', 'prabhat@email.com', '1234567890', 'Mumbai');
INSERT INTO [dbo].[Customers] VALUES (2, 'Jayant', 'Ghosh', 'jayant@email.com', '0123456789', 'Kolkata');
INSERT INTO [dbo].[Customers] VALUES (3, 'Rohit', 'Thakur', 'rohit@email.com', '0912345678', 'Delhi');
INSERT INTO [dbo].[Customers] VALUES (4, 'Dhruv', 'Singhla', 'dhruv@email.com', '0981234567', 'Delhi');
INSERT INTO [dbo].[Customers] VALUES (5, 'Shivam', 'Mishra', 'shivam@email.com', '0987123456', 'Mumbai');
INSERT INTO [dbo].[Customers] VALUES (6, 'Anuj', 'Pal', 'anuj@email.com', '0987612345', 'Patna');
INSERT INTO [dbo].[Customers] VALUES (7, 'Vaibhav', 'Jain', 'vaibhav@email.com', '0987651234', 'Mumbai');
INSERT INTO [dbo].[Customers] VALUES (8, 'Swastik', 'Kumar', 'swastik@email.com', '0987654123', 'Kolkata');
INSERT INTO [dbo].[Customers] VALUES (9, 'Ayush', 'Gupta', 'ayush@email.com', '0987654312', 'Delhi');
INSERT INTO [dbo].[Customers] VALUES (10, 'Prashant', 'Gupta', 'prashant@email.com', '0987654321', 'Varanasi');

--Products Table
INSERT INTO [dbo].[Products] VALUES (11, 'Laptop', 'Powerful laptop', 175000.00);
INSERT INTO [dbo].[Products] VALUES (12, 'Mobile', 'Latest Model Mobile', 79990.00);
INSERT INTO [dbo].[Products] VALUES (13, 'Mouse', 'Gaming Mouse', 2500.00);
INSERT INTO [dbo].[Products] VALUES (14, 'Laptop', 'Slim Laptop', 55000.00);
INSERT INTO [dbo].[Products] VALUES (15, 'Laptop', 'Professional laptop', 150000.00);
INSERT INTO [dbo].[Products] VALUES (16, 'Mobile', 'Mid-Range Mobile', 25000.00);
INSERT INTO [dbo].[Products] VALUES (17, 'Charger', 'Type-C Charger', 500.00);
INSERT INTO [dbo].[Products] VALUES (18, 'Mouse', 'Basic Mouse', 800.00);
INSERT INTO [dbo].[Products] VALUES (19, 'Dryer', 'Heavy Duty Dryer', 1250.00);
INSERT INTO [dbo].[Products] VALUES (20, 'Microwave', 'Power Efficient Microwave', 15000.00);

--Orders Table
INSERT INTO Orders VALUES (21, 1, '2023-01-01', 150000.00);
INSERT INTO Orders VALUES (22, 2, '2023-06-15', 28000.00);
INSERT INTO Orders VALUES (23, 3, '2023-04-02', 100000.00);
INSERT INTO Orders VALUES (24, 4, '2022-11-22', 19000.00);
INSERT INTO Orders VALUES (25, 5, '2023-01-26', 175000.00);
INSERT INTO Orders VALUES (26, 6, '2022-06-10', 45000.00);
INSERT INTO Orders VALUES (27, 7, '2023-05-16', 90000.00);
INSERT INTO Orders VALUES (28, 8, '2023-03-05', 225000.00);
INSERT INTO Orders VALUES (29, 9, '2022-07-24', 49000.00);
INSERT INTO Orders VALUES (30, 10, '2023-08-27', 70000.00);

--OrderDetails Table
INSERT INTO [dbo].[OrderDetails] VALUES (31, 21, 11, 2);
INSERT INTO [dbo].[OrderDetails] VALUES (32, 22, 12, 4);
INSERT INTO [dbo].[OrderDetails] VALUES (33, 23, 13, 3);
INSERT INTO [dbo].[OrderDetails] VALUES (34, 24, 14, 1);
INSERT INTO [dbo].[OrderDetails] VALUES (35, 25, 15, 2);
INSERT INTO [dbo].[OrderDetails] VALUES (36, 26, 16, 2);
INSERT INTO [dbo].[OrderDetails] VALUES (37, 27, 17, 3);
INSERT INTO [dbo].[OrderDetails] VALUES (38, 28, 18, 1);
INSERT INTO [dbo].[OrderDetails] VALUES (39, 29, 19, 4);
INSERT INTO [dbo].[OrderDetails] VALUES (40, 30, 20, 1);

--Inventory Table
INSERT INTO Inventory VALUES (41, 11, 50, '2023-01-01');
INSERT INTO Inventory VALUES (42, 12, 25, '2023-06-05');
INSERT INTO Inventory VALUES (43, 13, 10, '2022-11-15');
INSERT INTO Inventory VALUES (44, 14, 5, '2023-06-05');
INSERT INTO Inventory VALUES (45, 15, 3, '2023-01-01');
INSERT INTO Inventory VALUES (46, 16, 11, '2023-01-01');
INSERT INTO Inventory VALUES (47, 17, 10, '2023-06-05');
INSERT INTO Inventory VALUES (48, 18, 8, '2022-11-15');
INSERT INTO Inventory VALUES (49, 19, 50, '2023-10-10');
INSERT INTO Inventory VALUES (50, 20, 12, '2023-08-27');

/*Q3.b
1.Write an SQL query to retrieve the names and emails of all customers.
SELECT [FirstName],[LastName],[Email] FROM [dbo].[Customers];*/

--2.Write an SQL query to list all orders with their order dates and corresponding customer names.
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName FROM Orders INNER JOIN
Customers ON Orders.CustomerID = Customers.CustomerID;

/*3.Write an SQL query to insert a new customer record into the "Customers" table.
Include customer information such as name, email, and address.*/
INSERT INTO Customers(CustomerID, FirstName, LastName, Phone, Email, Address) 
VALUES (101, 'ROHAN', 'SINGH', 'rohan@email.com', '7894561230', 'Mumbai');

/*4.Write an SQL query to update the prices of all electronic gadgets in the "Products" table 
by increasing them by 10%.*/
UPDATE Products SET Price = Price * 1.10;
SELECT * FROM Products;

/*5.Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.*/DECLARE @NewOrderID INT = 25;DELETE FROM OrderDetails WHERE OrderID = @NewOrderID; DELETE FROM Orders WHERE OrderID = @NewOrderID;/*6.Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, 
order date, and any other necessary information.*/

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (211, 101, '2023-08-16', 50000.00);

/*7.Write an SQL query to update the contact information (e.g., email and address) of a specific 
customer in the "Customers" table. Allow users to input the customer ID and new contact information.*/
DECLARE @CustomerIDUpdate INT = 1;
DECLARE @NewEmail VARCHAR(100) = 'newmail@email.com';
DECLARE @NewAddress VARCHAR(255) = 'Pune';
UPDATE Customers SET Email = @NewEmail, Address = @NewAddress WHERE CustomerID = @CustomerIDUpdate;
SELECT * FROM Customers WHERE CustomerID = @CustomerIDUpdate;

/*8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" 
table based on the prices and quantities in the "OrderDetails" table.*/
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(P.Price * OD.Quantity)
    FROM OrderDetails AS OD
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
    WHERE OD.OrderID = Orders.OrderID);

/*9.Write an SQL query to delete all orders and their associated order details for a specific customer from 
the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.*/
DECLARE @CustomerIDDelete INT = 1;
DELETE OD FROM OrderDetails AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE O.CustomerID = @CustomerIDDelete;
DELETE FROM Orders WHERE CustomerID = @CustomerIDDelete;

/*10.Write an SQL query to insert a new electronic gadget product into the "Products" table, 
including product name, category, price, and any other relevant details.*/
INSERT INTO [dbo].[Products] VALUES (111, 'Laptop', 'Gaming laptop', 100000.00);

/*11.Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
"Pending" to "Shipped"). Allow users to input the order ID and the new status.*/
--ALTER TABLE Orders ADD Status VARCHAR(50);
-- Add OrderStatus column to Orders table
-- Add OrderStatus column to Orders table
ALTER TABLE Orders ADD OrderStatus VARCHAR(50);
UPDATE Orders SET OrderStatus = 'Planned' WHERE OrderStatus IS NULL;

DECLARE @OrderIDToUpdate INT = 23;
DECLARE @NewStatus NVARCHAR(50) = 'Shipped';
UPDATE Orders SET OrderStatus = @NewStatus WHERE OrderID = @OrderIDToUpdate;

/*12.Write an SQL query to calculate and update the number of orders placed by each customer 
in the "Customers" table based on the data in the "Orders" table.*/
ALTER TABLE Customers ADD TotalOrders INT;
UPDATE Customers
SET TotalOrders= (
    SELECT COUNT(OrderID)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);

--Q4.Joins
/*1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., 
customer name) for each order.*/
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

/*2.Write an SQL query to find the total revenue generated by each electronic gadget product. 
Include the product name and the total revenue.*/
SELECT Products.ProductName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID GROUP BY Products.ProductName;

/*3.Write an SQL query to list all customers who have made at least one purchase. Include their 
names and contact information.*/
SELECT DISTINCT Customers.CustomerID, Customers.FirstName, Customers.LastName, 
Customers.Email, Customers.Phone, Customers.Address
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

/*4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
total quantity ordered. Include the product name and the total quantity ordered*/
SELECT TOP 1 Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName ORDER BY TotalQuantityOrdered DESC;

/*5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
categories.*/
SELECT ProductName, Description FROM Products;

/*6.Write an SQL query to calculate the average order value for each customer. Include the 
customer's name and their average order value.*/
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) 
AS AvgOrderValue FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

/*7.Write an SQL query to find the order with the highest total revenue. Include the order ID, 
customer information, and the total revenue.*/
SELECT TOP 1 Orders.OrderID, Customers.FirstName, Customers.LastName, 
SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Orders.OrderID, Customers.FirstName, Customers.LastName ORDER BY TotalRevenue DESC;

/*8.Write an SQL query to list electronic gadgets and the number of times each product has been ordered.*/
SELECT Products.ProductName, COUNT(OrderDetails.OrderDetailID) AS OrderCount
FROM Products LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID 
GROUP BY Products.ProductName;

/*9.Write an SQL query to find customers who have purchased a specific electronic gadget product. 
Allow users to input the product name as a parameter.*/
DECLARE @P VARCHAR(50) = 'Mobile';
SELECT DISTINCT Customers.CustomerID, Customers.FirstName, Customers.LastName, 
Customers.Email, Customers.Phone, Customers.Address FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = @P;

/*10.Write an SQL query to calculate the total revenue generated by all orders placed within a 
specific time period. Allow users to input the start and end dates as parameters.*/
DECLARE @StartDate DATE = '2022-05-01';
DECLARE @EndDate DATE = '2023-11-29';
SELECT SUM(Orders.TotalAmount) AS TotalRevenue
FROM Orders WHERE Orders.OrderDate BETWEEN @StartDate AND @EndDate;

--Q5. Aggregate Functions and Subqueries:
/*1.Write an SQL query to find out which customers have not placed any orders.*/
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL;

/*2.Write an SQL query to find the total number of products available for sale.*/
SELECT COUNT(*) AS TotalProducts FROM Products;

/*3.Write an SQL query to calculate the total revenue generated by TechShop.*/
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

/*4.Write an SQL query to calculate the average quantity ordered for products in a specific category. 
Allow users to input the category name as a parameter*/
DECLARE @Name VARCHAR(100) = 'Charger';
SELECT AVG(Quantity) AS AvgQuantity
FROM OrderDetails JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = @Name;

/*5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users 
to input the customer ID as a parameter.*/
DECLARE @CustID INT = 5;
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders WHERE CustomerID = @CustID;

/*6.Write an SQL query to find the customers who have placed the most orders. List their names 
and the number of orders they've placed.*/
SELECT TOP 1 Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName ORDER BY OrderCount DESC;

/*7.Write an SQL query to find the most popular product category, which is the one with the highest 
total quantity ordered across all orders.*/
SELECT TOP 1 Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM OrderDetails INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName ORDER BY TotalQuantity DESC;

/*8.Write an SQL query to find the customer who has spent the most money (highest total revenue) 
on electronic gadgets. List their name and total spending*/
SELECT TOP 1 Customers.FirstName, Customers.LastName, SUM(TotalAmount) AS TotalSpending
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = 'Mobile'
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY TotalSpending DESC;

/*9.Write an SQL query to calculate the average order value (total revenue divided by the number of 
orders) for all customers.*/
SELECT AVG(TotalAmount) AS AvgOrderValue FROM Orders;

/*10.Write an SQL query to find the total number of orders placed by each customer and list their 
names along with the order count.*/
SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

