COMMIT;

ROLLBACK;

SELECT 
    *
FROM
    dept_manager;
    
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
SELECT 
    dm.emp_no
FROM
    dept_manager dm;
    
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
SELECT 
    emp_no, dept_no, from_date
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            birth_date > '1955-01-01');
            
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no
;

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no
                AND t.title = 'Assistant Engineer');
            
SELECT 
    COUNT(*), title
FROM
    titles
GROUP BY title;

SELECT 
    COUNT(*)
FROM
    titles
WHERE
    title = 'Assistant Engineer';
    
SELECT 
    count(*)
FROM
    titles
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            title = 'Assistant Engineer');
            
                
SELECT 
    COUNT(*)
FROM
    titles
WHERE
    EXISTS( SELECT 
            emp_no
        FROM
            employees
        WHERE
            title = 'Engineer')
;

SELECT 
    *
FROM
    salaries s
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            title = 'Engineer'
                AND s.emp_no = t.emp_no)
;

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager dm
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager dm
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
    ;
    
    
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

SELECT 
    *
FROM
    emp_manager;
    
    
INSERT INTO
    emp_manager
SELECT
    U.*
FROM
    (
        SELECT
            A.*
        FROM
            (
                SELECT
                    e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT
                            emp_no
                        FROM
                            dept_manager dm
                        WHERE
                            emp_no = 110022
                    ) AS manager_ID
                FROM
                    employees e
                    JOIN dept_emp de ON de.emp_no = e.emp_no
                WHERE
                    e.emp_no <= 10020
                GROUP BY
                    e.emp_no
                ORDER BY
                    e.emp_no
            ) AS A
        UNION
        SELECT
            B.*
        FROM
            (
                SELECT
                    e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT
                            emp_no
                        FROM
                            dept_manager dm
                        WHERE
                            emp_no = 110039
                    ) AS manager_ID
                FROM
                    employees e
                    JOIN dept_emp de ON de.emp_no = e.emp_no
                WHERE
                    e.emp_no BETWEEN 10021 AND 10040
                GROUP BY
                    e.emp_no
                ORDER BY
                    e.emp_no
                LIMIT
                    20
            ) AS B
        UNION
        SELECT
            C.*
        FROM
            (
                SELECT
                    e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT
                            emp_no
                        FROM
                            dept_manager dm
                        WHERE
                            emp_no = 110039
                    ) AS manager_ID
                FROM
                    employees e
                    JOIN dept_emp de ON de.emp_no = e.emp_no
                WHERE
                    e.emp_no = 110022
                GROUP BY
                    e.emp_no
                ORDER BY
                    e.emp_no
            ) AS C
        UNION
        SELECT
            D.*
        FROM
            (
                SELECT
                    e.emp_no AS employee_ID,
                    MIN(de.dept_no) AS department_code,
                    (
                        SELECT
                            emp_no
                        FROM
                            dept_manager dm
                        WHERE
                            emp_no = 110022
                    ) AS manager_ID
                FROM
                    employees e
                    JOIN dept_emp de ON de.emp_no = e.emp_no
                WHERE
                    e.emp_no = 110039
                GROUP BY
                    e.emp_no
                ORDER BY
                    e.emp_no
            ) AS D
    ) AS U;
    
INSERT INTO
    emp_manager
SELECT
    U.*
FROM
    (
        -- A: Employees 10001–10020 → manager 110022
        SELECT
            e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            110022 AS manager_ID
        FROM
            employees e
            JOIN dept_emp de USING (emp_no)
        WHERE
            e.emp_no BETWEEN 10001 AND 10020
        GROUP BY
            e.emp_no
        UNION
        -- B: Employees 10021–10040 → manager 110039
        SELECT
            e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            110039 AS manager_ID
        FROM
            employees e
            JOIN dept_emp de USING (emp_no)
        WHERE
            e.emp_no BETWEEN 10021 AND 10040
        GROUP BY
            e.emp_no
        UNION
        -- C: Manager 110039 manages 110022
        SELECT
            110022 AS employee_ID,
            MIN(dept_emp.dept_no) AS department_code,
            110039 AS manager_ID
        FROM
            dept_emp
        WHERE
            emp_no = 110022
        UNION
        -- D: Manager 110022 manages 110039
        SELECT
            110039 AS employee_ID,
            MIN(dept_emp.dept_no) AS department_code,
            110022 AS manager_ID
        FROM
            dept_emp
        WHERE
            emp_no = 110039
    ) AS U;
    
SELECT 
    *
FROM
    emp_manager;
    
SELECT 
    t.emp_no,
    t.title,
    (SELECT 
            ROUND(AVG(salary), 2)
        FROM
            salaries s
        WHERE
            s.emp_no = t.emp_no) AS average_salary
FROM
    (SELECT 
        emp_no, title
    FROM
        titles
    WHERE
        title IN ('Staff' , 'Engineer')) AS t
ORDER BY avg_salary DESC;