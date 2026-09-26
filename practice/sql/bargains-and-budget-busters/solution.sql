WITH combined AS (
    SELECT region, svc_name, amount FROM cloud_costs
    UNION ALL
    SELECT region, svc_name, amount FROM cost_allocs
),
ranked AS (
    SELECT
        region,
        svc_name,
        amount,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC, svc_name ASC) AS rn_max,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount ASC, svc_name ASC) AS rn_min
    FROM combined
)
SELECT
    mx.region,
    mx.svc_name AS most_expensive,
    mn.svc_name AS cheapest
FROM (SELECT region, svc_name FROM ranked WHERE rn_max = 1) mx
JOIN (SELECT region, svc_name FROM ranked WHERE rn_min = 1) mn
    ON mn.region = mx.region
ORDER BY mx.region ASC
