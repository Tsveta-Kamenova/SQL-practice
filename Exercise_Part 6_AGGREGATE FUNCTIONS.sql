SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    COUNT(salary)
FROM
    salaries;
SELECT 
    COUNT(from_date)
FROM
    salaries;

SELECT 
    COUNT(salary)
FROM
    salaries;
SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
    
SELECT 
    COUNT(salary)
FROM
    salaries;
SELECT 
    COUNT(*) # COUNT(*) takes into account the NULL values
FROM
    salaries;

SELECT 
    *
FROM
    salaries
WHERE
    from_date IS NULL
ORDER BY salary DESC;

SELECT 
    dept_no, COUNT(dept_no)
FROM
    dept_emp
GROUP BY dept_no;

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
SELECT 
    COUNT(DISTINCT title)
FROM
    titles;
    
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date < '1995-01-01';
    
SELECT 
    MAX(salary)
FROM
    salaries;
    
SELECT 
    MIN(salary)
FROM
    salaries;

SELECT 
    MAX(emp_no)
FROM
    employees;
    
SELECT 
    MIN(emp_no)
FROM
    employees;
    
SELECT 
    MIN(dept_no)
FROM
    departments;

SELECT 
    AVG(salary)
FROM
    salaries;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date <= '1994-12-01';
    
SELECT 
    ROUND(AVG(salary))
FROM
    salaries;
    
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    ROUND(AVG(salary)) as average_salary
FROM
    salaries
WHERE
    from_date <= '1994-11-29';

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

ALTER TABLE departments_dup
ADD COLUMN dept_manager VARCHAR(40);

INSERT INTO departments_dup (dept_no, dept_name)
VALUES ('d011', ''), ('d012', '');

UPDATE departments_dup 
SET 
    dept_name = 'd011'
WHERE
    dept_no = 'd011';
    
UPDATE departments_dup 
SET 
    dept_name = 'd012'
WHERE
    dept_no = 'd012';

COMMIT;

ALTER TABLE departments_dup
MODIFY dept_name VARCHAR(40) NULL;

UPDATE departments_dup 
SET 
    dept_name = NULL
WHERE
    dept_no = 'd011';
    
UPDATE departments_dup 
SET 
    dept_name = NULL
WHERE
    dept_no = 'd012';

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') as dept_name
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    dept_no,
    COALESCE(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no;

# You can create fake columns if still figuring out the structure of the table
SELECT 
    dept_no,
    dept_name,
    COALESCE('department manager name') AS fake_col
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

UPDATE departments_dup
SET dept_name = 'Unknown'
WHERE dept_name IS NULL;

ALTER TABLE departments_dup
MODIFY dept_name VARCHAR(40) NOT NULL;

SELECT 
    emp_no, birth_date, COALESCE(first_name, last_name) as name
FROM
    employees;

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    emp_no,
    birth_date,
    IFNULL(first_name, 'Not provided') AS first_name,
    IFNULL(last_name, 'Not provided') AS last_name
FROM
    employees;