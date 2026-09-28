-- Counting all data analyst job from my schema
SELECT 
    COUNT(job_id),
    job_title_short
FROM
    job_postings_fact
WHERE   
    job_title_short = 'Data Analyst'
GROUP BY
    job_title_short
