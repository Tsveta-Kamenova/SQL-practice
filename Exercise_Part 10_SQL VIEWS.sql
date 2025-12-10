SELECT 
    *
FROM
    dept_emp;
    
SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

SET sql_mode = '';

SET sql_mode = @@GLOBAL.sql_mode;

SELECT @@GLOBAL.sql_mode;

SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SELECT 
    emp_no,
    ANY_VALUE(from_date) AS from_date,
    ANY_VALUE(to_date) AS to_date,
    COUNT(*) AS Num
FROM dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no
;

SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no
;

SELECT * FROM employees.v_dept_emp_latest_date;

CREATE OR REPLACE VIEW v_average_salary_managers_exists AS
SELECT 
    round(AVG(salary),2) AS avg_salary
FROM
    salaries s
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            s.emp_no = dm.emp_no)
;

SELECT * FROM employees.v_average_salary_managers_exists;

SELECT 
    *
FROM
    dept_emp;
    
CREATE OR REPLACE VIEW v_manager_avg_salary_join AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;

SELECT * FROM employees.v_manager_avg_salary_join;
DROP VIEW IF EXISTS v_manager_avg_salary_emps;
CREATE VIEW v_manager_avg_salary_emps AS
SELECT 
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
WHERE
    e.emp_no IN (10002 , 10005, 10007)
        AND s.from_date BETWEEN '1991-01-01' AND '1996-12-31'
;
    
SELECT * FROM employees.v_manager_avg_salary_emps;
    
SELECT 
    ROUND(AVG(salary), 2) AS avg_salary, e.emp_no
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
WHERE
    e.emp_no IN (10002 , 10005, 10007)
        AND s.from_date BETWEEN '1991-01-01' AND '1996-12-31'
GROUP BY e.emp_no;