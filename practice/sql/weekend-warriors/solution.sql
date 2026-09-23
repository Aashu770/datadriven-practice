SELECT
  event_type,
  COUNT(CASE WHEN EXTRACT(DOW FROM event_timestamp) IN (0, 6) THEN event_id END) AS weekend_count,
  COUNT(CASE WHEN EXTRACT(DOW FROM event_timestamp) IN (1, 2, 3, 4, 5) THEN event_id END) AS weekday_count
FROM
  event_data
GROUP BY 1
ORDER BY 2 DESC,1
