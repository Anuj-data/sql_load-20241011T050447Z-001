# Introduction  
🚀 **Dive into the Data Job Market!** 📊  
This project focuses on Data Analyst roles, exploring top-paying opportunities 💸, in-demand skills 🔍, and the sweet spot where high demand meets high salaries in the world of data analytics 🌐.

## Background  
The questions I aimed to answer through my SQL queries were:  
- 💼💸 **What are the top-paying data analyst jobs?**  
- 🧠🚀 **What skills are required for these top-paying jobs?**  
- 📊🔍 **What skills are most in demand for data analysts?**  
- 💵📈 **Which skills are associated with higher salaries?**  
- 🎯📚 **What are the most optimal skills to learn?**  

## Tools I Used  
For my deep dive into the data analyst job market, I harnessed the power of several key tools:  
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.  
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.  
- **Visual Studio Code:** My go-to for database management and executing SQL queries.  
- **Git & GitHub:** Essential for version control and sharing the SQL scripts and analysis, ensuring collaboration and project tracking.  

## The Analysis  
Each query in this project aimed to investigate specific aspects of the data analyst job market.  

### 1. Top-Paying Data Analyst Jobs  
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high-paying opportunities in the field.  

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim
ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
Here's the brekeakdown of top data analyst jobs in 2023:
- Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salry pootential in the field.
- Diverse Employers: Companies like smartAssest, Meta, and AT&T are aong those offereing high slaries, showing a broad interest across different industries.
- Job Title Variety: There's a high diversitry in job titles, from Data Analyst to Director of Data Analytics, reflecting varied roles specializations within data analytics.

| Rank | Skill      | Count |
|------|------------|-------|
| 1    | SQL        | 8     |
| 2    | Python     | 7     |
| 3    | Tableau    | 7     |
| 4    | R          | 6     |
| 5    | Snowflake  | 4     |
| 6    | Pandas     | 4     |
| 7    | Excel      | 4     |
| 8    | Azure      | 3     |
| 9    | Bitbucket  | 3     |
| 10   | Go         | 3     |

### 2. Skills For Top Paying Jobs 

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim
    ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL 
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Here is the breakdown of most demanded skills for Top 10 highest paying data analyst job in 2023:
- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also sought after, with a bold count of 6. Other skills like R, Snowflakes, Pandas, and Excel show varying degrees of demand.

### 3. In-Demand skills for Data Analysts 
This query helped identify the skills most frequently requested in job postings, directly focus on areas with high demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT
    5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the the increasing importance of technical skills in data storytelling and decision suppport.
 
| Skills   | Skill Count |
|----------|-------------|
| SQL      | 7291        |
| Excel    | 4611        |
| Python   | 4330        |
| Tableau  | 3745        |
| Power BI | 2609        |

*Tables of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Bsed On Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    AVG(salary_year_avg) AS average_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    skills DESC
LIMIT
    25;
```
Here's the breakdown of the result for top paying skills for Data Analysts:
- High Demand For Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, Numpy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: Knowledge in Development and Deployment tools (Github, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on sills that facilitate automation and efficient data pipeline management.
- Cloud Computing Expertise: Familiarity with cloud and Data Engineering tools (Elasticsearch, Databricks, GCP) Underscores the growing importance of cloud-base analytics environments, suggesting that cloud proficiency significantly boosts earning potential in Data Analytics.

| Skills        | Average Salary |
|---------------|----------------|
| Pyspark       | 208,172        |
| Bitbucket     | 189,155        |
| Couchbase     | 160,515        |
| Watson        | 160,515        |
| Datarobot     | 155,486        |
| Gitlab        | 154,400        |
| Swift         | 153,750        |
| Jupyter       | 152,777        |
| Pandas        | 151,821        |
| Elasticsearch | 145,000        |

*Table of the average salary for the Top 10 paying skills for data analysts*

### 5. Most Optimal Skills To Learn 

Combining insights from demand and salary data, This query aimed to pinpoint skills that are both in high demand and have high slaries, offering a strategic focus for skill development.

```sql
WITH skills_demand AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN 
        skills_job_dim 
    ON 
        job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim 
    ON 
        skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = True 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id, 
        skills_dim.skills
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        AVG(salary_year_avg) AS average_salary
    FROM
        job_postings_fact
    INNER JOIN 
        skills_job_dim 
    ON 
        job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim 
    ON 
        skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.average_salary
FROM
    skills_demand
INNER JOIN
    average_salary
ON
    skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT
    25;
```
| Skill ID | Skills     | Demand Count | Average Salary (S) |
|----------|------------|--------------|--------------------|
| 8        | Go         | 27           | 115,320             |
| 234      | Confluence | 11           | 114,210             |
| 97       | Hadoop     | 22           | 113,193             |
| 80       | Snowflake  | 37           | 112,948             |
| 74       | Azure      | 34           | 111,225             |
| 77       | BigQuery   | 13           | 109,654             |
| 76       | AWS        | 32           | 108,317             |
| 4        | Java       | 17           | 106,906             |
| 194      | SSIS       | 12           | 106,686             |
| 233      | Jira       | 20           | 104,918             |

*Table of the most optimal skills for data analyst sorted by salary*

Here's the breakdown of the most optimal skills for Data Analysts in 2023:
- High demanded Programming Language: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- Cloud Tools And Technologies: Skills in specified technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data techbologies in data analysis.
- Business intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- Database Technologies: The deamnd for skills in traditional and NoSQL databases (oracle,SQL Server, NoSQL) with average salries ranging from $97,786 to $104,534, reflect the enduring need for data storage, retrieval, and management expertise.

# What I learned

🚀 Turbocharging My SQL Toolkit: An Epic Adventure 🚀

Throughout this journey, I've supercharged my SQL skills with some serious upgrades:

- 🔍 Complex Query Crafting: Mastered the art of advanced SQL, seamlessly merging tables like a pro and wielding WITH clauses for ninja-level temporary table maneuvers.
- 📊 Data Aggregation Magic: Got cozy with GROUP BY, transforming aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- 🧙‍♂️ Analytical Wizardry: Leveled up my real-world problem-solving skills, turning complex questions into actionable, insightful SQL queries.

# conclusions

### Insights 


1. Top-paying Data Analyst jobs- The highest paying job for Data Analyst that allow remote work offer a wide range of salaries, The highest of $650,000!
2. Skills For Top Paying Jobs- High-Paying Data Analyst jobs require advanced proficiency in SQL, Suggesting it's a critical skills for  earning a top salary.
3. Most In-demand Skills- SQL is the most demanded skill in the data analyst job market, Thus making it essential for job seekers.
4. Skills With Higher Salaries- Specialized skills, Such as SVN and Solidity, are associated with highest average salaries, indicating a premium on a niche expertise.
5. Optimal Skills For Job Market Value- SQL leads in demand and offer for high average salary, positioning it as one of the most optimal skills for data analyst to learn to maximize their market value. 

### Closing Thoughts 
This project not only sharpened my SQL skills but also provided valuable insights into the data analyst job market. 📊 The findings act as a roadmap for prioritizing skill development and job search strategies, helping aspiring data analysts better position themselves in a competitive landscape. 🚀

By focusing on high-demand, high-salary skills, candidates can enhance their career prospects. 💼 This exploration emphasizes the importance of continuous learning and adapting to emerging trends in data analytics, paving the way for sustained growth and success. 📈

