SELECT
  tbl_name,
  COUNT(passed) AS failed_checks,
  COUNT(distinct rule) as distinct_rules,
  AVG(fail_pct) as avg_fail_pct
FROM 
  dq_checks
where passed = 0
GROUP BY 1
HAVING avg_fail_pct > 30
order by 4 desc
