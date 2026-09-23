SELECT
  u.user_id,
  username,
  count(session_id) as session_count,
  sum(pages_viewed) as total_pages
FROM users u
JOIN user_sessions us
ON u.user_id = us.user_id
WHERE u.account_status = 'active'   
GROUP BY 1,2
HAVING (session_count>3 AND total_pages > 100)
ORDER BY 4 DESC
