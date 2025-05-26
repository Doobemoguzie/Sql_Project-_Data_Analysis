/*
Question? Which skills attracts the highest salaries?
- Maps the relationship between particular skills and their corresponding salary ranges.
- Analyzes only roles that specifies salaries with location removed as a factor.
- Why? It shows which data analyst skills have the strongest salary influence,
    highlighting the most profitable areas for skill developmeny.
*/

SELECT 
    skills_dim.skills AS skill_name,
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
    skill_name
ORDER BY
    average_salary DESC
LIMIT 30;