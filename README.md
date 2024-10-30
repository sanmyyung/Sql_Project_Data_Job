# Introduction
In this project, we focus on data analyst roles to uncover insights that can benefit job seekers and organizations. By examining job postings from 2023, we aim to highlight top-paying positions, essential skills for high-rating jobs, in-demand competencies, and optimal skills for career development in data analysis.
# Background
The job market for data analysts continues to grow, driven by the demand for data-driven decision-making across various sectors. This study analyzes job postings to answer the following key questions:

What are the top-paying data analyst jobs?
What skills are required for high-rating data analyst roles?
What are the most in-demand skills in data analysis?
What skills command the highest salaries?
What are the most optimal skills to learn based on demand and salary?

# Tools Used 
The analysis is powered by PostgreSQL, VS Code, git and SQL queries, with results processed into visual insights and recommendations.

# The Analysis
 ### Top-Paying Data Analyst Jobs
 
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

### Skills Required for High-Rating Data Analyst Jobs

High-rating roles often require a specialized skill set. Key skills include SQL, Python, and R, along with advanced tools like Databricks and Azure. These skills are frequently associated with the top-rated roles in data analysis, as represented in the bar chart.

![](https://github.com/sanmyyung/Sql_Project_Data_Job/blob/main/output%20(1).png)

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
### Most In-Demand Skills

Based on demand counts, the top in-demand skills include SQL, Excel, Python, and Tableau, as shown in the table provided. These skills are fundamental across data roles, underscoring their importance for job seekers aiming to stay competitive.

|Skills| Demand count|
|------|--------|
|SQL   |92628   |
|Excel | 67031  |
|python| 57326  |
|tableau| 46554 |
|power bi| 39468|
| r     | 30075 |
| sas   | 28068 |
| powerpoint| 13848 |

```
SELECT
    skills,
    count(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 10
```
### Top-Paying Skills Based on Salary

Top-paying skills, as shown in the table, include SVN, Solidity, Couchbase, and Golang. These skills command significant salaries, making them attractive for those seeking higher income within data-related fields.

|Skills| salary avg |
|------|--------|
|svn   |400000   |
|solidity | 179000  |
|couchbase| 160515 |
|dadarobot| 155486 |
|golang| 155000|
| mxnet    | 149000 |
| dplyr   | 147633 |
| vmware| 147500 |

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

### Optimal Skills to Learn

The optimal skills to learn balance both demand and salary, with skills like Python, R, and SAS emerging as highly valuable. These skills offer competitive salaries while remaining in high demand, as demonstrated in the final table

|Skills| Demand count|Salary_avg|
|------|--------|---------------|
|python   |236   | 101397       |
|tableau | 230  |99288          |    
|r     | 148    | 100499         |
|sas   | 63    | 98902           |
|looker| 49    | 103795         |
| snowflake   | 37| 112948      |
| oracle  | 37 | 112948         |
| sql server| 35 | 97786      |

```
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg),0) as salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg is NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
having 
    count(skills_job_dim.job_id) > 10
ORDER BY
    salary_avg DESC,
    demand_count DESC
LIMIT 25
```

# Recommendation
* Skill Development: Focus on learning high-demand and high-salary skills, notably SQL, Python, R, and Tableau, which are vital for competitive positioning in data analysis roles.
* Specialization: For those targeting top-paying jobs, developing advanced technical proficiencies in tools like Databricks, Azure, and database management systems (such as Couchbase) can lead to substantial income opportunities.
* Market Awareness: Keeping abreast of shifts in in-demand skills and emerging technologies, like Golang and Solidity, can provide a strategic advantage.
  
# Conclusion
The analysis of 2023 data analyst job postings reveals that while foundational skills like SQL and Python remain essential, specialization in advanced tools and languages can significantly impact salary potential and employability. This study provides actionable insights for data analysts looking to optimize their skillset based on market demand and salary prospects.
