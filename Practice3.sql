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
