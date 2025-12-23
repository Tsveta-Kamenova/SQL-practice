SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
-- Composite Indexes
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
CREATE INDEX i_composite ON employees(first_name, last_name);
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

-- SHOW INDEX
SHOW INDEX FROM employees FROM employees;
SHOW INDEX FROM employees;

ALTER TABLE employees
DROP INDEX i_hire_date;

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

ALTER TABLE salaries
DROP INDEX i_salary;

CREATE INDEX i_from_date ON dept_emp(from_date);

CREATE INDEX i_composite_salary  ON salaries(emp_no,salary);