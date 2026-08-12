--102) Intro - What is Data Aggregation
--Find the total number of Orders
--Find the total sales of all Orders
--Find the Average sales of all Orders
--Find the Highest sales of all Orders
--Find the Lowest sales of all Orders
USE MyDatabase
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
customer_id,
COUNT(*) AS TotalNumberOrders,
SUM(Sales) AS TotalSales,
AVG(Sales) AS AvgSales,
MAX(Sales) AS HighestSales,
MIN(Sales) AS LowesttSales
FROM orders
GROUP BY customer_id


--103) Window Function VS Group By
-- Find the total Sales Across all orders
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders
SELECT SUM(Sales) TotalSales FROM Sales.Orders


-- Find the total sales for each product
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders
SELECT ProductID, SUM(Sales) TotalSales FROM Sales.Orders GROUP BY ProductID


/*Find the total sales for each product,
additionally provide details such order id & order date*/
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders
SELECT 
OrderID, 
OrderDate, 
ProductID, 
SUM(Sales) OVER(PARTITION BY ProductID) TotalSales 
FROM Sales.Orders


--105) Window Partition By
/*Find the total sales across all orders, total sales for each product,
total sales for each combination of product and order status,
additionally provide details such order id & order date
*/

USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders

SELECT 
OrderID, 
OrderDate,
ProductID,
OrderStatus,
Sales, 
SUM(Sales) OVER() TotalSales, 
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) [SalessByProduct&Status]
FROM Sales.Orders


--106) Window Order By
/* Rank each order based on their sales from highest to lowest
Additionally provide details such order Id, order date
*/
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders

SELECT 
OrderID, 
OrderDate,
ProductID,
Sales, 
RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders



--107) Window Frame
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders

SELECT 
OrderID, 
OrderDate,
OrderStatus,
Sales, 
--Default Frame is ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW. CROSS CHECK WITH TotalSales AND TotalSales2
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) TotalSales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalSales2,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales3
FROM Sales.Orders


--108) Window Function Rules

/*Find the total sales for each order status,
only for two products 101 and 102*/

USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders

SELECT 
OrderID, 
OrderDate,
OrderStatus,
ProductID,
Sales, 
SUM(Sales) OVER() TotalSales, 
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)


--Rank customers based on their total sales
USE [SalesDB]
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders

SELECT 
CustomerID,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID

