WITH counts AS (
    SELECT
        exp_name,
        COUNT(DISTINCT CASE WHEN variant = 'control' THEN user_id END) AS control_users,
        COUNT(DISTINCT CASE WHEN variant != 'control' THEN user_id END) AS treatment_users,
        COUNT(DISTINCT CASE WHEN variant = 'holdout' THEN user_id END) AS holdout_users
    FROM experiments
    GROUP BY exp_name
)
SELECT
    exp_name,
    control_users,
    treatment_users,
    CASE
        WHEN control_users = holdout_users THEN NULL
        ELSE ROUND(1.0 * treatment_users / control_users, 3)
    END AS treatment_to_control_ratio
FROM counts
ORDER BY exp_name ASC
