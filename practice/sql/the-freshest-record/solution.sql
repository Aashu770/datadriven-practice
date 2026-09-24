WITH first_occurrence AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY server_name, message 
            ORDER BY log_timestamp ASC
        ) AS rn
    FROM server_logs
)
SELECT
    log_id,
    server_name,
    log_level,
    message,
    response_time_ms,
    log_timestamp
FROM first_occurrence
WHERE rn = 1
  AND log_timestamp >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY log_timestamp DESC
