WITH daily_errors AS (
    SELECT
        DATE(first_at) as error_date,
        COUNT(severity) as error_count
    FROM err_tracks
    --WHERE severity = 'error'
    GROUP BY 1
)
SELECT
    error_date,
    error_count,
    LAG(error_count) OVER (ORDER BY error_date) as prev_count,
    error_count - LAG(error_count) OVER (ORDER BY error_date) as day_over_day_change
FROM daily_errors
ORDER BY error_date
