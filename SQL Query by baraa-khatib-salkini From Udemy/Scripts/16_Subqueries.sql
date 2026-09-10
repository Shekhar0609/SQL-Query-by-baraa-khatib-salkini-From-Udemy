--141) Subquery Result Types
--Scaller Subquery - Single Value
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
AVG(Sales)
FROM Sales.Orders


--Row Subquey - Multiple Rows & Single Column
USE SalesDB

SELECT
CustomerID
FROM Sales.Orders

--Table Subquery - Multiple Rows & Multiple Columns
USE SalesDB

SELECT
OrderID,
OrderDate
FROM Sales.Orders



--143) Subquery in FROM
/*
Find the products that have a price higher
than the average price of all products.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

--Main Query
USE SalesDB

SELECT
* FROM (
	--SubQuery
	SELECT 
	ProductID,
	Price,
	AVG(Price) OVER() AvgPrice
	FROM Sales.Products
	)t
WHERE Price>AvgPrice



--Rank customers based on their total amount of sales
USE SalesDB
--Main Query
SELECT
* ,
RANK() OVER (ORDER BY TotalSales DESC) CustomerRank
FROM (
	--SubQuery
	SELECT
	CustomerID,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
	) t



--Subquery in SELECT
/*
Show the product IDs, names, prices
and total number of orders.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

--Main Query
SELECT
ProductID,
Product,
Price,
--SubQuery
(SELECT COUNT(*) FROM Sales.Orders) As TotalOrders
FROM Sales.Products


--145) Subquery in JOIN
/*
Show all customer details and find the total orders
for each customer.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
C.*,
O.TotalOrders
FROM Sales.Customers C
	LEFT JOIN (
	SELECT 
	CustomerID,
	COUNT(*) TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) O
ON C.CustomerID=O.CustomerID



--146) Subquery in WHERE
/*
Find the products that have a price higher
than the average price of all products.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
ProductID,
Price,
(SELECT AVG(Price) FROM Sales.Products) AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)



--147) Subquet using IN Operator
/*
Show the details of orders made
by customers in Germany.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*
FROM Sales.Orders
WHERE CustomerID IN 
				(SELECT 
				CustomerID 
				FROM Sales.Customers 
				WHERE Country = 'Germany')


/*
Show the details of orders for customers
who are not from Germany.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*
FROM Sales.Orders
WHERE CustomerID NOT IN 
				(SELECT 
				CustomerID 
				FROM Sales.Customers 
				WHERE Country = 'Germany')



--148) Subquey using ALL & ANY Operators
/*
Find female employees whose salaries are greater
than the salaries of any male employees
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Employees

SELECT 
	EmployeeID,
	FirstName,
	Salary 
FROM Sales.Employees 
WHERE Gender='F' AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender='M')


/*
Find female employees whose salaries are greater
than the salaries of all male employees
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees WHERE Gender='M' AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender='F')



--149) Correlated Subquey
/*
Show all customer details and
find the total orders for each customer.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

--Main Query 
SELECT 
*,
(SELECT COUNT(*) FROM Sales.Orders O WHERE O.CustomerID=C.CustomerID) TotalSales
FROM Sales.Customers C


--150) Subquery using EXISTS
--Show the order details for customers in Germany.
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*
FROM Sales.Orders O 
WHERE EXISTS (
			SELECT 1
			FROM Sales.Customers C
			WHERE Country='Germany' 
			AND O.CustomerID=C.CustomerID)



--Show the order details for customers not in Germany.
SELECT
*
FROM Sales.Orders O 
WHERE NOT EXISTS (
			SELECT 1
			FROM Sales.Customers C
			WHERE Country='Germany' 
			AND O.CustomerID=C.CustomerID)
