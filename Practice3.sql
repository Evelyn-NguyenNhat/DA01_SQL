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
