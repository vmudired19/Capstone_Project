/*
Q: find out the top paying jobs data analyst jobs
*/

SELECT
job_id,
job_title,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
name company_name
from 
job_postings_fact
left JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
where 
job_title_short = 'Data Analyst' and 
job_location ='Anywhere'and salary_year_avg is not NULL

ORDER BY salary_year_avg DESC
limit 10
;
