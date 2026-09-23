WITH user_spend AS (
    SELECT
        user_id,
        SUM(total_amount) AS total_spend
    FROM transactions
    GROUP BY user_id
)
SELECT
    u.account_status,
    ROUND(AVG(us.total_spend), 3) AS avg_total_spending
FROM users u
JOIN user_spend us ON u.user_id = us.user_id
GROUP BY u.account_status
ORDER BY u.account_status ASC
