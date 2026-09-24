WITH prodcut_avgs AS (
SELECT
  p.product_name,
  p.category,
  AVG(total_amount) as product_avg
FROM products p
JOIN transactions t
ON p.product_id = t.product_id
GROUP BY 1,2
),

category_avgs AS (
SELECT
  p.category,
  AVG(total_amount) as category_avg
FROM products p
JOIN transactions t
ON p.product_id = t.product_id
GROUP BY 1
)

SELECT 
  pv.product_name,
  pv.product_avg,
  cv.category_avg
FROM prodcut_avgs as pv
LEFT JOIN category_avgs cv
ON pv.category = cv.category
WHERE pv.product_avg > cv.category_avg
