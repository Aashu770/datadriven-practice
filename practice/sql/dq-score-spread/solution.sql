with table_status as (
SELECT
  tbl_name,
  sum(fail_pct) as fail_percentage
FROM dq_checks
group by 1
)

SELECT 
  max(fail_percentage) - min(fail_percentage) as dq_spread
FROM table_status
