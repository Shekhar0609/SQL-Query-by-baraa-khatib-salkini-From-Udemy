USE SalesDB

--70) DAY, MONTH, YEAR
SELECT
CreationTime,
YEAR(CreationTime) YEAR,
MONTH(CreationTime) MONTH,
DAY(CreationTime) DAY
FROM SALES.Orders


--71) DATEPART
SELECT
CreationTime,
DATEPART(YEAR, CreationTime) YEAR_DP,
DATEPART(MONTH, CreationTime) MONTH_DP,
DATEPART(DAY, CreationTime) DAY_DP,
DATEPART(QUARTER, CreationTime) QUARTER_DP,
DATEPART(WEEKDAY, CreationTime) WEEKDAY_DP,
DATEPART(WEEK, CreationTime) WEEK_DP,
DATEPART(HOUR, CreationTime) HOUR_DP,
DATEPART(MINUTE, CreationTime) MINUTE_DP,
DATEPART(SECOND, CreationTime) SECOND_DP,
DATEPART(MILLISECOND, CreationTime) MILLISECOND_DP
FROM SALES.Orders


--72) DATENAME
SELECT
CreationTime,
DATENAME(MONTH, CreationTime) MONTH_DN,
DATENAME(WEEKDAY, CreationTime) WEEKDAY_DN,
DATENAME(WEEK, CreationTime) WEEK_DN
FROM SALES.Orders

--73) DATETRUNC
SELECT
CreationTime,
DATETRUNC(YEAR, CreationTime) YEAR_DT,
DATETRUNC(MONTH, CreationTime) MONTH_DT,
DATETRUNC(DAY, CreationTime) DAY_DT,
DATETRUNC(QUARTER, CreationTime) QUARTER_DT,
DATETRUNC(WEEK, CreationTime) WEEK_DT,
DATETRUNC(HOUR, CreationTime) HOUR_DT,
DATETRUNC(MINUTE, CreationTime) MINUTE_DT,
DATETRUNC(SECOND, CreationTime) SECOND_DT,
DATETRUNC(MILLISECOND, CreationTime) MILLISECOND_DT
FROM SALES.Orders


--74) EOMONTH
SELECT
CreationTime,
EOMONTH(CreationTime) EndOfMonth
FROM SALES.Orders


--75) USE CASES: DATE EXTRACTION
--How many orders were placed each year?
SELECT 
YEAR(OrderDate) YEAR,
COUNT(*) NoOfOrders
FROM SALES.Orders
GROUP BY YEAR(OrderDate)


--How many orders were placed each month?
SELECT 
DATENAME(MONTH, OrderDate) ORDERMONTH,
COUNT(*) NoOfOrders
FROM SALES.Orders
GROUP BY DATENAME(MONTH, OrderDate)


--DATA FILTERING
/* Show all orders that were placed
during the month of february */
SELECT 
DATENAME(MONTH, OrderDate) ORDERMONTH,
COUNT(*) NoOfOrders
FROM SALES.Orders
WHERE DATENAME(MONTH, OrderDate) = 'February'
GROUP BY DATENAME(MONTH, OrderDate)

SELECT 
DATEPART(MONTH, OrderDate) ORDERMONTH,
COUNT(*) NoOfOrders
FROM SALES.Orders
WHERE DATEPART(MONTH, OrderDate) = 2
GROUP BY DATEPART(MONTH, OrderDate)


--76) COMPARE EXTRACT FUNCTIONS
-- NOTE: FOR UNDERSTANDING DATES IN THE BELOW PATH GIVEN QUERY.
--SQL Query by baraa-khatib-salkini From Udemy\Scripts\Date & Time Functions\All Date Parts.sql


--78)FORMAT
SELECT 
CreationTime,
FORMAT(CreationTime, 'd') d,
FORMAT(CreationTime, 'dd') dd,
FORMAT(CreationTime, 'ddd') ddd,
FORMAT(CreationTime, 'dddd') dddd,
FORMAT(CreationTime, 'D') D,
FORMAT(CreationTime, 'm') m,
FORMAT(CreationTime, 'M') M,
FORMAT(CreationTime, 'MM') MM,
FORMAT(CreationTime, 'MMM') MMM,
FORMAT(CreationTime, 'MMMM') MMMM,
FORMAT(CreationTime, 'Y') Y,
FORMAT(CreationTime, 'y') y,
FORMAT(CreationTime, 'yy') yy,
FORMAT(CreationTime, 'yyy') yyy,
FORMAT(CreationTime, 'yyyy') yyyy
FROM SALES.Orders

/* Show CreationTime using the following format:
Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT
CreationTime,
FORMAT(CreationTime, 'dd ddd MMM ') + 
'Q'+DATENAME(QUARTER, CreationTime) + FORMAT(CreationTime, ' yyyy HH:mm:ss tt') 
FROM SALES.Orders

--How many orders were placed each month?
SELECT 
FORMAT(OrderDate, 'MMM yyyy') ORDERMONTH,
COUNT(*) NoOfOrders
FROM SALES.Orders
GROUP BY FORMAT(OrderDate, 'MMM yyyy')


--DATE & TIME FOMRAT SPECIFIERS
-- NOTE: FOR UNDERSTANDING DATE & TIME FOMRAT SPECIFIERS IN THE BELOW PATH GIVEN QUERY.
--SQL Query by baraa-khatib-salkini From Udemy\Scripts\Date & Time Functions\All Date Formats.sql


--NUMBER FORMAT SPECIFIERS
-- NOTE: FOR UNDERSTANDING NUMBER FORMAT SPECIFIERS IN THE BELOW PATH GIVEN QUERY.
--SQL Query by baraa-khatib-salkini From Udemy\Scripts\Date & Time Functions\All Number Formats.sql


--79) CONVERT
SELECT
CONVERT(INT, '123') AS [STRING TO INT CONVERT],
CONVERT(VARCHAR, 123) AS [INT TO STRING CONVERT],
CONVERT(DATE, '2025-08-20') AS [STRING TO DATE CONVERT],
CreationTime,
CONVERT(DATE, CreationTime) AS [Datetime TO DATE CONVERT],
CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM SALES.Orders

--DATE & TIME STYLE CONVERT
-- NOTE: FOR UNDERSTANDING DATE & TIME STYLE CONVERT IN THE BELOW PATH GIVEN QUERY.
--SQL Query by baraa-khatib-salkini From Udemy\Scripts\Date & Time Functions\All Culture Formats.sql


--80) CAST
SELECT
CAST('123' AS INT) AS [STRING TO INT],
CAST(123 AS VARCHAR) AS [INT TO STRING],
CAST('2025-08-20' AS DATE) AS [STRING TO DATE],
CAST('2025-08-20' AS DATETIME2) AS [STRING TO Datetime],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime TO DATE]
FROM SALES.Orders


--81) DATEADD
SELECT
CreationTime,
DATEADD(YEAR, 2, CreationTime) [AFTER 2 YEAR],
DATEADD(MONTH, 2, CreationTime) [AFTER 2 MONTH],
DATEADD(DAY, 2, CreationTime) [AFTER 2 DAY],
DATEADD(HOUR, 2, CreationTime) [AFTER 2 HOUR],
DATEADD(MINUTE, 2, CreationTime) [AFTER 2 MINUTS],
DATEADD(SECOND, 2, CreationTime) [AFTER 2 SECOND],
DATEADD(YEAR, -2, CreationTime) [BEFORE 2 YEAR],
DATEADD(MONTH, -2, CreationTime) [BEFORE 2 MONTH],
DATEADD(DAY, -2, CreationTime) [BEFORE 2 DAY],
DATEADD(HOUR, -2, CreationTime) [BEFORE 2 HOUR],
DATEADD(MINUTE, -2, CreationTime) [BEFORE 2 MINUTS],
DATEADD(SECOND, -2, CreationTime) [BEFORE 2 SECOND]
FROM SALES.Orders


--82) DATEDIFF
--Calculate the age of employees
SELECT
BirthDate,
datediff(YEAR, BirthDate, GETDATE()) Age
FROM SALES.Employees

-- Find the average shipping duration in days for each month
SELECT
FORMAT(ShipDate, 'Y') [Shipped MonthYear],
AVG(DATEDIFF(DAY, OrderDate, ShipDate)) [Diff Days]
FROM SALES.Orders
GROUP BY FORMAT(ShipDate, 'Y')

/* Find the number of days
between each order and previous order. */
SELECT 
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) [Number Of Days]
FROM SALES.Orders


--83) ISDATE
SELECT 
ISDATE('123') DateCheck1,
ISDATE('2025-08-20') DateCheck2,
ISDATE('20-08-2025') DateCheck3,
ISDATE('2025') DateCheck4,
ISDATE('2025-09') DateCheck5




