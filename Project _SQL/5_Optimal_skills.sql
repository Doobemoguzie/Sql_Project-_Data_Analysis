/*
Question: What are the most valuable skills(i.e has higher income and higher salary).
- Why? Because it highlights skills that are in demand(job security) and pays well,
    delivering strategic value for data analytic growth.
*/

WITH skills_in_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS count_of_skills
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), typical_earnings AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)
SELECT
    typical_earnings.skill_id,
    typical_earnings.skills,
    count_of_skills,
    average_salary
FROM
    typical_earnings
INNER JOIN skills_in_demand ON skills_in_demand.skill_id = typical_earnings.skill_id
ORDER BY
    count_of_skills DESC,
    average_salary DESC
LIMIT
    30;



    


