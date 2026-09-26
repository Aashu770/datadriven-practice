SELECT
    department,
    COUNT(CASE WHEN fiscal_quarter = 'Q1' THEN 1 END) AS q1,
    COUNT(CASE WHEN fiscal_quarter = 'Q2' THEN 1 END) AS q2,
    COUNT(CASE WHEN fiscal_quarter = 'Q3' THEN 1 END) AS q3,
    COUNT(CASE WHEN fiscal_quarter = 'Q4' THEN 1 END) AS q4
FROM employee_metrics
GROUP BY department
ORDER BY department ASC
