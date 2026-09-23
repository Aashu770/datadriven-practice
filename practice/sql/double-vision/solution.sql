SELECT 
  email,
  count(user_id)   as occurrence_count,
  MIN(signup_date) as earliest_signup,
  MAX(signup_date) as latest_signup
FROM users
WHERE email is not null
GROUP BY 1
HAVING count(user_id) > 1
ORDER BY 2 DESC
