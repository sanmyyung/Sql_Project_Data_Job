/*
Question: what are the top_paying data analyst jobs?
    Identify the top 10 highest paying Data Analyst roles that are available rmotely.
    Focuses on job postings with specified salaries(remove null)
    why? Highlights the to paying opportuniteies for Data Analyst, offering insights into employment
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
from
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10