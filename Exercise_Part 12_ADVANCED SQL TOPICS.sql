/*

LOCAL
SESSION
GLOBAL

VARIABLES

*/


# LOCAL VARIABLES

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

#BEGIN 
# DECLARE v_avg_salary_2 DECIMAL (10,2);
#END;
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$

DELIMITER ;

select v_avg_salary;
SELECT f_emp_avg_salary(11300);


# SESSION VARIABLES
SET @s_var1 = 3;

select @s_var1;


# GLOBAL VARIABLES
SET GLOBAL var_name = value;
SET @@global.var_name = value;

# .max_connections()
# .max_join_size()

SET GLOBAL max_connections = 1000;

SET @@global.max_connections = 50;

# ERROR
# SET SESSION max_connections = 1000;

SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
# SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'; WAS WORKING PREVIOUSLY IN OLDER VERSIONS

SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';

DROP PROCEDURE IF EXISTS emp_salary;

SET @v_emp_no = 10004;
 
SELECT 
    emp_no,
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    emp_no = @v_emp_no;