SELECT
    mdl_name,
    AVG(accuracy) AS avg_accuracy,
    100.0 * COUNT(accuracy) / COUNT(*) AS completion_rate
FROM ml_models
GROUP BY mdl_name
ORDER BY mdl_name ASC
