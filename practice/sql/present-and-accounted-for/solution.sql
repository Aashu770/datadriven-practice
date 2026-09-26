SELECT
  product_name,
  COALESCE(SUM(CASE WHEN category= 'Electronics' THEN t.total_amount 
ELSE 0 END),0) as electronics_total
FROM products p
LEFT JOIN transactions t
ON p.product_id = t.product_id
GROUP BY p.product_id, p.product_name
ORDER BY 2 DESC,1
