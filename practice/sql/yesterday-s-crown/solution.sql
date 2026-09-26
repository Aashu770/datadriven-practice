WITH filtered AS (
    SELECT bill_date, svc_name, amount
    FROM cloud_costs
    WHERE acct_id IS NOT NULL
),
daily_svc AS (
    SELECT bill_date, svc_name, SUM(amount) AS svc_total
    FROM filtered
    GROUP BY bill_date, svc_name
),
daily_total AS (
    SELECT bill_date, SUM(amount) AS day_total
    FROM filtered
    GROUP BY bill_date
),
ranked AS (
    SELECT
        bill_date,
        svc_name,
        svc_total,
        ROW_NUMBER() OVER (
            PARTITION BY bill_date
            ORDER BY svc_total DESC, svc_name ASC
        ) AS rn
    FROM daily_svc
),
top_svc AS (
    SELECT bill_date, svc_name AS top_svc_name, svc_total AS top_svc_amount
    FROM ranked
    WHERE rn = 1
),
day_seq AS (
    SELECT
        bill_date,
        LEAD(bill_date) OVER (ORDER BY bill_date) AS next_bill_day
    FROM daily_total
)
SELECT
    ds.next_bill_day AS bill_day,
    ts.top_svc_name AS svc_name,
    ts.top_svc_amount AS total_amount,
    dt.day_total AS prior_day_total
FROM day_seq ds
JOIN top_svc ts ON ts.bill_date = ds.bill_date
JOIN daily_total dt ON dt.bill_date = ds.bill_date
WHERE ds.next_bill_day IS NOT NULL
ORDER BY bill_day ASC
