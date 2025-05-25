/*
Questions: What are the top paying Data Analyst Jobs?
- Determining the top 10 best paid remote data analyst position available.
- Filters job posting to only include those with salary information(excludes null values).
- Why focus here? To reveal top-tier Data Analyst salaries and their work arrangment possibilities.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date :: DATE,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_country = 'United States' AND
    job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;




