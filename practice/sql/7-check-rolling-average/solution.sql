SELECT
  svc_name,
  checked,
  latency,
  AVG(latency) OVER (PARTITION BY svc_name ORDER BY checked 
ROWS BETWEEN 6 PRECEDING AND Current ROW) as rolling_avg
FROM svc_health
ORDER BY 1,2
