USE SalesDB

--59) CONCAT FUNCTION
--Concatenate first name and country into one column
SELECT 
FirstName,
Country,
CONCAT(FirstName,' ' ,Country) AS name_country
FROM
SALES.Customers


--60) UPPER AND LOWER FUNCTION
--Convert the first name to lowercase
SELECT 
FirstName,
LOWER(FirstName) AS FirstNameInlowercase,
UPPER(FirstName) AS FirstNameInUppercase
FROM
SALES.Customers


--61) TRIM FUNCTION
/* Find customers whose first name
contains leading or trailing spaces */
USE MyDatabase

SELECT 
first_name,
LEN(first_name) AS len_name,
LEN(TRIM(first_name)) AS len_trim_name,
LEN(first_name)-LEN(TRIM(first_name)) AS flag
FROM Customers


--62) REPLACE FUNCTION
-- Remove dashes (-) from a phone number
SELECT 
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '') as cleanphone


--63) LEN FUNCTION
--Calculate the length of each customer's first name
USE MyDatabase

SELECT 
first_name,
LEN(first_name) AS len_name
FROM Customers


--64) LEFT AND RIGHT FUNCTION
--Retrieve the first two characters of each first name
USE MyDatabase

SELECT 
first_name,
LEFT(TRIM(first_name), 2) AS leftTwoChar
FROM Customers

--Retrieve the last two characters of each first name
SELECT 
first_name,
RIGHT(TRIM(first_name), 2) AS rightTwoChar
FROM Customers


--65) SUBSTRING FUNCTION
/* Retrieve a list of customers' first names
removing the first character */
USE MyDatabase

SELECT 
first_name,
SUBSTRING(TRIM(first_name), 2, LEN(TRIM(first_name))) AS subname
FROM Customers


--66) NUMBER FUNCTIONS
--ROUND FUNCTION
SELECT
3.516 AS number,
ROUND(3.516,2)AS round_2,
ROUND(3.516,1)AS round_1,
ROUND(3.516,0)AS round_0

--ABS FUNCTIONS
SELECT 
-10,
ABS(-10),
ABS(10)
