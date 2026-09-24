WITH new_editor_first AS (
    SELECT
        user_id,
        MIN(viewed_at) AS first_new_editor_date
    FROM page_views
    WHERE page_url = 'new_editor'
    GROUP BY user_id
),
classic_editor_first AS (
    SELECT
        user_id,
        MIN(viewed_at) AS first_classic_editor_date
    FROM page_views
    WHERE page_url = 'classic_editor'
    GROUP BY user_id
)
SELECT
    nef.user_id
FROM new_editor_first nef
LEFT JOIN classic_editor_first cef
    ON nef.user_id = cef.user_id
WHERE cef.first_classic_editor_date IS NULL
   OR cef.first_classic_editor_date > nef.first_new_editor_date
ORDER BY nef.user_id
