SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;

SELECT 
	emp_no,
	first_name,
	last_name,
	CASE gender
		WHEN 'M' THEN 'Male'
		ELSE 'Female'
	END AS gender
FROM
	employees;
      
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE 
        WHEN  dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
# WRONG!!! CANNOT COMPARE NULL
/*
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
        WHEN NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
*/


SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;
    

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 
									'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.dept_no IS NOT NULL THEN 'manager'
        WHEN dm.dept_no IS NULL THEN 'regular employee'
        ELSE 'missing employee number'
    END AS is_manager
FROM
    dept_manager dm
        RIGHT JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990
ORDER BY e.emp_no;


SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF((MAX(s.salary) - MIN(s.salary) > 30000),
        'Salary was raised by more than $30,000',
        'Salary was NOT raised by more than $30,000') AS IS_raised_more_than_30k
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT
    dm.emp_no,  
    e.first_name,  
    e.last_name,  
    MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    CASE  
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  
        ELSE 'Salary was NOT raised by more then $30,000'  
    END AS salary_raise  
FROM  
    dept_manager dm  
        JOIN  
    employees e ON e.emp_no = dm.emp_no  
        JOIN  
    salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no; 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(to_date) = '9999-01-01' THEN 'Is still employed'
        WHEN MAX(to_date) <> '9999-01-01' THEN 'Not an employee anymore'
    END AS current_employee
FROM
    dept_emp de
        JOIN
    employees e ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.dept_no IS NOT NULL THEN 'manager'
        WHEN dm.dept_no IS NULL THEN 'regular employee'
        ELSE 'missing employee number'
    END AS is_manager
FROM
    dept_manager dm
        RIGHT JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990
ORDER BY e.emp_no;


SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 0 AND 10000 THEN 'insignificant'
        #WHEN MAX(s.salary) - MIN(s.salary) <= 10000 AND MAX(s.salary) - MIN(s.salary) >  0 THEN 'insignificant'
        WHEN MAX(s.salary) - MIN(s.salary) > 10000 THEN 'significant'
        ELSE 'salary decrease'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no , e.first_name , e.last_name , e.hire_date
ORDER BY dm.emp_no;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) >= '2025-01-01' THEN 'Currently working'
        ELSE 'No longer in the company'
    END AS current_status
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY e.emp_no , e.first_name , e.last_name;