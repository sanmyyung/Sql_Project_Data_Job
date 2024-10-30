# Introduction
In this project, we investigate job postings from 2023, focusing on data analyst roles to uncover valuable insights that can guide job seekers and organizations alike. The analysis aims to shed light on top-paying positions, critical skills for high-rating jobs, in-demand competencies, and optimal skills to learn.
# Background
The job market for data analysts continues to grow, driven by the demand for data-driven decision-making across various sectors. This study analyzes job postings to answer the following key questions:

What are the top-paying data analyst jobs?
What skills are required for high-rating data analyst roles?
What are the most in-demand skills in data analysis?
What skills command the highest salaries?
What are the most optimal skills to learn based on demand and salary?

# Tools Used 
The analysis is powered by PostgreSQL, VS Code, git and SQL queries, with results processed into visual insights and recommendations.

|Skills| Demand |
|------|--------|
|SQL   |7291    |
| Excel| 4611  |
# The Analysis
 Top-Paying Data Analyst Jobs
 
![](https://github.com/sanmyyung/Sql_Project_Data_Job/blob/main/output.png)

The top-paying data analyst roles were identified by analyzing average annual salaries across job titles. The highest-paying positions include roles like Director of Analytics and Associate Director roles, with salaries up to 650,000. A bar chart provides a visualization of these top-paying positions, showing clear peaks for high-salary roles.

```
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
```

Skills Required for High-Rating Data Analyst Jobs

High-rating roles often require a specialized skill set. Key skills include SQL, Python, and R, along with advanced tools like Databricks and Azure. These skills are frequently associated with the top-rated roles in data analysis, as represented in the bar chart.

![]()







```
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
```
# Recommendation

# Conclusion
