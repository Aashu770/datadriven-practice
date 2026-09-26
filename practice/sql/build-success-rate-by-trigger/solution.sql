SELECT
    trigger,
    COUNT(*) AS total_builds,
    ROUND(1.0 * COUNT(CASE WHEN LOWER(status) = 'success' THEN 1 END) / COUNT(*), 3) AS success_rate
FROM ci_builds
GROUP BY trigger
ORDER BY trigger ASC
