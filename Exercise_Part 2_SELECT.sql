SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;
    
SELECT 
    dept_no
FROM
    departments;
    
USE employees;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' 
    AND gender = 'M'
    OR gender = 'F';
    
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie', 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('1989%');
    
SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE ('195_-__-__');
 
SELECT
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
    
SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006'; 

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10003' AND '10008';

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL; 

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
	AND hire_date >= '2000-01-01';
    
SELECT 
    salary
FROM
    salaries
WHERE
    salary > 150000;
    
SELECT DISTINCT
    hire_date
FROM
    employees;
    
SELECT 
    COUNT(emp_no)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
    
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    count(emp_no)
FROM
    dept_manager;

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 75405;
    
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

SELECT 
    *
FROM
    employees
ORDER BY birth_date DESC;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

SELECT 
    salary, COUNT(emp_no) as emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
order by salary;

SELECT 
    title, COUNT(emp_no) AS emps_with_same_job_title
FROM
    titles
WHERE
    to_date = "9999-01-01"
GROUP BY title;

SELECT 
    *
FROM
    employees
HAVING hire_date >= '2000-01-01';

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

SELECT
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;
    
SELECT
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no
HAVING avg_salary > 70000
ORDER BY emp_no ASC;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC
LIMIT 100;

SELECT 
    emp_no, COUNT(emp_no)
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;

SELECT 
    *
FROM
    salaries
ORDER BY salary
LIMIT 10;

SELECT 
    *
FROM
    dept_emp
LIMIT 100;

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 5;