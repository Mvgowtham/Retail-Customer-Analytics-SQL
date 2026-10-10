CREATE DATABASE Retail_Analytics_DB

CREATE TABLE Customers (CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100),
Segment VARCHAR(50),
Country VARCHAR(50),
City VARCHAR(50))

CREATE TABLE Products (ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(50),
SubCategory VARCHAR(50),
UnitPrice DECIMAL(10,2))

CREATE TABLE SalesOrders (OrderID INT PRIMARY KEY,
OrderDate DATE,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
Quantity INT,
SalesAmount DECIMAL(5,2),
Discount DECIMAL(10,2),
Profit Decimal(10,2))

ALTER TABLE SalesOrders
ALTER COLUMN SalesAmount DECIMAL(12,2)

ALTER TABLE SalesOrders
ALTER COLUMN Profit DECIMAL(12,2)

-- Insert Sample Customers
INSERT INTO Customers VALUES 
(101, 'Gowtham M', 'Consumer', 'India', 'Coimbatore'),
(102, 'Priya Sharma', 'Corporate', 'India', 'Bangalore'),
(103, 'Arun Kumar', 'Home Office', 'India', 'Chennai'),
(104, 'Kavitha R', 'Consumer', 'India', 'Coimbatore'),
(105, 'Rajesh V', 'Corporate', 'India', 'Mumbai');


-- Insert Sample Products
INSERT INTO Products VALUES 
(501, 'Dell XPS Laptop', 'Technology', 'Computers', 85000.00),
(502, 'Ergonomic Chair', 'Furniture', 'Chairs', 12000.00),
(503, 'Logitech Wireless Mouse', 'Technology', 'Accessories', 1500.00),
(504, 'Executive Desk', 'Furniture', 'Tables', 25000.00),
(505, 'Mechanical Keyboard', 'Technology', 'Accessories', 4500.00);

-- Insert Sample Sales Orders
INSERT INTO SalesOrders VALUES 
(1001, '2026-01-15', 101, 501, 1, 85000.00, 0.05, 15000.00),
(1002, '2026-01-20', 102, 502, 2, 24000.00, 0.10, 4000.00),
(1003, '2026-02-10', 103, 503, 5, 7500.00, 0.00, 2000.00),
(1004, '2026-02-18', 101, 505, 2, 9000.00, 0.00, 2500.00),
(1005, '2026-03-05', 104, 504, 1, 25000.00, 0.15, 3500.00),
(1006, '2026-03-22', 105, 501, 2, 170000.00, 0.08, 30000.00),
(1007, '2026-04-02', 102, 503, 3, 4500.00, 0.00, 1200.00);

INSERT INTO Customers VALUES 
(106, 'Suresh Raina', 'Consumer', 'India', 'Chennai'),
(107, 'Anitha P', 'Corporate', 'India', 'Bangalore'),
(108, 'Vikram S', 'Home Office', 'India', 'Coimbatore'),
(109, 'Deepak Chahar', 'Consumer', 'India', 'Mumbai'),
(110, 'Meena Kumari', 'Corporate', 'India', 'Delhi');

INSERT INTO SalesOrders VALUES 
(1008, '2026-01-25', 106, 502, 3, 36000.00, 0.05, 6000.00),
(1009, '2026-02-01', 107, 501, 1, 85000.00, 0.10, 12000.00),
(1010, '2026-02-14', 108, 504, 2, 50000.00, 0.00, 8000.00),
(1011, '2026-02-28', 109, 503, 10, 15000.00, 0.00, 4000.00),
(1012, '2026-03-10', 110, 505, 4, 18000.00, 0.05, 3000.00),
(1013, '2026-03-15', 101, 502, 1, 12000.00, 0.00, 2000.00),
(1014, '2026-03-28', 103, 501, 1, 85000.00, 0.08, 14000.00),
(1015, '2026-04-05', 105, 505, 3, 13500.00, 0.00, 2200.00),
(1016, '2026-04-12', 107, 503, 6, 9000.00, 0.05, 2500.00),
(1017, '2026-04-20', 102, 504, 1, 25000.00, 0.10, 3000.00);

SELECT * FROM Customers
SELECT * FROM Products
SELECT * FROM SalesOrders

-- Customer LifeTime Value(Top Revenue Generating Customers)
SELECT c.CustomerID, c.CustomerName, c.City,
SUM(s.SalesAmount) AS TotalRevenue,
COUNT(s.OrderID) AS TotalOrders
FROM Customers c INNER JOIN SalesOrders s 
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City
ORDER BY TotalRevenue DESC

-- Month-over-Month (MoM) Revenue Growth
WITH MonthlySales AS (
SELECT FORMAT(OrderDate, 'yyyy-MM') AS SalesMonth,
SUM(SalesAmount) AS CurrentMonthSales
FROM SalesOrders
GROUP BY  FORMAT(OrderDate, 'yyyy-MM')
)
SELECT
SalesMonth, CurrentMonthSales,
LAG(CurrentMonthSales, 1, 0) OVER(ORDER BY SalesMonth) AS PreviousMonthSales,
ROUND((CurrentMonthSales - LAG(CurrentMonthSales, 1, 0) OVER(ORDER BY SalesMonth)), 2) AS MoM_Growth
FROM MonthlySales

-- Product Category Performance & Profitability
SELECT p.Category,
COUNT(DISTINCT s.OrderID) AS TotalOrders,
SUM(s.SalesAmount) AS TotalSales,
SUM(s.Profit) AS TotalProfit,
ROUND((SUM(s.Profit)/SUM(s.SalesAmount)) * 100, 2) AS ProfitMarginPercentage
FROM Products P INNER JOIN SalesOrders s 
ON p.ProductID = s.ProductID
GROUP BY p.Category
ORDER BY TotalProfit DESC

-- Customer Ranking per City
SELECT c.City, 
c.CustomerName,
SUM(s.SalesAmount) AS TotalSales,
DENSE_RANK() OVER (PARTITION BY c.City ORDER BY SUM(s.SalesAmount) DESC) AS CityRank
FROM Customers c JOIN SalesOrders s
ON c.CustomerID = s.CustomerID
GROUP BY c.City,c.CustomerName

-- Running Total Sales Over Time (Cumulative Revenue)
SELECT OrderID, OrderDate, SalesAmount,
SUM(SalesAmount) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales
FROM SalesOrders

-- Top Selling Product In Each Category
WITH RankedProducts AS (
SELECT p.Category, p.ProductName,
SUM(s.SalesAmount) AS ProductRevenue,
ROW_NUMBER() OVER (PARTITION BY p.Category ORDER BY SUM(s.SalesAmount) DESC) AS Rank
FROM Products p JOIN SalesOrders s
ON p.ProductID = s.ProductID
GROUP BY p.Category, p.ProductName
)
SELECT Category, ProductName, ProductRevenue
FROM RankedProducts
WHERE Rank = 1

-- Average Order Value (AOV) & Discount Impact
SELECT c.Segment, 
AVG(s.SalesAmount) AS AvgOrderValue,
ROUND(AVG(s.Discount) * 100,2) AS AvgDiscountPercentage,
SUM(s.Profit) AS TotalSegmentProfit
FROM Customers c JOIN SalesOrders s
ON c.CustomerID = s.CustomerID
GROUP BY c.Segment

-- Identification of Inactive/Churn Customers
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c LEFT JOIN SalesOrders s
ON c.CustomerID = s.CustomerID
WHERE s.OrderID IS NULL

-- Repeat Customers vs One-Time Buyers
SELECT c.CustomerID, c.CustomerName,
COUNT(s.OrderID) AS OrderCount,
CASE
    WHEN COUNT(s.OrderID) > 1 THEN 'Repeat Customer'
    ELSE 'One-Time Customer'
END AS CustomerType
FROM Customers c JOIN SalesOrders s 
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName

-- High-Value Orders Classification
SELECT OrderID, SalesAmount,
CASE
    WHEN SalesAmount >= 50000 THEN 'High Value Order'
    WHEN SalesAmount BETWEEN 15000 AND 49999 THEN 'Medium Value Order'
    ELSE 'Low Value Order'
END AS OrderCategory
FROM SalesOrders ORDER BY SalesAmount DESC











