USE MyDatabase

--24) INSERT
SELECT
*
FROM customers

INSERT INTO customers (id, first_name)
VALUES (10, 'Sahra')

--Copy data from 'customers' table into 'persons'
CREATE TABLE persons(
 id INT NOT NULL CONSTRAINT pk_persons PRIMARY KEY (ID),
 person_name VARCHAR(50) NOT NULL,
 birth_date DATE ,
 phone VARCHAR(50) NOT NULL
)

SELECT 
* 
FROM persons

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers

SELECT 
* 
FROM persons


--25) UPDATE
--Change the score of customer with ID 6 to O
UPDATE customers SET score=0 WHERE ID IN (6)


/* Change the score of customer with ID 10 to O and
update the country to 'UK'*/
UPDATE customers SET score=0, country='UK' WHERE ID IN (10)


/* Update all customers with a NULL score
by setting their score to O */
UPDATE customers SET score=0 WHERE score IS NULL


--26) DELETE
--Delete all customers with an ID greater than 5
DELETE FROM customers WHERE ID>5

--Delete all data from the persons table
DELETE FROM persons 

SELECT 
* 
FROM customers