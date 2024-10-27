/*
Question: What are the top paying skils based on salary
*/

SELECT
    skills,
    round(avg(salary_year_avg),0) as salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg is NOT NULL
GROUP BY
    skills
ORDER BY 
    salary_avg DESC