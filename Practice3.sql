/*eX1: Find studens who have marks >75 */
SELECT Name
FROM STUDENTS 
WHERE Marks >75
ORDER BY RIGHT(Name,3), ID ASC
/*ex2: Fix Names In A Table Problem*/
select user_id, 
concat(upper(left(name,1)),lower(substring(name,2,20))) as name
from Users 
order by user_id
/*ex3: */
SELECT manufacturer, 
'$' || ROUND(SUM(total_sales)/1000000) || ' ' || 'million'  AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;
/*Ex4*/
SELECT ROUND (AVG(stars),2) AS avg_stars, product_id AS product, 
EXTRACT(MONTH FROM submit_date) AS mth
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id;
/*Ex5 */
SELECT sender_id, 
COUNT(message_id)AS count_messages
FROM messages
WHERE EXTRACT(MONTH FROM sent_date)='8'
AND EXTRACT(YEAR FROM sent_date)='2022'
GROUP BY sender_id
ORDER BY count_messages DESC
LIMIT 2;
/*Ex6: */
SELECT tweet_id
FROM Tweets 
WHERE LENGTH(content)>15;
/*Ex7*/
SELECT activity_date AS day, COUNT(Distinct(user_id)) AS active_users
FROM Activity
WHERE activity_date BETWEEN "2019-06-28" AND "2019-07-27"
GROUP BY activity_date;
/*Ex8*/ 
SELECT EXTRACT(MONTH FROM joining_date) AS joining_month, COUNT(id) AS employees
FROM employees
WHERE EXTRACT(MONTH FROM joining_date) BETWEEN 1 AND 7 
GROUP BY joining_month
ORDER BY joining_month;
/*Ex9*/ 
select POSITION ('a' IN first_name)
FROM worker
WHERE worker_id=4;
/*Ex10*/ 
SELECT id,
SUBSTRING (title, length(winery)+1,4) AS year
from winemag_p2
