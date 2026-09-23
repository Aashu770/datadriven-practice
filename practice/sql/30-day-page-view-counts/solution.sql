select user_id,
  count(*) as total_views
from page_views
where viewed_at between '2026-11-28' AND '2026-12-28'
group by user_id
order by total_views desc;
