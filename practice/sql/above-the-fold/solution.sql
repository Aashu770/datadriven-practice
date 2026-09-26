SELECT
    query_id,
    CASE
        WHEN clicked_result IS NULL THEN NULL
        WHEN clicked_result = 0 THEN 1
        WHEN clicked_result BETWEEN 1 AND 3 THEN 3
        ELSE 2
    END AS rating
FROM search_queries
ORDER BY query_id ASC
