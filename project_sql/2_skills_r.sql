--  Finding the skills required for the top paying jobs
with top_paying_job as (


SELECT
job_id,
job_title,
salary_year_avg,
name company_name
from 
job_postings_fact
left JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
where 
job_title_short = 'Data Analyst' and 
salary_year_avg is not NULL

ORDER BY salary_year_avg DESC
limit 10
) 
SELECT 
top_paying_job.*,
skills
from top_paying_job
inner join skills_job_dim on top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id =skills_dim.skill_id
order BY salary_year_avg desc;
