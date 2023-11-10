-- PHẦN 1
---1. Số lượng đơn hàng và số lượng khách hàng mỗi tháng
SELECT COUNT(DISTINCT user_id), COUNT(order_id), FORMAT_DATE('%Y-%m', DATE (created_at)) as month_year,
FROM  bigquery-public-data.thelook_ecommerce.order_items
WHERE created_at >= '2019-01-01' AND created_at <='2022-04-30'
GROUP BY 3
ORDER BY 3;
---2 Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
SELECT COUNT(DISTINCT user_id) AS distinct_users, 
SUM(sale_price)/COUNT(order_id) AS average_order_value, FORMAT_DATE('%Y-%m', DATE (created_at)) as month_year
FROM  bigquery-public-data.thelook_ecommerce.order_items
WHERE created_at>='2019-01-01' AND created_at<= '2022-04-30'
GROUP BY 3
ORDER BY 3;
--3  Nhóm khách hàng theo độ tuổi
WITH twt_cte AS (SELECT
first_name,
last_name,
gender,
MIN(age) OVER(PARTITION BY gender) AS youngest_age
FROM `bigquery-public-data.thelook_ecommerce.users` 
WHERE DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MIN(age) 
             FROM `bigquery-public-data.thelook_ecommerce.users`)
UNION ALL
SELECT
first_name,
last_name,
gender,
MAX(age) OVER(PARTITION BY gender) AS oldest_age
FROM `bigquery-public-data.thelook_ecommerce.users` 
WHERE DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-30'
AND age IN (SELECT MAX(age) 
             FROM `bigquery-public-data.thelook_ecommerce.users`)
ORDER BY youngest_age
)
SELECT 
  CASE
    WHEN youngest_age THEN 'Trẻ nhất'
    WHEN oldest_age THEN 'Lớn nhất'
    ELSE 'Không thuộc nhóm trẻ nhất hoặc lớn nhất'
  END AS tuoi,
  COUNT(*) AS so_luong, gender
FROM twt_cte
GROUP BY  youngest_age, oldest_age,gender;
-- 4. Top 5 sản phẩm mỗi tháng.
WITH monthly_profit AS (
  SELECT
    a.product_id,
    a.product_name,
    FORMAT_DATE('%m', DATE(a.created_at)) AS month,
    SUM(a.cost) AS cost,
    SUM(b.sale_price) AS sales,
    (SUM(b.sale_price) - SUM(a.cost)) AS profit
  FROM bigquery-public-data.thelook_ecommerce.inventory_items AS a
  INNER JOIN bigquery-public-data.thelook_ecommerce.order_items AS b 
  ON a.product_id = b.product_id
  GROUP BY month, a.product_id, a.product_name
), 
ranked_profit AS
(
SELECT month, product_id, product_name, sales, 
cost, profit, 
DENSE_RANK() OVER(PARTITION BY month ORDER BY profit DESC) 
AS rank_per_month
FROM monthly_profit)
SELECT  month,
product_id, 
product_name, 
sales, 
cost, 
profit, 
rank_per_month
FROM ranked_profit
WHERE rank_per_month <=5
ORDER BY month, rank_per_month;

--5 Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục

SELECT 
FORMAT_DATE('%Y-%m-%d', DATE(b.created_at)) AS
date, a.category AS product_category, ROUND(SUM(b.sale_price),2) AS revenue
FROM bigquery-public-data.thelook_ecommerce.products AS a
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items AS b
ON a.id=b.id
WHERE FORMAT_DATE('%Y-%m-%d', DATE(b.created_at))>='2022-01-15' AND
FORMAT_DATE('%Y-%m-%d', DATE(b.created_at)) <='2022-04-15'
GROUP BY date,product_category
ORDER BY date, product_category;
