--168) CREATE, ALTER, DROP Views
--Find the running total of sales for each month
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

--e.g. With CTE
WITH CTE_Monthly_Summery AS
(
SELECT
DATETRUNC(MONTH, OrderDate) OrderMonth,
SUM(Sales) TotoalSales,
COUNT(OrderID) TotalOrders,
SUM(Quantity) TotalQuantites
FROM
Sales.Orders
GROUP BY DATETRUNC(MONTH, OrderDate) 
)

SELECT
OrderMonth,
TotoalSales,
SUM(TotoalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summery



--With VIEW CREATING
CREATE VIEW V_Monthly_Summery AS
(
SELECT
DATETRUNC(MONTH, OrderDate) OrderMonth,
SUM(Sales) TotoalSales,
COUNT(OrderID) TotalOrders,
SUM(Quantity) TotalQuantites
FROM
Sales.Orders
GROUP BY DATETRUNC(MONTH, OrderDate) 
)


--AFTER CREATING THE VIEW TABLE WE CAN WRITE THE QUERY USING TABLE NAME.
SELECT * FROM V_Monthly_Summery


--CREATING VIEW TABLE WITH SCHEMA
CREATE VIEW Sales.V_Monthly_Summery AS
(
SELECT
DATETRUNC(MONTH, OrderDate) OrderMonth,
SUM(Sales) TotoalSales,
COUNT(OrderID) TotalOrders,
SUM(Quantity) TotalQuantites
FROM
Sales.Orders
GROUP BY DATETRUNC(MONTH, OrderDate) 
)


--AFTER CREATING THE VIEW TABLE WITH SCHEMA WE CAN WRITE THE QUERY USING TABLE NAME.
SELECT * FROM Sales.V_Monthly_Summery


--DELETE THE VIEW TABLE
DROP VIEW dbo.V_Monthly_Summery


--T-SQL OR Transact-SQL 
--UPDATE THE INSIDE QUERY(ADD OR REMOVE THE QUERY) FROM THE VIEW TABLE.
IF OBJECT_ID('Sales.V_Monthly_Summery', 'V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summery
GO
CREATE VIEW Sales.V_Monthly_Summery AS
(
SELECT
DATETRUNC(MONTH, OrderDate) OrderMonth,
SUM(Sales) TotoalSales,
COUNT(OrderID) TotalOrders
FROM
Sales.Orders
GROUP BY DATETRUNC(MONTH, OrderDate) 
)

--AFTER CREATING THE VIEW TABLE WITH SCHEMA WE CAN WRITE THE QUERY USING TABLE NAME.
SELECT * FROM Sales.V_Monthly_Summery




--170) USE CASES : HIDE COMPLEXITY
/*
Provide a view that combines details from
orders, products, customers, and employees.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES


CREATE VIEW Sales.V_Order_Details AS
(
	SELECT
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category,
	CONCAT(COALESCE(C.FirstName, ''),' ',COALESCE(C.LastName, '')) CustomerName,
	C.Country,
	CONCAT(COALESCE(E.FirstName, ''),' ',COALESCE(E.LastName, '')) SalesName,
	E.Department,
	O.Sales,
	O.Quantity
	FROM Sales.Orders O
	LEFT JOIN Sales.Products P ON P.ProductID = O.ProductID
	LEFT JOIN Sales.Customers C ON C.CustomerID=O.CustomerID
	LEFT JOIN Sales.Employees E on E.EmployeeID=o.SalesPersonID
)


--AFTER CREATING THE VIEW TABLE WITH SCHEMA WE CAN WRITE THE QUERY USING TABLE NAME.
SELECT * FROM Sales.V_Order_Details



--171) USE CASES : DATA SECURITY
/*
Provide a view for the EU Sales Team
that combines details from all tables
and excludes data related to the USA.
*/
CREATE VIEW Sales.V_Order_Details_EU AS
(
	SELECT
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category,
	CONCAT(COALESCE(C.FirstName, ''),' ',COALESCE(C.LastName, '')) CustomerName,
	C.Country,
	CONCAT(COALESCE(E.FirstName, ''),' ',COALESCE(E.LastName, '')) SalesName,
	E.Department,
	O.Sales,
	O.Quantity
	FROM Sales.Orders O
	LEFT JOIN Sales.Products P ON P.ProductID = O.ProductID
	LEFT JOIN Sales.Customers C ON C.CustomerID=O.CustomerID
	LEFT JOIN Sales.Employees E on E.EmployeeID=o.SalesPersonID
	WHERE C.Country != 'USA'
)

--AFTER CREATING THE VIEW TABLE WITH SCHEMA WE CAN WRITE THE QUERY USING TABLE NAME.
SELECT * FROM Sales.V_Order_Details_EU



