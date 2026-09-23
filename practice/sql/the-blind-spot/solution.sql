WITH channel_users AS (
    SELECT DISTINCT channel, sender_id
    FROM chat_msgs
),
connections AS (
    SELECT DISTINCT
        a.sender_id AS user_id,
        b.sender_id AS connection_id
    FROM channel_users a
    JOIN channel_users b
        ON a.channel = b.channel
        AND a.sender_id != b.sender_id
),
user_pages AS (
    SELECT DISTINCT user_id, page_url
    FROM page_views
)
SELECT
    c.user_id,
    up.page_url AS content_id
FROM connections c
JOIN user_pages up
    ON c.connection_id = up.user_id
LEFT JOIN user_pages my_pages                  
    ON my_pages.user_id = c.user_id
    AND my_pages.page_url = up.page_url
WHERE my_pages.page_url IS NULL               
GROUP BY c.user_id, up.page_url
HAVING COUNT(DISTINCT c.connection_id) >= 2
ORDER BY c.user_id, up.page_url
