/*
ROUTINES, PROCEDURES AND VARIABLES
*/

USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN 
	SELECT * FROM employees
	LIMIT 1000;
END$$

DELIMITER ;

CALL employees.select_employees();

-- CALL employees.select_employees; willwork perfectly fine, but not so professional

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN 
	SELECT ROUND(AVG(salary),2) AS avg_salary FROM salaries;
END$$

DELIMITER ;

CALL employees.avg_salary();

SELECT ROUND(AVG(salary),2) AS avg_salary FROM salaries;

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_salaries`()
BEGIN
	SELECT * FROM salaries LIMIT 1000;
END;
*/

DROP PROCEDURE new_procedure;

SELECT 
    COUNT(emp_no), gender
FROM
    employees
GROUP BY gender;


USE `employees`;
DROP procedure IF EXISTS `employees`.`count_by_gender`;
;

DELIMITER $$
USE `employees`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_by_gender`()
BEGIN
	SELECT 
		COUNT(emp_no), gender
	FROM
		employees
	GROUP BY gender;
END$$

DELIMITER ;

USE employees;
DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$	
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT 
    e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;
   
call employees.emp_salary(11300);

DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$	
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT 
    e.first_name, e.last_name, round(AVG(salary),2) AS avg_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no
GROUP BY e.emp_no;
END$$

DELIMITER ;
   
call employees.emp_avg_salary(11300);

DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$	
CREATE PROCEDURE emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
BEGIN
SELECT 
    AVG(s.salary)
INTO p_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;
   

/*
set @p_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @p_avg_salary);
select @p_avg_salary;
*/

DROP procedure IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(50), in p_last_name varchar(50), out p_emp_no integer)
BEGIN
SELECT 
    e.emp_no
INTO p_emp_no FROM
    employees e
WHERE
    e.first_name = p_first_name and
    e.last_name = p_last_name
    order by e.emp_no
    limit 1;
END$$

DELIMITER ;

/*
set @p_emp_no = 0;
call employees.emp_info('john', '', @p_emp_no);
select @p_emp_no;
*/

SELECT 
    *
FROM
    employees
LIMIT 10;

DROP procedure IF EXISTS emp_info;

/*THE COURSE VERSION

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN
                SELECT
                                e.emp_no
                INTO p_emp_no FROM
                               employees e
                WHERE
                                e.first_name = p_first_name
                                                AND e.last_name = p_last_name;
END$$

DELIMITER ;
*/

SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

## VARIABLES
SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300,@v_avg_salary);
SELECT @v_avg_salary;

SET @v_emp_no = 0;
CALL employees.emp_info('Aruna','Journel',@v_emp_no);
SELECT @v_emp_no;

## USER-DEFINED FUNCTIONS

USE employees;
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

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

SELECT f_emp_avg_salary(11300);

# SET @@global.log_bin_trust_function_creators := 1;



DELIMITER $$

CREATE FUNCTION f_emp_info (p_first_name varchar(50), p_last_name varchar(50)) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary DECIMAL(10,2);

SELECT 
	MAX(from_date)
INTO v_max_from_date
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    where e.first_name = p_first_name
    and e.last_name = p_last_name;
    
    SELECT 	
    (s.salary)
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
    and e.last_name = p_last_name
    and s.from_date = v_max_from_date;

RETURN v_salary;
END$$

DELIMITER ;

select employees.f_emp_info('Georgi', 'Facello');


SET @v_emp_no = 11300; 

SELECT 
    emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM
    employees
WHERE
    emp_no = @v_emp_no;



