USE MyDatabase

--21) CREATE
/* Create a new table called persons
with columns: id, person_name, birth_date, and phone*/

CREATE TABLE persons(
 id INT NOT NULL CONSTRAINT pk_persons PRIMARY KEY (ID),
 person_name VARCHAR(50) NOT NULL,
 birth_date DATE ,
 phone VARCHAR(50) NOT NULL
)

SELECT
*
FROM persons


--22) ALTER
--Add a new column called email to the persons table
ALTER TABLE 
persons 
ADD email VARCHAR(50) NOT NULL

SELECT
*
FROM persons

--Remove the column phone from the persons table
ALTER TABLE
persons
DROP COLUMN phone

SELECT
*
FROM persons


--23) DROP
--Delete the table persons from the database
DROP TABLE persons

SELECT
*
FROM persons