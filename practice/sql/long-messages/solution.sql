WITH msgs AS (
    SELECT
        author,
        TRIM(message) AS message,
        LENGTH(TRIM(message)) AS message_length
    FROM repo_commits
    WHERE message IS NOT NULL
      AND TRIM(message) != ''
)
SELECT
    author,
    message,
    message_length
FROM msgs
WHERE message_length > (SELECT AVG(message_length) FROM msgs)
ORDER BY message_length DESC
