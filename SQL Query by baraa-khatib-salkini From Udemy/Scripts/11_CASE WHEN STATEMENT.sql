
--97) Use Case : Categorizing Data
/*
Generate a report showing the total sales for each category:
- High: If the sales higher than 50
- Medium: If the sales between 20 and 50
- Low: If the sales equal or lower than 20
Sort the result from highest to lowest.
*/

USE SalesDB
SELECT * 
FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM SALES.Orders

SELECT * FROM SALES.Products

SELECT LevelStatus, SUM(Sales) TotalSales FROM
(
SELECT P.Category,O.Sales,
CASE
WHEN O.Sales>50 THEN 'High'
WHEN O.Sales<=50 AND O.Sales>20 THEN 'Medium'
WHEN O.Sales<=20 THEN 'Low'
END 'LevelStatus'
FROM SALES.Orders O
INNER JOIN SALES.Products P ON O.ProductID=P.ProductID
) AccessoriesLevelTable
GROUP BY LevelStatus
ORDER BY TotalSales DESC



--98) Use Case : Mapping Value
--Retrieve employee details with gender displayed as full text

USE SalesDB
SELECT * 
FROM INFORMATION_SCHEMA.TABLES

SELECT FirstName, LastName, 
CASE
WHEN Gender='M' THEN 'Male'
WHEN Gender='F' THEN 'Female'
ELSE 'Not Available'
END GenderFullText
 FROM Sales.Employees

--Retrieve customer details with abbreviated country code

USE SalesDB
SELECT * 
FROM INFORMATION_SCHEMA.TABLES

SELECT DISTINCT Country FROM Sales.Customers

SELECT FirstName, LastName, Country, 
CASE
WHEN Country='Germany' THEN 'DE'
WHEN Country='USA'		THEN 'US'
ELSE 'N/A'
END CountryAbbreviation,
--QUICK FORM
CASE Country
WHEN 'Germany' THEN 'DE'
WHEN 'USA'		THEN 'US'
ELSE 'N/A'
END CountryAbbreviation2
FROM Sales.Customers


--100) Use Case : Handling Nulls
/*Find the average scores of customers and treat Nulls as O
And additional provide details such CustomerID & LastName*/

USE SalesDB
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM SALES.Customers

--WITH COALESCE OR ISNULL EXAMPLE
SELECT CustomerID, ISNULL(LastName, '') AS LastNameWithoutNull,Score ,AVG(Score) OVER() AvgScoreWitHNulL, COALESCE(Score, 0) ScoreWithoutNull ,AVG(COALESCE(Score, 0)) OVER() AS ScoreWithoutNull FROM SALES.Customers

--WITH CASE END STATEMENT EXAMPLE
SELECT CustomerID, COALESCE(LastName, '') AS LastNameWithoutNull,Score ,AVG(Score) OVER() AvgScoreWitHNull,
CASE
	WHEN Score IS NULL THEN 0
	ELSE SCORE
END ScoreWithoutNull,
AVG(
CASE
	WHEN Score IS NULL THEN 0
	ELSE SCORE
END 
)
OVER() AvgScoreWithoutNull
FROM SALES.Customers




/*Count how many times each customer has made an order
with sales greater than 30.*/

USE SalesDB
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM Sales.Orders ORDER BY CustomerID

SELECT CustomerID,
SUM(
CASE
	WHEN Sales>30 THEN 1
	ELSE 0
END
) TotalOrdersHighSales,
COUNT(*) TotalOrders
FROM Sales.Orders 
GROUP BY CustomerID
