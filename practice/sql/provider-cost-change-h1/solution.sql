SELECT
    provider,
    AVG(CASE WHEN EXTRACT(MONTH FROM bill_date) = 7 THEN amount END)
      - AVG(CASE WHEN EXTRACT(MONTH FROM bill_date) = 1 THEN amount END) AS amount_change
FROM cloud_costs
WHERE EXTRACT(MONTH FROM bill_date) IN (1, 7)
GROUP BY provider
ORDER BY provider;
