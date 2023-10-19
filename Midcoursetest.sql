-- Question 1:
SELECT DISTINCT (replacement_cost)
FROM film
GROUP BY film_id
ORDER BY replacement_cost ASC;
