USE MyDatabase

--37) NO JOIN
/* Retrieve all data from customers
and orders as separate results */
SELECT
* 
FROM customers

SELECT 
*
FROM orders


--38) INNER JOIN
/* Get all customers along with their orders,
but only for customers who have placed an order */
SELECT
* 
FROM customers C 
INNER JOIN orders O 
ON C.ID=O.customer_id


--39) LEFT JOIN
/* Get all customers along with their orders,
including those without orders */
SELECT
*
FROM customers C 
LEFT JOIN orders O 
ON C.ID=O.customer_id


SELECT
*
FROM orders O  
LEFT JOIN customers C 
ON C.ID=O.customer_id


--40) RIGHT JOIN
/* Get all customers along with their orders,
including orders without matching customers */
SELECT
* 
FROM customers C 
RIGHT JOIN orders O 
ON C.ID=O.customer_id


SELECT
*
FROM orders O  
RIGHT JOIN customers C 
ON C.ID=O.customer_id

/* NOTE : Get all customers along with their orders,
including orders without matching customers
(Using LEFT JOIN)*/
SELECT
*FROM customers C 
LEFT JOIN orders O 
ON C.ID=O.customer_id


--41) FULL JOIN
/* Get all customers and all orders,
even if there's no match */
SELECT
*
FROM customers C 
FULL JOIN orders O 
ON C.ID=O.customer_id


--42) LEFT ANTI JOIN
--Get all customers who haven't placed any order
SELECT
*
FROM customers C 
LEFT JOIN orders O 
ON C.ID=O.customer_id
WHERE O.customer_id IS NULL


--43) RIGHT ANTI JOIN
--Get all orders without matching customers
SELECT
*
FROM customers C 
RIGHT JOIN orders O 
ON C.ID=O.customer_id
WHERE C.id IS NULL

/* Get all orders without matching customers
(Using LEFT JOIN) */
SELECT
*
FROM orders O 
LEFT JOIN customers C 
ON C.ID=O.customer_id
WHERE C.id IS NULL


--44) FULL ANTI JOIN
/* Find customers without orders
and orders without customers */
SELECT
*
FROM customers C 
FULL JOIN orders O 
ON C.ID=O.customer_id
WHERE C.id IS NULL OR O.order_id IS NULL


/* Get all customers along with their orders,
but only for customers who have placed an order */
SELECT
*
FROM customers C 
FULL JOIN orders O 
ON C.ID=O.customer_id
WHERE  C.id IS NOT NULL AND  O.order_id IS NOT NULL

/* Get all customers along with their orders,
but only for customers who have placed an order
(Without Using INNER JOIN) */
SELECT
*
FROM customers C 
LEFT JOIN orders O 
ON C.ID=O.customer_id
WHERE O.customer_id IS NOT NULL


--45) CROSS JOIN
/* Generate all possible combinations of
customers and orders */

SELECT * FROM customers
SELECT * FROM orders

SELECT
*
FROM customers C 
CROSS JOIN orders O
ON C.ID=O.customer_id


--46) MULTIPLE TABLE JOINS
/* Using SalesDB, Retrieve a list of all orders, along with
the related customer, product, and employee details. 
Order ID, Customer's name, Product name, Sales, Price, Sales person's name */

USE SalesDB

SELECT * FROM SALES.Orders
SELECT * FROM SALES.OrdersArchive
SELECT * FROM SALES.CUSTOMERS
SELECT * FROM SALES.Products
SELECT * FROM SALES.Employees



 SELECT
 O.OrderID,
 C.FirstName AS CustomerFirstName,
 C.LastName AS CustomerLastName,
 P.Product AS ProductName,
 P.Price,
 E.FirstName AS SalesPersonFirstName,
 E.LastName AS SalesPersonLastName,
 O.Sales
 FROM SALES.ORDERS O
 LEFT JOIN SALES.CUSTOMERS C
 ON O.CustomerID=C.CustomerID
 LEFT JOIN SALES.Products P
 ON O.ProductID=P.ProductID
 LEFT JOIN SALES.Employees E
 ON O.SalesPersonID=E.EmployeeID


SELECT
 O.OrderID,
 C.FirstName AS CustomerFirstName,
 C.LastName AS CustomerLastName,
 P.Product AS ProductName,
 P.Price,
 E.FirstName AS SalesPersonFirstName,
 E.LastName AS SalesPersonLastName,
 O.Sales
FROM Sales.ORDERS O
INNER JOIN Sales.Customers C
ON O.CustomerID=C.CustomerID 
INNER JOIN SALES.Products P
ON O.ProductID=P.ProductID
INNER JOIN SALES.Employees E
ON O.SalesPersonID=E.EmployeeID

