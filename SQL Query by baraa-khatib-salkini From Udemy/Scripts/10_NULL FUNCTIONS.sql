
--86) COALESCE VS ISNULL

--ISNULL
USE [SalesDB]
SELECT 
ISNULL(BillAddress, ShipAddress) ISNULL_FUNCTION,
* 
FROM SALES.Orders WHERE BillAddress IS NULL


--COALESCE
USE [SalesDB]
SELECT 
COALESCE(BillAddress, ShipAddress, 'Not Entered') COALESCE_FUNCTION,
* 
FROM SALES.Orders WHERE BillAddress IS NULL



--87) Handaling NULL : Data Aggregation

--Find the average scores of the customers

USE [SALESDB]

SELECT 
CustomerID,
Score,
ISNULL(SCORE, 0) Score2,
AVG(SCORE) OVER() WithNullValue,
AVG(ISNULL(SCORE, 0)) OVER()WithoutNullValue
FROM
SALES.Customers

SELECT 
CustomerID,
Score,
COALESCE(SCORE, 0) Score2,
AVG(COALESCE(SCORE, 0)) OVER() WithoutNullValue
FROM
SALES.Customers


--88) Handaling NULL : Mathematic Operations
/*Display the full name of customers in a single field
by merging their first and last names,
and add 10 bonus points to each customer's score.*/

USE SalesDB
SELECT
FirstName,
LastName,
CONCAT(COALESCE(FirstName,''),' ', COALESCE(LastName, '')) FullName,
Score,
COALESCE(SCORE,0)+10 ScoreWithBonus
FROM Sales.Customers


--89) Handaling NULL : Joining Data




--90) Handaling NULL : Sorting Data
/*Sort the customers from lowest to highest scores,
with NULLs appearing last.*/

USE SalesDB
SELECT
CustomerID,
Score,
COALESCE(SCORE,99999999)
FROM Sales.Customers
ORDER BY COALESCE(SCORE,99999999)



--91) NULLIF
/*Find the sales price for each order by
dividing the sales by the quantity.*/

USE SalesDB
SELECT
ProductID,
Quantity,
Sales,
NULLIF(QUANTITY,0) QuantityWithNull2,
Sales/NULLIF(QUANTITY,0) SalePrice2,
CASE WHEN Quantity=0 THEN NULL ELSE Quantity END QuantityWithNull1,
Sales/ CASE WHEN Quantity=0 THEN NULL ELSE Quantity END SalePrice1
FROM SALES.Orders


--92) IS NULL & IS NOT NULL
--Identify the customers who have no scores
USE SalesDB
SELECT
*
FROM Sales.Customers WHERE Score IS NULL

--List all customers who have scores
USE SalesDB
SELECT
*
FROM Sales.Customers WHERE Score IS NOT NULL


--List all details for customers who have not placed any orders
USE SalesDB
SELECT
C.*,
O.OrderID
FROM Sales.Customers C 
LEFT JOIN Sales.Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL


--93) NULL vs EMPTY vs BLANK
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
DATALENGTH(Category) AS CategoryLength
FROM Orders


--94) Handaling NULL : Data Policies
/*#1 DATA POLICY
Only use NULLs and empty strings,
but avoid blank spaces.*/
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
DATALENGTH(Category) AS CategoryLength,
DATALENGTH(TRIM(Category)) AS AfterTrim
FROM Orders


/*#2 DATA POLICY
Only use NULLS and
avoid using empty strings and blank spaces*/
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
DATALENGTH(Category) AS CategoryLength,
NULLIF(TRIM(Category),'') AS AfterTrimNull
FROM Orders


/*#3 DATA POLICY
Use the default value 'unknown' and
avoid using nulls, empty strings, and blank spaces.*/
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
DATALENGTH(Category) AS CategoryLength,
COALESCE(NULLIF(TRIM(Category),''), 'Unknown') AS AfterTrim
FROM Orders
