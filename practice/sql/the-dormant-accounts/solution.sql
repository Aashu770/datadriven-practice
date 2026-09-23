WITH transactions_s AS 
  ( SELECT
        user_id,
        sum(total_amount) as lifetime_spend
      FROM transactions
      GROUP BY 1
  ),
last_login AS (
      SELECT 
        user_id,MAX(session_start) as last_login
      FROM user_sessions
      GROUP BY 1 
)    
SELECT 
  username, account_status, us.last_login, COALESCE (lifetime_spend,0)
FROM users u
LEFT JOIN last_login us
ON u.user_id = us.user_id
LEFT JOIN transactions_s t
ON u.user_id = t.user_id
WHERE account_status = 'active'
AND (last_login < NOW() - INTERVAL '90 days' OR last_login is NULL)
