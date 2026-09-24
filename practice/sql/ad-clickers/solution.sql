WITH user_revenue AS (
SELECT
  user_id,
  CAST(sum(revenue) AS decimal) as total_revenue
FROM ad_impressions
GROUP BY 1
HAVING total_revenue >0
)

SELECT 
  username,
  ROUND(COALEScE(total_revenue,0),2) as total_revenue
FROM users u
INNER JOIN user_revenue ur
ON u.user_id = ur.user_id
ORDER BY 2 DESC
