# Introduction
📊Delve into the job market! Focusing on remote data analyst opportunities, this project examines the 💰 highest-paying roles, key skills employers want, and the 📈 sweet spot where demand and salary intersect. 

🔍SQL queries? Look them up here: 
[Project_SQL folder](/Project%20_SQL/)


# Background
### Data Analyst Job Market Explorer | SQL Project  
**Motivation:** Developed to optimize job search efficiency by analyzing high-value opportunities in the remote data analytics field.  
**Key Deliverables:**  
- Identified top-paying roles and salary trends using SQL-driven insights.  
- Mapped in-demand technical skills (SQL, Python, Tableau) to prioritize upskilling.  
- Pinpointed geographic hotspots and remote opportunities with premium compensation.  

**Data Source:** Leveraged proprietary SQL course dataset (job postings, salaries, locations) to derive actionable trends.  

**Impact:** Streamlines job market navigation for data professionals by surfacing optimal career pathways

**Data Analyst Job Market Analysis** | SQL Project  
- Conducted comprehensive salary analysis to identify top paying data analyst roles   
- Extracted and quantified high-value skills (SQL, Python, Tableau) correlated with salary premiums  
- Mapped industry demand trends, revealing top 5 most requested technical skills 
- Salary premiums associated with specific compentencies  
- Processed and analyzed 10,000+ job postings dataset using advanced SQL queries  

# Tools I Used

**Technical Approach:**
- **SQL & PostgreSQL:** Engineered complex queries to analyze 10,000+ job postings, extracting salary trends and skill demand patterns
- **Visual Studio Code:** Developed and optimized SQL scripts in a robust IDE environment
- **Git/GitHub:** Implemented version control for all analysis code, enabling collaborative review and reproducibility
- **Excel/Sheets:** Supplemented SQL analysis with data visualization of key findings

# The Analysis

"In this project, I designed targeted queries to analyze key trends and requirements in the data analyst job market. For each question, I employed a structured analytical approach to derive actionable insights."

### 1. Top-Paying Data Analyst Jobs  
Identified the highest-paying roles by analyzing average annual salaries and location data, with a focus on remote opportunities. This research highlights the most lucrative positions in the field.

```sql
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
    job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Researched and categorized 2023’s most sought-after data analyst positions:

1. **Wide Salary Scale:** The highest-paying data analyst positions offer salaries between $184,000 and $650,000, showcasing strong earning potential in the industry.

2. **Diverse Workplace:** Firms such as SmartAsset, Meta, and AT&T provide some of the highest salaries, reflecting widespread demand across diverse sectors.

3. **Job Title Diversity:** Data analytics encompasses a broad spectrum of job titles, including Data Analyst and Director of Analytics, indicating diverse roles and focus areas.

![alt text](<Top paying salaries.png>)

*"This bar graph visualizes the highest 10 salaries for data analysts, generated in Excel using my SQL data."*


### 2. Skills for Top Paying Jobs
Analyzed job postings alongside skills data to identify key competencies required for top-paying roles, revealing employer priorities for high-compensation positions.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)

SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills AS skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Breakdown of the most sought-after skills for the highest-paying data analyst positions (2023):

- SQL (8/10 roles)  
- Python (7)  
- Tableau (6)  
- R, Snowflake, Pandas, Excel (recurring demand)

**Technical Skills:** SQL (80% prevalence), Python (70%), Tableau (60%), R, Snowflake, Pandas, Excel

![*"Bar graph illustrating skill frequency across top 10 highest-paying data analyst roles, generated from SQL query results using Excel."*](<Top 10 skills paying job skills.png>)

"*Bar graph illustrating skill frequency across top 10 highest-paying data analyst roles, generated from my SQL query results using Excel.*"

### 3. In-Demand Skills for Data Analyst
Conducted comprehensive analysis of job posting data to identify and prioritize the most frequently requested skills for Data Analyst positions, enabling strategic alignment with high-demand competencies and optimizing focus for skill development and recruitment efforts.

```sql
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
```

Demonstrated expertise in SQL and Excel for efficient data processing, cleaning, and analysis, ensuring accuracy in large datasets, while leveraging advanced spreadsheet functions, pivot tables, and macros to streamline workflows. Additionally, proficient in programming (Python) for automation, statistical analysis, and predictive modeling, combined with powerful data visualization tools like Tableau and Power BI to transform complex data into actionable insights, enhancing data-driven decision-making and storytelling for stakeholders.

| Skill   | Count   |
|---------|--------:|
| Sql     | 7,291   |
| Excel   | 4,611   |
| Python  | 4,330   |
| Tableau | 3,745   |
| Power Bi| 2,609   |

*Analyzed top 5 in-demand data analyst skills from job postings, including [SQL, Python, etc.].*

### 4.Top Skills Based on Salary
Conducted data-driven analysis of industry salary trends to evaluate compensation across various skill sets, identifying the highest-paying competencies to inform career development and strategic upskilling decisions.

```sql
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
LIMIT 10;
```
Analysis of highest-paying skills for Data Analysts:

- Proficiency in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy) is highly valued in the industry, with top salaries reflecting the demand for advanced data processing and predictive modeling expertise.

- Proficient in software development and deployment tools (GitLab, Kubernetes, Airflow), enabling automation and efficient data pipeline management—bridging data analysis and engineering for scalable solutions.

- **Cloud Computing Proficiency:** Skilled in cloud and data engineering tools (Elasticsearch, Databricks, GCP), leveraging cloud-based analytics to enhance data-driven decision-making and maximize career growth in data analytics.

| Skill Name    | Average Salary ($) |
|---------------|-------------------:|
| Pyspark       |            208,172 |
| Bitbucket     |            189,155 |
| Watson        |            160,515 |
| Couchbase     |            160,515 |
| Datarobot     |            155,486 |
| Gitlab        |            154,500 |
| Swift         |            153,750 |
| Jupyter       |            152,777 |
| Pandas        |            151,821 |
| Elasticsearch |            145,000 |
*Summary of average salaries for the top 10 highest-paying data analyst skills.*

### 5. Most Optimal Skills to Learn

By analyzing labor market trends, demand indicators, and salary data, this research project identified high-value skills that align with industry growth and earning potential, enabling data-driven decision-making for targeted skill development and career advancement

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS count_of_skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
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
HAVING
    COUNT(skills_job_dim.job_id) >10
ORDER BY
    average_salary DESC,
    count_of_skills DESC
LIMIT
    30;
```
*Ranking of High-Value Data Analyst Skills by Salary*

| ID  | Skill      | Count | Salary ($) |
|-----|------------|------:|-----------:|
| 8   | Go         | 27    | 115,320    |
| 234 | Confluence | 11    | 114,210    |
| 97  | Hadoop     | 22    | 113,193    |
| 80  | Snowflake  | 37    | 112,948    |
| 74  | Azure      | 34    | 111,225    |
| 77  | Bigquery   | 13    | 109,654    |
| 76  | Aws        | 32    | 108,317    |
| 4   | Java       | 17    | 106,906    |
| 194 | Ssis       | 12    | 106,683    |
| 233 | Jira       | 20    | 104,918    |

2023 Optimal Data Analyst Skills Breakdown:

- **1.  High-Demand Cloud & Data Skills**

Key Insight: Cloud platforms and data tools command top salaries despite varying demand.
Notable Example:

Snowflake (37 job mentions, $112,948 avg) leads in adoption for modern data warehousing.

- **2. Emerging vs. Legacy Tech Trends**

Key Insight: Modern tools (Go, Snowflake) outearn legacy systems (SSIS, Jira).
Comparison:

Go (27, $115,320) leads in salary for newer backend/DevOps roles.

SSIS (12, $106,683) and Jira (20, $104,918) are stable but lower-growth.

- **3. The Big Data Salary Premium**

Key Insight: Hadoop (22, $113,193) still outearns general-purpose tools (Java, AWS).
Context:
While Hadoop’s count is modest, its salary reflects specialized data engineering needs.

# What I Learned

During this experience, I significantly expanded and enhanced my SQL skills, mastering advanced techniques and tools:

- **Advanced SQL Query Development:** Expertise in writing complex SQL queries, including multi-table joins and leveraging Common Table Expressions (CTEs) for optimized temporary table operations.

- **Data Aggregation & Analysis:** Proficient in using GROUP BY and aggregate functions (COUNT(), SUM(), AVG()) to efficiently summarize and analyze large datasets."

- **Advanced Analytical Problem-Solving:** Transformed complex business questions into actionable insights through strategic SQL query development and data analysis.

# Conclusion

## Comprehension

From the analysis, lots of perceptive were procurred:

1. **Highlighting Industry Trends:** The highest-paying remote Data Analyst roles command competitive salaries, with top-tier positions offering compensation packages exceeding $650,000 annually. These opportunities often require advanced expertise in data modeling, machine learning, and business intelligence.

2. **High-Income Career Skills:** Mastery of SQL is a key requirement for high-paying Data Analyst roles, with top-tier positions prioritizing this skill for complex data querying and analysis.

3. **Most Sought-After Skills:** SQL is the most critical competency in the field per industry demand trends—paired with Python and Tableau proficiency. Proven ability to leverage SQL for extracting actionable insights, automating reports, and driving cost-saving decisions, aligning with top employers’ requirements for high-salary roles.

4. **Skills That Command Higher Pay:** Data Analysts with expertise in premium-compensation technologies including PySpark (for large-scale data processing), Bitbucket (for enterprise-grade version control), and Couchbase (for distributed database solutions) - skillsets commanding 30%+ salary premiums in the current market

5. **Skills That Boost Market Worth:** SQL consistently ranking as the most in-demand skill for data analysts and commanding premium salaries, mastering it delivers exceptional ROI for career advancement.

## Final Takeway

Working on this project strengthened my SQL abilities and deepened my understanding of the data analyst job market. The insights gained from the analysis offer a roadmap for focusing on key skills and optimizing job search strategies. By targeting high-demand, high-paying competencies, aspiring data analysts can gain a competitive edge. This experience underscores the need for ongoing learning and staying attuned to evolving trends in data analytics.
