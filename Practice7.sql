/*ex1*/ 
SELECT 
  EXTRACT(year FROM transaction_date) AS year, 
  product_id, 
  spend AS curr_year_spend,
  LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend,
  ROUND(100 * (spend - LAG(spend) OVER (PARTITION BY product_id ORDER BY
  product_id, EXTRACT(YEAR FROM transaction_date)))
  / LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id,
  EXTRACT(YEAR FROM transaction_date)), 2) AS yoy_rate
FROM user_transactions;
/*ex2*/
SELECT DISTINCT
  card_name,
  FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month)
  AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC
/*ex3*/ 
SELECT user_id, spend, transaction_date FROM
(SELECT user_id, spend, transaction_date,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS num
FROM transactions ) AS subquery
WHERE num=3;
/*ex4*/ 
SELECT transaction_date,user_id,COUNT(transaction_date) purchase_count
FROM(SELECT *,
    RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
    FROM user_transactions
    ORDER BY user_id,transaction_date DESC) a
WHERE rank = 1
GROUP BY user_id,transaction_date
ORDER BY transaction_date
/*ex5*/ 
SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;
/*ex6*/ 
