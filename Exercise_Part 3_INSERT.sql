SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO employees 
(
	emp_no, 
    birth_date, 
    first_name, 
    last_name, 
    gender, 
    hire_date
) VALUES 
(
	999901,  # INTEGERS CAN BE IN '' AS WELL AZ STRINGS BUT DON'T DO IT
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
);

SELECT 
    *
FROM
    employees;

INSERT INTO employees 
(
	birth_date, 
    emp_no,
    first_name, 
    last_name, 
    gender, 
    hire_date
) VALUES 
(
	'1973-04-21',
    999902,
    'Patricia',
    'Lawrence',
    'F',
    '2005-01-01'
);


INSERT INTO employees 
VALUES 
(
	999903,
    '1977-09-14',
    'Creek',
    'Joghnatan',
    'M',
    '2005-01-01'
);

INSERT INTO test 
(
	test
) 
VALUES 
(
	10.5
);

INSERT INTO employees 
VALUES
(
     999905,
    '1965-03-12',
    'Patrick',
    'Huston',
    'M',
    '2000-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO employees 
VALUES
(
     999906,
    '1967-02-14',
    'John',
    'Miller',
    'M',
    '1997-06-01'
);

SELECT 
    *
FROM
    titles
LIMIT 10;

INSERT INTO titles 
(
	emp_no, 
    title, 
    from_date
)
VALUES 
(
	999903, 
    'Senior Engineer', 
    '1997-10-01'
);

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC;


INSERT INTO titles 
(
	emp_no, 
    title, 
    from_date
)
VALUES 
(
	999907, 
    'Assistant Engineer', 
    '1998-11-15'
);

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no desc;

INSERT INTO dept_emp
VALUES 
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

INSERT INTO departments
VALUES 
(
	'd010', 
    'Business Analysis'
);

SELECT 
    *
FROM
    departments
ORDER BY dept_no ASC;

CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT 
    *
FROM
    departments_dup;
	
INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT 
    *
FROM
    departments;
    
CREATE TABLE dept_emp_dup (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    PRIMARY KEY (emp_no,dept_no)
);

INSERT INTO dept_emp_dup 
(
	emp_no, 
    dept_no, 
    from_date, 
    to_date
) 
SELECT 
	* 
FROM 
	dept_emp;

SELECT 
    *
FROM
    dept_emp;

SELECT 
    *
FROM
    dept_emp_dup;