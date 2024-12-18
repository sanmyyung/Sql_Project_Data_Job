/*
Question: What skills are required for the top_pating data Analyst jobs
    - use the top 10 highest_payinn Data Analyst jobs from first query
    - add the specific skills required for these roles
*/




with top_paying_job AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
)
select 
    top_paying_job.*,
    skills
from top_paying_job
INNER JOIN skills_job_dim on top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
