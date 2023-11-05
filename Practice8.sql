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
