/* DATA TYPES */

CREATE TABLE test (
    test DECIMAL(5,3)
);

INSERT test VALUES (10.5);

SELECT 
    *
FROM
    test;

INSERT INTO test VALUES (12.55555);

ALTER TABLE `sales`.`test` 
ADD COLUMN `test_fl` FLOAT(5,3) NULL AFTER `test`;

INSERT INTO test(test_fl) VALUES (14.55555);

INSERT INTO test(test) VALUES (16.55555);

CREATE DATABASE IF NOT EXISTS sales;

CREATE SCHEMA IF NOT EXISTS sales;

USE sales;

CREATE TABLE customers
(
customer_id INT,
first_name VARCHAR(255), 
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT
);

SELECT 
	*
FROM
	employees;

CREATE TABLE warehouse (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_location VARCHAR (20)
);


CREATE TABLE orders
(
order_id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE,
order_info INT,
order_value INT,
order_currency VARCHAR(10)
);

CREATE TABLE products
(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(20),
product_price INT,
warehouse_id INT
);

/*
CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);
*/

DROP TABLE sales;

CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL,
PRIMARY KEY (purchase_number)
);

USE sales;

CREATE TABLE customers                                                              
(  
    customer_id INT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),  
    number_of_complaints int,  
primary key (customer_id)  
);  
   
DROP TABLE customers;

CREATE TABLE customers                                                    
(  
    customer_id INT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),   
    number_of_complaints int,   
primary key (customer_id)   
);  
 
CREATE TABLE items                                                                                                                              
(  
    item_code varchar(255),   
    item varchar(255),   
    unit_price numeric(10,2),   
    company_id varchar(255),
primary key (item_code)   
);  

CREATE TABLE companies   
(
    company_id varchar(255),   
    company_name varchar(255),  
    headquarters_phone_number int(12),   
primary key (company_id)   
);

CREATE TABLE order_info
(
	order_info_id INT AUTO_INCREMENT,
	order_id  INT,
	product_id INT,
	product_quantity INT,
PRIMARY KEY (order_info_id)
);

USE employees;

SELECT * FROM employees;

SELECT * FROM employees.employees;
