SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;

SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;


DELETE FROM employees 
WHERE
    emp_no = 999903;

ROLLBACK;

COMMIT;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup;

ROLLBACK;

COMMIT;

DELETE FROM departments 
WHERE
    dept_no = 'd010';
    
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

/* 

TRUNCATE is like DELETE without the WHERE clause and is muuuch faster, 
cause it is not working row by row like DELETE. Auto-increment values are reset with TRUNCATE;

DROP deletes everything - no structure, indexes and constraints of the table remains and cannot be reversed with ROLLBACK;

DELETE - auto-increment values are not reset with DELETE
*/