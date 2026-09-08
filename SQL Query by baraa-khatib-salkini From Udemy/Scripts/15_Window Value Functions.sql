--131) Window LEAD AND LAG
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
ProductID,
OrderDate,
Sales,
LEAD(Sales, 1, 0) OVER(PARTITION BY ProductID ORDER BY OrderDate) LEAD,
LAG(Sales, 1, 0) OVER(PARTITION BY ProductID ORDER BY OrderDate) LAG
FROM Sales.Orders


--132) USE CASES: Month-Over-Month(MON)
/*
Analyze the month-over-month (MoM) performance
by finding the percentage change in sales
between the current and previous month.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
*,
CurrentMonthSales - PreviousMonth MON_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonth) AS FLOAT) / PreviousMonth * 100, 1) MOM_Perc
FROM (
SELECT
MONTH(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonth
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
) t



--133) USE CASES: CUSTOMER RETENTION
/*
Analyze customer loyalty by ranking customers
based on the average number of days between orders
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
CustomerID,
AVG(DaysUntilNextOrder) AVGdays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 99999)) RANKavg
FROM (
	SELECT
	OrderID,
	CustomerID,
	OrderDate CurrentOrder,
	LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t
GROUP BY 
	CustomerID



--134) USE CASES: TIME GAP ANALYSIS
--Find the average shipping duration in days for each month
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
	MONTH(OrderDate) OrderMonth,
	AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)


/*
Find the number of days
between each order and previous order.
*/
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
OrderID,
OrderDate,
LAG(OrderDate) OVER(ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(DAY, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) [No. Of Days]

FROM Sales.Orders



--135) WINDOW FIRST AND LAST
--Find the lowest and highest sales for each product
--Find the difference in sales between the current and the lowest sales
USE SalesDB

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) SalesDifference
FROM Sales.Orders
