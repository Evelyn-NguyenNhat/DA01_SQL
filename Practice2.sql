/*EX1 */ 
SELECT DISTINCT CITY 
FROM STATION
WHERE ID%2-0;
/*EX2*/ 
SELECT COUNT(CITY)-COUNT(DISTINCT CITY) AS DIFFERENCE
FROM STATION;
/*ex3 */
SELECT CEIL(AVG(salary)-AVG(REPLACE(Salary, '0', ' ')))
FROM EMPLOYEES
/*ex4*/
SELECT 
ROUND(SUM(item_count::DECIMAL*order_occurrences) /SUM(order_occurrences) ,1) AS mean
FROM items_per_order;
/*ex5: Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.*/
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

/*ex6: Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s 
first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.*/
SELECT user_id, 
DATE(MAX(post_date))-DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date>='2021-01-01' AND post_date<'2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id)>=2;

/*ex7: Write a query that outputs the name of each credit card and the difference in the number of issued cards between the
month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity.*/
SELECT card_name, 
(MAX(issued_amount)- MIN(issued_amount)) as difference_value
FROM monthly_cards_issued 
GROUP BY card_name
ORDER BY difference_value DESC;
/*ex8: Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.*/
SELECT manufacturer, 
COUNT(drug) AS drug_count,
ABS(SUM(cogs-total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales< cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;

/*ex9: Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.*/
SELECT* FROM cinema
WHERE id%2=1 AND description != 'boring'
ORDER BY rating DESC
/*ex10: Write a solution to calculate the number of unique subjects each teacher teaches in the university.
Return the result table in any order. */
SELECT teacher_id, COUNT(DISTINCT (subject_id)) AS cnt
FROM Teacher
GROUP BY teacher_id;
/*ex11: Write a solution that will, for each user, return the number of followers.
Return the result table ordered by user_id in ascending order. */
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id


/* ex12: Write a solution to find all the classes that have at least five students.
Return the result table in any order. */
SELECT class
FROM Courses 
GROUP BY class
HAVING COUNT(student)>=5;
