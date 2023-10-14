/* EX1: Query the names of all American cities in CITY with populations larger than 120,000. The CountryCode for America is USA. */
SELECT NAME
FROM CITY
WHERE CountryCode= 'USA' AND POPULATION > 120000;
/* EX2: Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. */
SELECT *
FROM CITY
WHERE COUNTRYCODE='JPN';
/*EX3: Query a list of CITY and STATE from the STATION table, where LAT_N is the northern latitude and LONG_W is the western longitude.*/
SELECT CITY, STATE
FROM STATION;
/*EX4:
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/
 SELECT DISTINCT(CITY) 
 FROM STATION
 WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' 
OR CITY LIKE 'U%' ORDER BY CITY ASC;   
/* EX5: Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.*/ 
SELECT DISTINCT(CITY) 
FROM STATION
WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' 
OR CITY LIKE '%u';     
/* EX6: Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.*/
SELECT DISTINCT CITY
FROM STATION 
WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') AND lower(SUBSTR(CITY,1,1)) NOT IN
('a','e','i','o','u');     
/*Ex7: select names of employees*/ 
SELECT name
FROM Employee 
ORDER BY name ASC;
/* Ex8: Write a query that prints a list of employee names for employees in the Employee
having a salary greater than  per month who have been employees for less than  months */
SELECT name
FROM Employee
WHERE salary>2000 AND months <10;
/*Ex9*/
SELECT product_id
FROM Products
WHERE low_fats='Y' AND recyclable='Y';
/*Ex10: Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.*/
SELECT  name
FROM Customer
WHERE referee_id <>2 OR referee_id IS NULL;
/*Ex11: */ 
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population>= 25000000;
/*Ex12: */
SELECT author_id AS id
FROM Views
WHERE author_id = viewer_id
GROUP BY id
ORDER BY id; 
/*Ex13: */ 
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;
/* Ex14: */
select * from lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary>= 70000;
/*EX15: */ 
select * from uber_advertising
WHERE money_spent>100000 AND year=2019;


