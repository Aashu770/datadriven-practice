SELECT
    product_name,
    category,
    price,
    ROUND((SELECT AVG(price) FROM products), 3) AS catalog_avg
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC
