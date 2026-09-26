SELECT
    platform,
    ROUND(
        1.0 * COUNT(CASE WHEN opened = 1 THEN 1 END) / COUNT(*),
        2
    ) AS confirmation_rate
    FROM push_notifs_2fa
WHERE status = 'delivered'
GROUP BY platform
ORDER BY confirmation_rate DESC
