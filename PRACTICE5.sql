/* ex1 */
SELECT COUNTRY.CONTINENT , FLOOR(AVG(CITY.POPULATION))
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode = COUNTRY.code
GROUP BY COUNTRY.CONTINENT;
/*Ex2*/ 
SELECT
    ROUND(COUNT(texts.email_id) :: decimal / COUNT(DISTINCT emails.email_id), 2) AS activation_rate
FROM emails
left JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
/*ex3 */ 
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
/*Ex4*/
SELECT customers.customer_id
FROM customer_contracts AS customers
LEFT JOIN products 
ON customers.product_id=products.product_id
where product_name like '%Azure%'
GROUP BY customers.customer_id
having COUNT (DISTINCT products.product_category) = 3
/*ex5*/ 
SELECT mng.employee_id, mng.name, COUNT(*) AS reports_count, 
ROUND(AVG(emp.age)) AS average_age
FROM employees AS emp
INNER JOIN employees AS mng
ON emp.reports_to= mng.employee_id 
GROUP BY mng.employee_id, mng.name
ORDER BY mng.employee_id 
/*ex6*/ 
SELECT products.product_name, SUM(orders.unit) AS unit
FROM products 
INNER JOIN orders 
ON  products.product_id= orders.product_id
WHERE MONTH(order_date)=02 AND YEAR(order_date)=2020
GROUP BY products.product_name
HAVING SUM(orders.unit)>=100 
