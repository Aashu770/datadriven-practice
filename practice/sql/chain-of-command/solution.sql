WITH RECURSIVE org_hierarchy AS (
    -- Base case: CEOs (manager_id IS NULL)
    SELECT
        employee_id,
        emp_name,
        0 as depth,
        emp_name as path,
        manager_id
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: find direct reports of anyone already in hierarchy
    SELECT
        e.employee_id,
        e.emp_name,
        oh.depth + 1,
        oh.path || '/' || e.emp_name as path,
        e.manager_id
    FROM employees e
    JOIN org_hierarchy oh ON e.manager_id = oh.employee_id
)
SELECT
    employee_id,
    emp_name,
    depth,
    path
FROM org_hierarchy
ORDER BY path, employee_id
