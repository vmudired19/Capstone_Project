-- Skills in demand

with skills_demand as(
SELECT 
skills_job_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.job_id) AS demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id =skills_dim.skill_id
where job_title_short='Data Analyst'
and salary_year_avg is not null
GROUP BY skills_job_dim.skill_id,skills_dim.skills
), average_sal as(
SELECT 
skills_job_dim.skill_id,
skills_dim.skills,
round(avg(salary_year_avg),2) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id =skills_dim.skill_id
where job_title_short='Data Analyst'
and salary_year_avg is not null
GROUP BY skills_job_dim.skill_id,skills_dim.skills
)



SELECT
skills_demand.skill_id,
skills_demand.skills,
demand_count,
avg_salary
from
skills_demand
inner join average_sal on skills_demand.skill_id= average_sal.skill_id
WHERE
demand_count >10
ORDER BY demand_count DESC;
