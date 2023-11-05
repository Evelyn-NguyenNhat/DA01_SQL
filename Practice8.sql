/* Ex1 */ 
SELECT 
(ROUND (SUM(CASE WHEN order_date=customer_pref_delivery_date THEN 1 ELSE 0 END)
/ COUNT(*), 2)*100) AS immediate_percentage 
FROM delivery 
WHERE (customer_id,order_date) IN 
(
SELECT customer_id, min(order_date)
FROM delivery 
GROUP BY customer_id);
/* Ex2*/

/*Ex3*/ 
select id,
case when id%2 = 0 then (lag(student) over (order by id))
else ifnull(lead(student) over (order by id),student)
END as "student"
from Seat
/*Ex4*/ 
With CTE AS
(SELECT visited_on,
SUM(amount) amount
FROM Customer
GROUP BY visited_on)

SELECT visited_on, 
SUM(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING) amount, 
ROUND(AVG(amount)OVER (ORDER BY visited_on ROWS 6 PRECEDING),2) AS average_amount
FROM CTE 
ORDER BY visited_on
LIMIT 100 OFFSET 6;
