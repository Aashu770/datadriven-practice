SELECT
  ad_campaign,
  count(impression_id) as impressions,
  sum(revenue) as total_revenue,
  ROUND(SUM(CAST(clicked AS DECIMAL))/count(impression_id) * 100,1) as ctr
FROM ad_impressions
GROUP BY 1
HAVING impressions > 15
ORDER BY 4 DESC, 1
