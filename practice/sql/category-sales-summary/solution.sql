SELECT
  category,
  count(distinct t.product_id) as product_sold,
  sum(total_amount) as total_revenue
FROM transactions as t
INNER JOIN products p
ON p.product_id = t.product_id
where in_stock=1
GROUP BY 1
ORDER BY 3 DESC,1
