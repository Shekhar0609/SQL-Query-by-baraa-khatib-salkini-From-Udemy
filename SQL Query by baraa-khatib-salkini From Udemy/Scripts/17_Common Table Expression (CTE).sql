--156) Standalone CTE
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES


--#1 STEP: Find the total sales per customer

WITH CTE_Total_Sales AS 
(
SELECT 
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
--MAIN QUERY
SELECT 
C.CustomerID,
C.FirstName,
C.LastName,
cts.TotalSales
FROM Sales.Customers C
LEFT JOIN CTE_Total_Sales cts ON cts.CustomerID=C.CustomerID



--157) Multiple Standalone CTE
--#2 STEP: Find the last order date per customer.

WITH CTE_Total_Sales AS 
(
SELECT 
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
--MAIN QUERY
SELECT 
C.CustomerID,
C.FirstName,
C.LastName,
cts.TotalSales,
clo.Last_Order
FROM Sales.Customers C
LEFT JOIN CTE_Total_Sales cts ON cts.CustomerID=C.CustomerID
LEFT JOIN CTE_Last_Order clo ON clo.CustomerID=C.CustomerID



--158) Nested CTE
--#3 STEP: Rank Customers based on total sales per customer.
WITH CTE_Total_Sales AS 
(
SELECT 
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Customer_Rank AS
(
SELECT 
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) CustomerRank
FROM CTE_Total_Sales
)
--MAIN QUERY
SELECT 
C.CustomerID,
C.FirstName,
C.LastName,
cts.TotalSales,
clo.Last_Order,
ccr.CustomerRank
FROM Sales.Customers C
LEFT JOIN CTE_Total_Sales cts ON cts.CustomerID=C.CustomerID
LEFT JOIN CTE_Last_Order clo ON clo.CustomerID=C.CustomerID
LEFT JOIN CTE_Customer_Rank ccr ON ccr.CustomerID=C.CustomerID


--#4 STEP: Segment customers based on their total sales.
WITH CTE_Total_Sales AS 
(
SELECT 
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Customer_Rank AS
(
SELECT 
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) CustomerRank
FROM CTE_Total_Sales
)
, CTE_Customer_Segement AS
(
SELECT 
	CustomerID,
	TotalSales,
	CASE WHEN TotalSales>100 THEN 'High'
		WHEN TotalSales> 80 THEN 'Medium'
		ELSE 'Low'
		END CustomerSegement
FROM CTE_Total_Sales
)
--MAIN QUERY
SELECT 
C.CustomerID,
C.FirstName,
C.LastName,
cts.TotalSales,
clo.Last_Order,
ccr.CustomerRank,
ccs.CustomerSegement
FROM Sales.Customers C
LEFT JOIN CTE_Total_Sales cts ON cts.CustomerID=C.CustomerID
LEFT JOIN CTE_Last_Order clo ON clo.CustomerID=C.CustomerID
LEFT JOIN CTE_Customer_Rank ccr ON ccr.CustomerID=C.CustomerID
LEFT JOIN CTE_Customer_Segement ccs ON ccs.CustomerID=C.CustomerID




--160) Recursive CTE
--Generate a Sequence of Numbers from 1 to 20
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

WITH Series AS
(
	--Anchor Query
	SELECT 1 AS MyNumber

	UNION ALL
	--Reccursive Query
	SELECT 
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 1000
)
--Main Query
SELECT * 
FROM Series
OPTION (MAXRECURSION 2000)



/*Show the employee hierarchy by displaying
each employee's level within the organization.*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

WITH CTE_Emp_Hierarchy AS
(
	--Anchor Query
	SELECT
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL

	UNION ALL
	--Recursive Query
	SELECT
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM Sales.Employees e
	INNER JOIN CTE_Emp_Hierarchy ceh
	ON e.ManagerID = ceh.EmployeeID
)

--Main Query
SELECT
*
FROM CTE_Emp_Hierarchy
