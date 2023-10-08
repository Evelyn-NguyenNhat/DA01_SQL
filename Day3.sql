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
SELECT DISTINCT city 
FROM station 
WHERE city REGEXP ‘^[AEIOUaeiou]’
/* EX5*/ 
SELECT DISTINCT CITY
FROM STATION
WHERE CITY RLIKE '[aeiou]$'
