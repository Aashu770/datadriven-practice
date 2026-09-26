WITH min_uptimes AS (
    SELECT
        svc_name,
        MIN(uptime) AS min_uptime
    FROM svc_health
    WHERE uptime IS NOT NULL
    GROUP BY svc_name
),
ranked AS (
    SELECT
        svc_name,
        min_uptime,
        RANK() OVER (ORDER BY min_uptime ASC) AS rnk
    FROM min_uptimes
)
SELECT svc_name, min_uptime
FROM ranked
WHERE rnk <= 10
ORDER BY min_uptime ASC, svc_name ASC
