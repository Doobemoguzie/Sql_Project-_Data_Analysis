/*
Question: What are top in-demand skills employers look for in data analyst?
- Uncover the top 5 most valuable skills for a data analyst
- Why? It extracts the top 5 most sought-after skills in the job market,
    helping job seekers identify the most sought-after abilities
*/

SELECT 
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS count_of_skills
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skill_name
ORDER BY
    count_of_skills DESC
LIMIT 5;

    

