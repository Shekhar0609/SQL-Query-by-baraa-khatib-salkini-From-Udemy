--111) Window COUNT FUNCTION
--Find the total number of orders
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
COUNT(*) TotalOrders
FROM
SALES.Orders


/* Find the total number of orders
additionally provide details such order id & order date */
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
OrderId,
OrderDate,
COUNT(*) OVER() TotalOrders
FROM
SALES.Orders


--Find the total orders for each customers
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
OrderID,
CustomerID,
COUNT(*) OVER(PARTITION BY CustomerID) TotalOrdersByEachCustomer
FROM
SALES.Orders


/* Find the total number of customers,
additionally provide all customer's details*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
*,
CONCAT(FirstName,' ', LastName) FullName,
COUNT(*) OVER() [TotalCustomers],
COUNT(Score) OVER() [TotalScores],
COUNT(Country) OVER() [TotalCountries]
FROM SALES.Customers


--112) Window SUM FUNCTION
/* Find the total sales across all orders
and the total sales for each product.
Additionally, provide details such as order ID and order date.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts
FROM Sales.Orders


/* Find the percentage contribution of
each product's sales to the total sales
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS Float)/SUM(Sales) OVER() * 100,2) PercentageOfTotal
FROM Sales.Orders


--113) Window AVG FUNCTION
/*
Find the average sales across all orders
and the average sales for each product.
Additionally, provide details such as order ID and order date.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
OrderDate,
ProductId,
AVG(Sales) OVER() TotalAvgSales,
AVG(Sales) OVER(PARTITION BY ProductId) AvgSalesByProducts
FROM Sales.Orders


/*
Find the average scores of customers.
Additionally, provide details such as Customer ID and Last Name
*/

USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
CustomerID,
LastName,
Score,
AVG(Score) OVER() TotalAvgScoresWithNull,
AVG(COALESCE(Score, 0)) OVER() TotalAvgScoresWithoutNull
FROM Sales.Customers


/*
Find all orders where sales
are higher than the average sales across all orders.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*
FROM (
SELECT
OrderID,
ProductID,
Sales,
AVG(Sales) OVER() TotalAvgSales
FROM Sales.Orders
) t WHERE Sales>TotalAvgSales




--114) Window MIN & MAX FUNCTION
/*
Find the highest & lowest sales across all orders
and the highest & lowest sales for each product.
Additionally, provide details such as order ID and order date.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
ProductID,
Sales,
MIN(Sales) OVER() LowestSalesByProducts,
MAX(Sales) OVER() HighestSalesByProducts,
MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProducts,
MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProducts
FROM Sales.Orders


--Show the employees with the highest salaries
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*
FROM (
SELECT
*,
MAX(Salary) OVER() HighestSalary
FROM Sales.Employees
) T WHERE Salary=HighestSalary


/* 
Calculate the deviation of each sale from both
the minimum and maximum sales amounts.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
ProductID,
Sales,
MIN(Sales) OVER() LowestSalesByProducts,
MAX(Sales) OVER() HighestSalesByProducts,
Sales - MIN(Sales) OVER() DeviationFromMin,
MAX(Sales) OVER() - Sales DeviationFromMax
FROM Sales.Orders



--115) USE CASE : ROLLING & RUNNING TOTAL
--THIS TOPIC THOARY AND IMPORTATING.



--116) USE XASE : MOVING AVERAGE
/*
Calculate the moving average of sales
for each product over time
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders


/*
Calculate the moving average of sales for each
product over time, including only the next order.
*/


SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders
