WITH counted AS (
    SELECT
        mdl_name,
        model_id,
        accuracy,
        ROW_NUMBER() OVER (
            PARTITION BY mdl_name
            ORDER BY train_at DESC, model_id DESC
        ) AS rn
    FROM ml_models
    WHERE accuracy IS NOT NULL
      AND train_at IS NOT NULL
      AND TRIM(train_at) != ''
),
agg AS (
    SELECT
        mdl_name,
        ROUND(AVG(accuracy),2) AS avg_lifetime_accuracy,
        MAX(CASE WHEN rn = 1 THEN accuracy END) AS latest_accuracy,
        ROUND(AVG(CASE WHEN rn > 1 THEN accuracy END),2) AS avg_earlier_accuracy
    FROM counted
    GROUP BY mdl_name
)
SELECT
    mdl_name AS model_name,
    avg_lifetime_accuracy,
    latest_accuracy,
    COALESCE(latest_accuracy - avg_earlier_accuracy, 0) AS difference
FROM agg
ORDER BY model_name ASC
