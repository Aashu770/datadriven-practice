WITH catalog_avg AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT
    product_name,
    category,
    price,
    ROUND(avg_price, 3) AS catalog_avg
FROM products, catalog_avg      
WHERE price > avg_price
ORDER BY price DESC
