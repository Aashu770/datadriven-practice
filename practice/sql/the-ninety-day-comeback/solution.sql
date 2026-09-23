WITH first_session AS (
    -- Collapse 150M → one row per user
    SELECT
        user_id,
        MIN(DATE(session_start)) AS first_date
    FROM user_sessions
    GROUP BY user_id
),
user_retention AS (
    SELECT
        f.user_id,
        MAX(CASE
            WHEN DATE(us.session_start) > f.first_date        
             AND DATE(us.session_start) <= f.first_date 
                 + INTERVAL '90 days'                         
            THEN 1 ELSE 0
        END) AS is_retained
    FROM first_session f
    JOIN user_sessions us ON f.user_id = us.user_id
    GROUP BY f.user_id
)
SELECT
    CAST(SUM(is_retained) AS REAL) / COUNT(*) AS retention_rate
FROM user_retention
