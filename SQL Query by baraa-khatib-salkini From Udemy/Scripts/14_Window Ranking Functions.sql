--119) WINDOW ROW_NUMBER
--120) WINDOW RANK
--121) WINDOW DENSE_RANK
--122) ROW_NUMBER vs RANK vs DENSE_RANK
/* 
Rank the orders based on their sales
from highest to lowest
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
	RANK()		 OVER(ORDER BY Sales DESC) SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) SalesDense_Rank
FROM Sales.Orders


--123) USE CASES : Top/Bottom N Analysis
--Find the top highest sales for each product
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM (
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders
) T WHERE RankByProduct = 1


--USE CASES : Bottom N Analysis
/*
 Find the lowest 2 customers
based on their total sales
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM (
SELECT
	CustomerID,
	SUM(Sales)	TotalSales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID
) T WHERE RankCustomers<=2




--124) USER CASES : ASSIGN UNIQUE IDs
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID, 
*
FROM Sales.OrdersArchive



--125) USE CASES : IDENTIFY DUPLICATES
/*
Identify duplicate rows in the table 'Orders Archive'
and return a clean result without any duplicates
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM (
SELECT
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime  DESC) RN,
*
FROM Sales.OrdersArchive
) T WHERE RN = 1



--126) WINDOW CUME_DIST
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
ProductID,
Sales,
CUME_DIST() OVER(ORDER BY SALES DESC) CUME_DIST
FROM Sales.Orders



--127) Window PERCENT_RANK
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

/*
Find the products that fall within
the highest 40% of prices
*/

SELECT * FROM SALES.Products

SELECT
*,
CONCAT(CUME_DIST * 100, '%') DistRankPerc,
CONCAT(PERCENT_RANK * 100, '%') PercentRankPerc
FROM (
SELECT 
Product, 
Price,
CUME_DIST() OVER(ORDER BY PRICE DESC) CUME_DIST,
PERCENT_RANK() OVER(ORDER BY PRICE DESC) PERCENT_RANK
FROM SALES.Products
)t WHERE CUME_DIST <= 0.4



--128) Window NTILE
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
OrderID,
Sales,
NTILE(1) OVER( ORDER BY SALES DESC) OneBucket,
NTILE(2) OVER( ORDER BY SALES DESC) TwoBucket,
NTILE(3) OVER( ORDER BY SALES DESC) ThreeBucket,
NTILE(4) OVER( ORDER BY SALES DESC) FourBucket
 FROM Sales.Orders


 --USE CASES
/*
Segment all orders into 3 categories:
high, medium and low sales
*/

SELECT 
*,
CASE
WHEN ThreeBucket=1 THEN 'High'
WHEN ThreeBucket=2 THEN 'Medium'
ELSE 'Low'
END SalesSegmentations
FROM (
SELECT 
OrderID,
Sales,
NTILE(3) OVER( ORDER BY SALES DESC) ThreeBucket
 FROM Sales.Orders
)t 


/*
In order to export the data,
divide the orders into 2 groups
*/

SELECT 
NTILE(2) OVER( ORDER BY SALES DESC) TwoBucket,
*
 FROM Sales.Orders
