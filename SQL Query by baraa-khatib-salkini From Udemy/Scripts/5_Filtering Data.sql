USE MyDatabase

--28) Comparison Operators
--Retrieve all customers from Germany
SELECT 
*  
FROM customers 
WHERE country='Germany'


--Retrieve all customers who are not from Germany
SELECT 
*  
FROM customers 
WHERE country!='Germany'

SELECT 
*  
FROM customers 
WHERE country!='Germany'


--Retrieve all customers with a score greater than 500
SELECT 
*  
FROM customers 
WHERE score > 500


--Retrieve all customers with a score of 500 or more
SELECT 
*  
FROM customers 
WHERE score >= 500

--Retrieve all customers with a score less than 500
SELECT 
*  
FROM customers 
WHERE score < 500


--Retrieve all customers with a score of 500 or less
SELECT 
*  
FROM customers 
WHERE score <= 500


--29) AND Logical operators
/* Retrieve all customers who are from the USA
AND have a score greater than 500 */
SELECT 
*  
FROM customers 
WHERE country = 'USA' AND score > 500


--30) OR Logical operators
/* Retrieve all customers who are either from the USA
OR have a score greater than 500 */
SELECT 
*  
FROM customers 
WHERE country = 'USA' OR score > 500


--31) NOT Logical operators
--Retrieve all customers with a score NOT less than 500
SELECT 
*  
FROM customers 
WHERE NOT score < 500


--32) BETWEEN Range Operators
/* Retrieve all customers whose score falls
in the range between 100 and 500 */
SELECT 
*  
FROM customers 
WHERE score BETWEEN 100 AND 500


--33) IN Membaership Operators
--Retrieve all customers from either Germany OR USA
SELECT 
*  
FROM customers 
WHERE country in ('Germany','USA')


--Retrieve all customers from NOT either Germany OR USA
SELECT 
*  
FROM customers 
WHERE country NOT in ('Germany','USA')


--34) LIKE Search Operators
--Find all customers whose first name starts with 'M'
SELECT 
*  
FROM customers 
WHERE first_name LIKE 'M%'


--Find all customers whose first name ends with 'n'
SELECT 
*  
FROM customers 
WHERE first_name LIKE '%N'


--Find all customers whose first name contains 'r'
SELECT 
*  
FROM customers 
WHERE first_name LIKE '%R%'


/* Find all customers whose first name
has 'r' in the third position */
SELECT 
*  
FROM customers 
WHERE first_name LIKE '__R%'


