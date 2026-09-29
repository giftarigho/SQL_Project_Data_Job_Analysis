# Introduction

📊 This project explores the Data Analyst job market, focusing on **top-paying roles, in-demand skills, and where high demand meets high salary**.

Using SQL, I analyzed job-market data to uncover valuable insights that can help aspiring Data Analysts understand which skills and opportunities are most relevant in today's market. 🚀🔥

🔎 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

The data analytics field continues to evolve, with new roles, skills, and salary opportunities emerging across the industry. This project explores the current data analyst job market to understand what employers are looking for and how different skills relate to salary levels.

Using SQL, I analyzed job postings to identify the highest-paying data analyst roles, the skills associated with them, the most in-demand skills, and the skills linked to higher salaries. The goal is to turn raw job-market data into practical insights that can help aspiring data analysts make smarter decisions about the skills they choose to develop.

### The questions i answered throughout my SQL queries are:

1. What are the highest-paying data analyst job roles?

2. What skills are required for the highest-paying data analyst roles?

3. Which skills are most in demand for data analysts?

4. Which skills are associated with higher salaries?

5. Which skills provide the most valuable learning opportunities for aspiring data analysts?

# 🛠️Tools I Used

- **SQL:** Used to query, clean, transform, and analyze the job-market data to answer the key research questions.

- **PostgreSQL:** Used as the relational database for storing and managing the dataset during the analysis.

- **Visual Studio Code:**  Used as the primary code editor for writing and managing the SQL scripts.

- **Git & GitHub:**  Used for version control, project organization, and documenting and sharing the completed analysis.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top paying roles](/assests/WhatsApp%20Image%202026-09-29%20at%2007.40.47.jpeg)
**Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results**

### 2. Skills for Top Paying Data Analyst Jobs

To identify the most commonly requested skills among the highest-paying Data Analyst jobs, I analyzed the skills associated with the top 10 paying positions. This helps highlight the technical skills that frequently appear in high-paying Data Analyst opportunities.

```sql
WITH top_paying_job AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
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

SELECT
    top_paying_job.*,
    skills
FROM 
    top_paying_job
INNER JOIN  
    skills_job_dim ON top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN  
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's is the breakdown for the top paying skill for data analyst jobs in 2023:

- **SQL:** Appears in 8 of the top 10 jobs, making it the most requested skill.

- **Python & Tableau:** Python appears in 7 jobs and Tableau in 6, showing strong demand for programming and visualization.

- **Diverse technical skills:** R, Snowflake, Pandas, Excel, Azure, and Power BI also appear, showing that high-paying roles require a mix of analytical and technical skills.

![Top paying skill](/assests/image.png)
**Bar graph visualizing the top 10 paying skills for data analysts; ChatGPT generated this graph from my SQL query results**

### 3. Most In-Demand Data Analyst Skills
To identify the most demanded skills, I analyzed the frequency of each skill across Data Analyst job postings in 2023. This highlights the core skills employers requested most often.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN  
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN  
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

Here's the breakdown for the most skill In-Demand:

- **SQL dominates:** SQL was the most demanded skill with 7,291 postings.

- **Excel remains highly relevant:** Excel ranked second with 4,611 postings, showing strong demand for spreadsheet skills.

- **Python & visualization:** Python (4,330) and Tableau (3,745) were also highly requested, while Power BI appeared in 2,609 postings.

| Skill   | Demand Count |
|---------|--------------|
| SQL     | 7,291        |
| Excel   | 4,611        |
| Python  | 4,330        |
| Tableau | 3,745        |
| Power BI| 2,609        |

**Table of the demand for the table 5 skills in data analyst job postings**
### 4. Skills Based on Salary
To identify which skills are associated with the highest average salaries, I analyzed the average yearly salary for each skill across Data Analyst job postings in 2023.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN  
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN  
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND 
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Here's is a breakdown for the top skills based on salary:
- **PySpark leads:** PySpark has the highest average salary at $208,172.

- **Specialized skills stand out:** Bitbucket, Couchbase, and Watson are also associated with salaries above $160K. 

- **Advanced technical skills:** The results show that specialized programming, data, and technology skills are associated with some of the highest average salaries. 

Strong demand for advanced tools: Skills such as Watson, DataRobot, and other specialized technologies also appear among the highest-paying skills.

| s/n | Skill         | Average Salary |
|------|---------------|----------------|
| 1    | PySpark       | $208,172.25    |
| 2    | Bitbucket     | $189,154.50    |
| 3    | Couchbase     | $160,515.00    |
| 4    | Watson        | $160,515.00    |
| 5    | DataRobot     | $155,485.50    |
| 6    | GitLab        | $154,500.00    |
| 7    | Swift         | $153,750.00    |
| 8    | Jupyter       | $152,776.50    |
| 9    | Pandas        | $151,821.33    |
| 10   | Elasticsearch | $145,000.00    |

**Table of the average salary for the top 10 paying skills for data analysts**

Exactly. #5 is about the most optimal skills to learn — balancing demand with average salary, rather than looking at salary alone.

### 5. Most Optimal Skills to Learn

To identify the most optimal skills for Data Analysts to learn, I compared how often each skill appears in job postings with its average salary. This helps highlight skills that offer a strong combination of job demand and earning potential.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN  
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN  
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY 
        skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN  
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN  
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND 
        job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skillS,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
```

Here's the breakdown for the most optimal skills to learn in data analyst job postings 2023:

- **Snowflake:** 37 job postings with an average salary of $112,948.

- **Azure:** 34 job postings with an average salary of $111,225.

- **Hadoop:** 22 job postings with an average salary of $113,193.

| s/n  | Skill       | Demand Count | Average Salary |
|------|-------------|--------------|----------------|
| 1    | Go          | 27           | $115,319.89    |
| 2    | Confluence  | 11           | $114,209.91    |
| 3    | Hadoop      | 22           | $113,192.57    |
| 4    | Snowflake   | 37           | $112,947.97    |
| 5    | Azure       | 34           | $111,225.10    |
| 6    | BigQuery    | 13           | $109,653.85    |
| 7    | AWS         | 32           | $108,317.30    |
| 8    | Java        | 17           | $106,906.44    |
| 9    | SSIS        | 12           | $106,683.33    |
| 10   | Jira        | 20           | $104,917.90    |

Table of the most optimal skills for data analyst sorted by salary
     

**Main takeaway:** Skills such as Snowflake, Azure, and Hadoop stand out because they combine meaningful job demand with relatively high salaries.

# What I Learned
Through this Data Analyst project, I strengthened my SQL and data analysis skills by working with a real-world job postings dataset from 2023. I learned how to turn raw data into useful insights about the Data Analyst job market.
- **SQL** Querying: Improved my ability to write SELECT, WHERE, ORDER BY, GROUP BY, JOIN, and LIMIT queries to analyze data efficiently.

- **Data Cleaning & Filtering:** Learned how to filter relevant records, handle NULL values, and focus analysis on specific job types and salary information.
- **Joins & Database Relationships:** Gained practical experience connecting multiple tables using JOIN statements, especially when linking jobs, companies, and skills.
- **CTEs:** Used Common Table Expressions (WITH) to break complex queries into smaller, easier-to-understand steps.
- **Aggregations:** Practiced functions such as COUNT() and AVG() to measure skill demand and average salaries.
- **Market Analysis:** Learned how to analyze which skills are most in demand, which are associated with higher salaries, and which skills provide a strong balance between demand and earning potential.
- **Data Visualization:** Learned how to present SQL results through tables and charts so that key findings are easier to understand.
- **Business Thinking:** Most importantly, I learned how to move beyond simply querying data and use SQL results to answer practical questions about the job market.

#### Key Takeaway
This project strengthened my ability to use SQL and data analysis to turn raw job-posting data into meaningful insights about skills, salaries, and demand in the Data Analyst job market.


# 🎯 Conclusion

This project was more than just writing SQL queries — it was an opportunity to turn raw job-market data into meaningful insights.

Throughout the analysis, I explored salary trends, skill demand, and the relationship between skills and earning potential within the 2023 Data Analyst job market. Along the way, I strengthened my ability to work with relational databases, write efficient SQL queries, analyze data, and communicate findings through clear visualizations.

📊 The biggest lesson: good analysis is not just about finding numbers — it’s about asking the right questions and turning those numbers into insights that can support better decisions.

🚀 This project marks another step in my journey toward becoming a stronger Data Analyst, and I look forward to applying these skills to more complex, real-world datasets.

Thank you for exploring my project! 🙌