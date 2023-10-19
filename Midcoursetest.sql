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

