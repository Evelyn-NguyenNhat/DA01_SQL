/**EX1**/ 
SELECT count(distinct company_id) AS duplicate_companies 
FROM (
SELECT company_id, title, description,
COUNT(job_id) AS job_numbers
FROM job_listings 
GROUP BY company_id, title, description
HAVING COUNT(job_id)>1
) AS subquery;
/** EX2**/ 
SELECT category, product, total_spend
FROM 
(SELECT category, product, 
SUM(spend) AS total_spend, 
RANK()OVER (
    PARTITION BY category
    ORDER BY SUM(spend) DESC) AS ranking 
    FROM product_spend 
    WHERE EXTRACT(YEAR FROM transaction_date)=2022
    GROUP BY category, product ) AS subquery
WHERE ranking<=2
ORDER BY category, ranking;
/** Ex3 **/ 
SELECT COUNT(policy_holder_id) AS member_count
FROM
(
SELECT policy_holder_id, 
COUNT(case_id) AS count
GROUP BY policy_holder_id
HAVING COUNT(case_id)>=3 ) AS subquery;
/** Ex4**/ 
SELECT page_id 
FROM pages
WHERE page_id NOT IN 
(SELECT page_id 
FROM page_likes 
WHERE page_likes.page_id=pages.page_id
)
/** EX5 **/ 
with prev_month AS
(SELECT user_id,extract(month from event_date) as month,event_id FROM user_actions
where event_type in ('sign-in', 'like', 'comment')
and extract(month from event_date)=6 
and extract(year from event_date)=2022
),
 current_month AS
(SELECT user_id,extract(month from event_date) as month,event_id FROM user_actions
where event_type in ('sign-in', 'like', 'comment')
and extract(month from event_date)=7
and extract(year from event_date)=2022
)
select c.month,count(DISTINCT c.user_id) from current_month c
join prev_month P 
on p.user_id=c.user_id
group by c.month

/** ex6 **/ 
select
date_format(trans_date, '%Y-%m') AS month,
country,
count(trans_date) as trans_count,
sum(amount) as trans_total_amount,
sum(state = 'approved') as approved_count,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by DATE_FORMAT(trans_date, '%Y-%m'), country
/** ex7 **/ 
Select b.product_id, min(year) as first_year,a.quantity,a.price
from sales as a
left join product as b
on a.product_id=b.product_id
group by product_id
/** ex8 **/ 
SELECT DISTINCT a.customer_id
FROM customer AS a
WHERE a.customer_id IN (
    SELECT a.customer_id
    FROM customer AS a
    JOIN product AS b ON a.product_key = b.product_key
    GROUP BY a.customer_id
    HAVING COUNT(DISTINCT a.product_key) = (SELECT COUNT(DISTINCT product_key) FROM product)
);
/** Ex9 **/ 
SELECT employee_id 
FROM employees 
WHERE salary <30000
AND manager_id IS NOT NULL 
AND manager_id NOT IN (SELECT employee_id FROM Employees)
/**ex11**/ 
(SELECT a.name AS results
FROM users AS a
JOIN MovieRating AS b 
ON a.user_id=b.user_id
GROUP BY 1
ORDER BY COUNT(rating) DESC, 1 ASC
LIMIT 1
)
UNION 
(
    SELECT title AS results
    FROM movies 
    JOIN MovieRating 
    ON movies.movie_id= MovieRating.movie_id 
    WHERE EXTRACT(MONTH FROM created_at)=2
    GROUP BY 1
    ORDER BY AVG(rating) DESC, 1 ASC
    LIMIT 1
)
/** Ex12**/ 
SELECT id, SUM(num) AS num
FROM (
  SELECT accepter_id AS id, COUNT(requester_id) AS num 
  FROM RequestAccepted
  GROUP BY accepter_id
  UNION ALL
  SELECT requester_id AS id, COUNT(accepter_id) AS num 
  FROM RequestAccepted
  GROUP BY requester_id) AS subquery
GROUP BY id
ORDER BY SUM(num) DESC 
LIMIT 1
