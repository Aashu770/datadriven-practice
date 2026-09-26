SELECT 
products.product_name,
COALESCE(
SUM(
CASE 
WHEN products.category = 'Electronics' 
THEN transactions.total_amount 
ELSE 0 
END
), 0
) AS electronics_total
FROM products
LEFT JOIN transactions 
ON products.product_id = transactions.product_id
GROUP BY products.product_id, products.product_name
ORDER BY electronics_total DESC, products.product_name asc;
