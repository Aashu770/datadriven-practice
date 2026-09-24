WITH first_table AS (
SELECT 
  job_name,
  rows_done,
  ROW_NUMBER() OVER (PARTITION BY job_name ORDER BY started) as row_num
FROM batch_jobs
)

SELECT
  job_name,
  rows_done
FROM first_table f
where row_num = 1
ORDER BY 1
