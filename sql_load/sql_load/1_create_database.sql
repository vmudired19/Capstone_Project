-- -- select 
-- -- count(job_id) as id,
-- -- EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
-- -- EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS year
-- -- from 
-- -- job_postings_fact
-- -- WHERE
-- -- job_posted_date >= '2023-01-01'
-- -- and job_posted_date <'2024-01-01'
-- -- GROUP BY year, month ;
-- -- CREATE table january_jobs as
-- --     SELECT * 
-- --     FROM job_postings_fact
-- --     where 
-- --     EXTRACT(MONTH from job_posted_date) =1
-- --     ;

-- -- CREATE table feb_jobs as
-- -- select * 
-- -- from job_postings_fact
-- -- where EXTRACT(month from job_posted_date)=2
-- -- ;

-- -- CREATE table march_jobs as
-- -- select * 
-- -- from job_postings_fact
-- -- where EXTRACT(month from job_posted_date)=3
-- -- ;

-- -- select * from march_jobs;

-- --  CAse Function
-- -- SELECT
-- -- count(job_id) as number_of_jobs,

-- -- CASE
-- --     when job_location ='Anywhere' then 'Remote'
-- --     when job_location = 'New York, NY' then 'Local'
-- --     else  'Onsite'
-- -- end as location_category 
-- -- from job_postings_fact
-- -- WHERE
-- -- job_title_short = 'Data Analyst'
-- -- GROUP by location_category
-- -- ORDER BY location_category ASC;

-- --   Problem solution
-- -- SELECT
-- --   job_title_short,
-- --   CASE
-- --     WHEN salary_year_avg BETWEEN 300000 AND 650000 THEN 'High'
-- --     WHEN salary_year_avg BETWEEN 100000 AND 299999 THEN 'Standard'
-- --     ELSE 'Low'
-- --   END AS salary,
-- --  CASE
-- --     WHEN salary_year_avg BETWEEN 300000 AND 650000 THEN 3
-- --     WHEN salary_year_avg BETWEEN 100000 AND 299999 THEN 2
-- --     ELSE 1
-- --   END AS salary_order
-- -- FROM job_postings_fact
-- -- WHERE job_title_short = 'Data Analyst'
-- -- GROUP BY job_title_short, salary
-- -- ORDER BY salary_order DESC;


-- -- subquries and ctes
-- select * from(select * from job_postings_fact
-- WHERE EXTRACT(month from job_posted_date)=1
-- )as january_jobs; 

-- -- Common table extensions

-- with january_jobs as(select * from job_postings_fact
-- WHERE EXTRACT(month from job_posted_date)=1
-- )
-- select * from january_jobs;

-- -- Example fro the sub query

-- select 
-- company_id,
-- name as company_name
-- from company_dim
-- where company_id in(
--     select company_id

--     from job_postings_fact
--     where job_no_degree_mention = true
--     order BY company_id
-- )


-- --  CTE's

-- with company_job_count as(
-- select
-- company_id,
-- count(*) as total_jobs

-- from job_postings_fact
-- GROUP BY company_id)

-- select 
-- company_dim.name as company_name,
-- company_job_count.total_jobs 
-- from company_dim
-- left join company_job_count on company_job_count.company_id = company_dim.company_id
-- ORDER BY total_jobs;

-- -- problem

-- -- select skills_dim.skills, aggregation.skill_count
-- -- from(
-- -- select skill_id,
-- -- count(skill_id) as skill_count
-- -- from skills_job_dim
-- -- GROUP BY skill_id
-- -- ) as aggregation
-- -- left join skills_dim 
-- -- on aggregation.skill_id = skills_dim.skill_id
-- -- ORDER BY aggregation.skill_count desc
-- -- limit 5;



-- with job_count AS(
-- SELECT
-- company_id,
-- count(*) as total_jobs
-- from job_postings_fact
-- group by company_id
-- )

-- select 
-- company_id,
-- total_jobs,
-- CASE
--     when total_jobs >50 then 'Large'
--     when total_jobs between 10 and 50 then 'Medium'
--     else 'Small'
-- end as job_space

-- from (
--     SELECT
-- company_id,
-- count(*) as total_jobs
-- from job_postings_fact
-- group by company_id
-- ) as job_count


--  PRactice problem
-- with remote_job_skills as(
--     SELECT
--     skill_id,
--     count(*) as skill_count
--     from 
--     skills_job_dim as skill_to_job
--     INNER JOIN 
--     job_postings_fact as job_postings on job_postings.job_id = skill_to_job.job_id
--     where 
    
--     job_postings.job_work_from_home =TRUE
--     and job_postings.job_title_short = 'Data Analyst'
--     GROUP BY skill_id

-- )

-- select 
-- skill.skill_id,
-- skills as skill_name,
-- skill_count
-- from
-- skills_dim as skill
-- inner join remote_job_skills as r_jobs on 
-- skill.skill_id = r_jobs.skill_id
-- order by skill_count DESC
-- limit 5
-- ;
select 
job_title_short
job_location,
job_via,
job_posted_date::date,
salary_year_avg
from(
SELECT
*
from january_jobs

UNION all

SELECT
*
from feb_jobs
)
as quater_1_job_postings
WHERE
quater_1_job_postings.salary_year_avg > 70000
order BY salary_year_avg desc