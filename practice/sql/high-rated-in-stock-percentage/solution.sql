SELECT
  
100*( SUM(
(CASE WHEN rating >=4 AND in_stock=1 THEN 1 ELSE 0 END)
)*1.0/count (Distinct product_id)) as pct_in_stock_high_rated
FROM 
  products
