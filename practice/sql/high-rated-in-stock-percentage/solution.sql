SELECT (CAST(total_rated AS DECIMAL) / CAST(total_product AS DECIMAL))*100  as pct_in_stock_high_rated FROM (
SELECT
  
  SUM(
(CASE WHEN rating >=4 AND in_stock=1 THEN 1 ELSE 0 END)
) as total_rated,
count (Distinct product_id) as total_product
FROM 
  products
) t
