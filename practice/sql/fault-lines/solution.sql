SELECT
    DATE(e.event_timestamp) AS event_day,
    u.age_bucket AS region,
    CASE
        WHEN COUNT(CASE WHEN e.event_type = 'open' THEN 1 END) = 0 THEN NULL
        ELSE CAST(
            COUNT(CASE WHEN e.event_type IN ('error', 'crash') THEN 1 END) AS REAL
        ) / COUNT(CASE WHEN e.event_type = 'open' THEN 1 END)
    END AS error_rate
FROM event_data e
JOIN users u ON e.user_id = u.user_id
WHERE e.event_type IN ('open', 'error', 'crash')
GROUP BY 1, 2
ORDER BY 1, 2
