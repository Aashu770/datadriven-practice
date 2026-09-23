SELECT
  event_type,
  SUM(CASE WHEN STRFTIME('%w', event_timestamp) IN ('0','6') THEN 1 ELSE 0 END) AS weekend_count,
  SUM(CASE WHEN STRFTIME('%w', event_timestamp) NOT IN ('0','6') THEN 1 ELSE 0 END ) AS weekday_count
FROM event_data
GROUP BY event_type
ORDER BY weekend_count DESC
