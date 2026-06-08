USE MyDatabase

--12) SELECT & FROM
SELECT * 
FROM customers

SELECT * 
FROM orders


SELECT 
	first_name, 
	country,
	score
FROM customers


--13) WHERE
-- Retrieve customers with a score not equal to 0
SELECT * 
FROM customers 
WHERE score<>0

SELECT * 
FROM customers 
WHERE score!=0

-- Retrieve customers from Germany
SELECT * 
FROM customers 
WHERE country='Germany'


--14) ORDER  BY
--Retrieve all customers and sort the results by the highest score first

SELECT * 
FROM customers
ORDER BY score DESC

--Retrieve all customers and sort the results by the lowest score first
SELECT * 
FROM customers
ORDER BY score ASC

--Retrieve all customers and sort the results by the country and then by the highest score
SELECT * 
FROM customers
ORDER BY 
	country ASC,
	score DESC


--15) GROUP BY
--Find the total score for each country
SELECT
	country,
	SUM(score) AS [TotalScore]
FROM customers
GROUP BY country

--Find the total score and total number of customers for each country
SELECT
	Country,
	SUM(score) AS [TotalScore],
	COUNT(*) AS [NumberOfCustomer]
FROM customers
GROUP BY Country


--16) HAVING
/*Find the average score for each country
considering only customers with a score not equal to O
And return only those countries with
an average score greater than 430*/

SELECT
	country,
	AVG(score) AS [AVG_Score]
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) >430


--17) DISTINCT
SELECT
DISTINCT COUNTRY
FROM customers


--18) TOP(LIMIT)
--Retrieve the Top 3 Customers with the Highest Scores
SELECT
	TOP 3
	*
FROM customers
ORDER BY score DESC

--Retrieve the Lowest 2 Customers based on the Score
SELECT
	TOP 2
	*
FROM customers
ORDER BY score ASC

--Get the Two Most Recent Orders
SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC
