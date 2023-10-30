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
SELECT COUNT(merchant_id) AS payment_count
FROM (
  SELECT
    transaction_id,
    merchant_id,
    credit_card_id,
    amount,
    transaction_timestamp,
    EXTRACT(EPOCH FROM (transaction_timestamp - LAG(transaction_timestamp) OVER (PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp)))/60 AS minute_difference
  FROM transactions
) AS subquery
WHERE minute_difference <= 10;
/*Ex7*/

SELECT category, product, total_spend
FROM 
(SELECT category, product, 
SUM(spend) AS total_spend, 
RANK()OVER ( PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking 
FROM product_spend 
WHERE EXTRACT(YEAR FROM transaction_date)=2022
GROUP BY category, product) AS subquery
WHERE ranking<=2
ORDER BY category, ranking;

/*eX8*/

With top_10_song AS
(SELECT artists.artist_name, 
DENSE_RANK() OVER(ORDER BY COUNT(songs.song_id) DESC) AS artist_rank 
FROM artists
INNER JOIN songs
ON artists.artist_id=songs.artist_id 
INNER JOIN global_song_rank AS ranking
ON songs.song_id= ranking.song_id
WHERE ranking.rank<=10
GROUP BY artists.artist_name
)
SELECT artist_name, artist_rank 
FROM top_10_song 
WHERE artist_rank <=5;
