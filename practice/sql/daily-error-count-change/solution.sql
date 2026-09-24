with base as (
  select 
      date(first_at) as error_date, 
      count(distinct err_type) as error_count
  from err_tracks
  group by 1
 ),
 cal as (
    select 
        error_date,
        error_count, 
        LAG(error_count) OVER(ORDER BY error_date) as prev_count
    from base 
  )
  select 
      error_date, 
      error_count, 
      prev_count,
      error_count - prev_count as day_over_day_change
  from cal 
  order by 1
