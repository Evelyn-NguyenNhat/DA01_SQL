/* ex1 */
SELECT COUNTRY.CONTINENT , FLOOR(AVG(CITY.POPULATION))
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode = COUNTRY.code
GROUP BY COUNTRY.CONTINENT;
/*ex2 */ 
SELECT age.age_bucket,
  
  ROUND(100.0* SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')
        / SUM(activities.time_spent), 2) AS send_percentage, 
  ROUND(100.0* 
  SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')
        / SUM(activities.time_spent), 2) AS open_percentage
FROM activities 
INNER JOIN age_breakdown AS age ON activities.user_id = age.user_id
WHERE activities.activity_type IN ('open', 'send')
GROUP BY age.age_bucket;
