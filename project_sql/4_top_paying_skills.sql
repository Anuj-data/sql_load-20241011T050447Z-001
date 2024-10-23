/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analyst and 
    helps identify the most financially rewarding skill to acquire or improve
*/
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

/*
Here are the top-Paying Skills for Data Analysts 2023

- Cloud & Automation: High salaries for VMware ($147K), Terraform ($147K), and Twilio ($139K) reflect the demand for cloud infrastructure and automation skills.

- Programming & Software Skills: Watson ($108K), Unix ($111K), and Unity ($99K) indicate a premium on AI, system-level, and data visualization expertise.

- Collaboration Tools: Zoom ($90K) and Webex ($93K) highlight the value of remote work capabilities in data roles.

[
  {
    "skills": "zoom",
    "average_salary": "89791.421052631579"
  },
  {
    "skills": "yarn",
    "average_salary": "99150.000000000000"
  },
  {
    "skills": "wrike",
    "average_salary": "75000.000000000000"
  },
  {
    "skills": "workfront",
    "average_salary": "76820.036458333333"
  },
  {
    "skills": "word",
    "average_salary": "82940.755618477230"
  },
  {
    "skills": "wire",
    "average_salary": "68375.000000000000"
  },
  {
    "skills": "windows",
    "average_salary": "86512.827685546875"
  },
  {
    "skills": "webex",
    "average_salary": "92500.000000000000"
  },
  {
    "skills": "watson",
    "average_salary": "108103.000000000000"
  },
  {
    "skills": "vue",
    "average_salary": "65000.000000000000"
  },
  {
    "skills": "vmware",
    "average_salary": "147500.000000000000"
  },
  {
    "skills": "visual basic",
    "average_salary": "86972.333333333333"
  },
  {
    "skills": "visio",
    "average_salary": "101035.815183080808"
  },
  {
    "skills": "vba",
    "average_salary": "93844.973986486486"
  },
  {
    "skills": "vb.net",
    "average_salary": "69600.000000000000"
  },
  {
    "skills": "unreal",
    "average_salary": "89112.500000000000"
  },
  {
    "skills": "unix",
    "average_salary": "111123.323057432432"
  },
  {
    "skills": "unity",
    "average_salary": "99616.700000000000"
  },
  {
    "skills": "unify",
    "average_salary": "112317.444444444444"
  },
  {
    "skills": "typescript",
    "average_salary": "89323.100000000000"
  },
  {
    "skills": "twilio",
    "average_salary": "138500.000000000000"
  },
  {
    "skills": "trello",
    "average_salary": "65193.455357142857"
  },
  {
    "skills": "tidyverse",
    "average_salary": "70599.928571428571"
  },
  {
    "skills": "theano",
    "average_salary": "100000.000000000000"
  },
  {
    "skills": "terraform",
    "average_salary": "146733.833333333333"
  }
]
*/
