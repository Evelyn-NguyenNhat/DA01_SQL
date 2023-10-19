-- Question 1:
SELECT DISTINCT (replacement_cost)
FROM film
GROUP BY film_id
ORDER BY replacement_cost ASC;
--Question 2: 
SELECT 
    CASE 
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
        WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
        ELSE 'unknown'
    END AS category, 
    COUNT(*) AS film_count
FROM film
GROUP BY category
ORDER BY film_count DESC;
-- Question 3: 
SELECT a.title, a.length, c.name
FROM film AS a
INNER JOIN film_category AS b 
ON a.film_id= b.film_id
INNER JOIN category AS c
ON b.category_id= c.category_id
WHERE c.name='Drama' OR c.name='Sports'
ORDER BY length DESC;

-- Question 4:
SELECT c.name AS category, COUNT(*)
FROM film AS a
INNER JOIN film_category AS b 
ON a.film_id=b.film_id
INNER JOIN category AS c
ON b.category_id=c.category_id
GROUP BY category
ORDER BY COUNT DESC;
-- Question 5:
SELECT a.first_name, a.last_name, COUNT(b.film_id) AS SOLUONG
FROM actor AS a
INNER JOIN film_actor AS b 
ON a.actor_id=b.actor_id 
GROUP BY a.first_name, a.last_name
ORDER BY SOLUONG DESC;
-- Question 6: 
SELECT COUNT (a.address_id)
FROM address AS a
LEFT JOIN customer AS b 
ON a.address_id=b.address_id
WHERE b.address_id IS NULL;
-- Question 7: 
SELECT b.city AS name_city, SUM(e.amount) AS doanhthu
FROM country AS a
INNER JOIN city AS b
ON a.country_id =b.country_id
INNER JOIN address AS c
ON b.city_id=c.city_id
INNER JOIN customer AS d
ON c.address_id=d.address_id
INNER JOIN payment AS e
ON d.customer_id= e.customer_id
GROUP BY name_city
ORDER BY doanhthu DESC;

-- Question 8: 
SELECT b.city AS name_city, SUM(e.amount) AS doanhthu
FROM country AS a
INNER JOIN city AS b
ON a.country_id =b.country_id
INNER JOIN address AS c
ON b.city_id=c.city_id
INNER JOIN customer AS d
ON c.address_id=d.address_id
INNER JOIN payment AS e
ON d.customer_id= e.customer_id
GROUP BY name_city
ORDER BY doanhthu DESC;
