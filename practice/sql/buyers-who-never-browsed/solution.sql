select 
    u.username,
    t.total_amount
    from users u 
    join transactions t on u.user_id = t.user_id 
    left join page_views v on u.user_id = v.user_id
    where 
    t.transaction_date >= '2026-01-01' and  t.transaction_date < '2027-01-01'
    and v.user_id is null 
    order by t.total_amount, u.username;
