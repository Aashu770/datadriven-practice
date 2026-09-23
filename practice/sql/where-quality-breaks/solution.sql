SELECT
  tbl_name,
  AVG(fail_pct) AS avg_fail_pct
FROM dq_checks
GROUP BY tbl_name
HAVING COUNT(DISTINCT rule) > 1
ORDER BY avg_fail_pct DESC, tbl_name
