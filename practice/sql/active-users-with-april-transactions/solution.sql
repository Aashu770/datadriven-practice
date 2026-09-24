SELECT 
  count(distinct u.user_id) AS active_users_with_transactions
FROM
  users u
INNER JOIN
  transactions t
ON u.user_id = t.user_id
WHERE account_status = 'active'
AND transaction_date between '2026-04-01' and '2026-04-30'
