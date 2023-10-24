/**EX1**/ 
SELECT count(distinct company_id) AS duplicate_companies 
FROM (
SELECT company_id, title, description,
COUNT(job_id) AS job_numbers
FROM job_listings 
GROUP BY company_id, title, description
HAVING COUNT(job_id)>1
) AS sunquery;
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
