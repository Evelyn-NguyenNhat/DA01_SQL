/**EX1**/ 
SELECT count(distinct company_id) AS duplicate_companies 
FROM (
SELECT company_id, title, description,
COUNT(job_id) AS job_numbers
FROM job_listings 
GROUP BY company_id, title, description
HAVING COUNT(job_id)>1
) AS sunquery;
