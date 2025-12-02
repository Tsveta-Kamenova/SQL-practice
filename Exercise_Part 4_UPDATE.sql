UPDATE employees 
SET 
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE 
emp_no = 999901;

SELECT 
    *
FROM
    employees
WHERE emp_no = 999901;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';
    
ROLLBACK;

COMMIT;

SELECT 
    *
FROM
    departments;

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE dept_no = 'd010';

SELECT 
    *
FROM
    employees;
    
UPDATE employees 
SET 
    first_name = 'Juan',
    last_name = 'Speed',
    gender = 'M',
    birth_date = '1979-06-05'
WHERE
    emp_no = 10003;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 10003;
    
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

COMMIT;

SELECT 
    *
FROM
    departments
WHERE
    dept_no = 'd004';
    
UPDATE departments 
SET 
    dept_name = 'Data Analysis new'
WHERE dept_no = 'd004';

SELECT * FROM departments WHERE dept_no='d004';

ROLLBACK;