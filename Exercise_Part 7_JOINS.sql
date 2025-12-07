COMMIT;

ROLLBACK;

SELECT 
    *
FROM
    departments_dup;
    
ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

DROP TABLE IF EXISTS dept_manager_dup;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES   (999904, '2017-01-01'),
         (999905, '2017-01-01'),
		 (999906, '2017-01-01'),
		 (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

SELECT @@sql_mode;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no , m.dept_no , d.dept_name
ORDER BY m.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager_dup dm ON e.emp_no = dm.emp_no
ORDER BY e.emp_no;

SELECT 
    de.emp_no, de.from_date, d.dept_name
FROM
    dept_emp de
INNER JOIN
	departments d
ON de.dept_no=d.dept_no
ORDER BY de.emp_no;

-- INNER JOIN = JOIN
-- RIGHT OUTER JOIN = RIGHT JOIN
-- If a RIGHT JOIN has reversed tables, it'll be a LEFT JOIN

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , e.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY dm.dept_no DESC;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm
        RIGHT JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY dm.dept_no DESC;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- WHERE - OLD SYNTAX
SELECT 
    m.dept_no, 
    m.emp_no, 
    d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Old syntax with WHERE clause
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    dm.dept_no, 
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;
    
-- Same result with new JOIN syntax
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    dm.dept_no, 
    e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no; 
    
SELECT 
    dm.emp_no, s.salary, s.from_date
FROM
    dept_manager dm,
    salaries s
WHERE
    dm.emp_no = s.emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000; 

select @@global.sql_mode;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);

SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.hire_date,
    t.title
FROM
    employees e
        LEFT JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY e.emp_no;

SELECT 
    dm.*,
    d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT 
    dm.*,
    d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no, d.dept_no;

# CROSS JOIN - All possible combinations of two sets
-- CROSS JOIN is the same as the Old WHERE syntax for joining two tables - no ON part.
-- So, when you pake a JOIN clause, if it is without a ON part, MySQL takes it as a CROSS JOIN

# If you have a join, always write the ON part. If it is a CROSS JOIN, write it as such.

SELECT 
    dm.*,
    d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- We can CROSS JOIN more than two tables

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;