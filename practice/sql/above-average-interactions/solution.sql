WITH user_session_agg AS (
  SELECT 
    user_id,
    count(session_id) total_session
  FROM 
    user_sessions
  GROUP BY 1
)

SELECT 
  user_id,
  total_session
FROM user_session_agg
WHERE total_session > (SELECT AVG(total_session) from user_session_agg)
ORDER BY 2 DESC,1
