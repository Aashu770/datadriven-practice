SELECT
  username,
  account_status,
  signup_date,
  session_start
FROM users u
LEFT JOIN user_sessions us
ON u.user_id = us.user_id
ORDER BY username ASC, session_start ASC
