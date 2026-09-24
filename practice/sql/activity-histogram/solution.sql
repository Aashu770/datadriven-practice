WITH sessions AS (
SELECT
  user_id,
  count(session_id) as session_count
FROM user_sessions
GROUP BY 1
)

SELECT 
  session_count,
  count(user_id) 
FROM sessions
GROUP BY 1
ORDER BY 1
