/*
RULES OF SET OPERATORS
#1 RULE | ORDER BY can be used only once
#2 RULE | Same Number of Columns
#3 RULE | Matching Data Types
#4 RULE | Same Order of Columns
#5 RULE | First Query Controls Aliases
#6 RULE | Mapping Correct Columns
*/

USE SalesDB

--50) UNIOIN OPERATOR
/* Combine the data from
employees and customers into one table. */
SELECT
FirstName,
LastName
FROM SALES.Customers

UNION

SELECT 
FirstName,
LastName
FROM SALES.Employees


--51) UNION ALL OPERATOR
/* Combine the data from
employees and customers into one table,
including duplicates. */
SELECT
FirstName,
LastName
FROM SALES.Customers

UNION ALL

SELECT 
FirstName,
LastName
FROM SALES.Employees


--52) EXCEPT OPERATOR
--Find employees who are not customers at the same time
SELECT
FirstName,
LastName
FROM SALES.Customers

EXCEPT

SELECT 
FirstName,
LastName
FROM SALES.Employees


--2ND EXAMPLE FOR UNDERSTANDING.
SELECT
FirstName,
LastName
FROM SALES.Employees

EXCEPT

SELECT 
FirstName,
LastName
FROM SALES.Customers


--53) INTERSECT OPERATOR
--Find employees who are also customers
SELECT
FirstName,
LastName
FROM SALES.Customers

INTERSECT

SELECT 
FirstName,
LastName
FROM SALES.Employees


SELECT
C.FirstName,
C.LastName
FROM SALES.Customers C
INNER JOIN SALES.Employees E
ON C.FirstName=E.FirstName



--54) USE CASES: COMBINE INFORMATION
/* Orders are stored in separate tables (Orders and OrdersArchive).
Combine all orders into one report without duplicates. */

SELECT
        'Orders' AS SourceTable,
        [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM SALES.Orders

UNION

SELECT
        'OrdersArchive' AS SourceTable,
        [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM SALES.OrdersArchive
ORDER BY OrderID
