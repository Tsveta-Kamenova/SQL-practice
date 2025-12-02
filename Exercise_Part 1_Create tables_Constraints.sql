/* DATA TYPES */

CREATE TABLE test (
    test DECIMAL(5 , 3 )
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

CREATE TABLE customers (
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
    warehouse_location VARCHAR(20)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    order_info INT,
    order_value INT,
    order_currency VARCHAR(10)
);

CREATE TABLE products (
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

CREATE TABLE sales (
    purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (purchase_number)
);

USE sales;

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);  
   
DROP TABLE customers;

CREATE TABLE items (
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255),
    PRIMARY KEY (item_code)
);

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
    PRIMARY KEY (company_id)
);

CREATE TABLE order_info (
    order_info_id INT AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    product_quantity INT,
    PRIMARY KEY (order_info_id)
);

DROP TABLE sales;

CREATE TABLE sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_number)
);

ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

DROP TABLE sales;

DROP TABLE customers;

DROP TABLE items;

DROP TABLE companies;

DROP TABLE order_info;

CREATE TABLE order_info (
    order_info_id INT AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    product_quantity INT,
    PRIMARY KEY (order_info_id)
);

ALTER TABLE order_info
ADD FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;

CREATE TABLE order_info (
    order_info_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    product_quantity INT,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    order_info INT,
    order_value INT,
    order_currency VARCHAR(10),
    FOREIGN KEY (order_info)
        REFERENCES order_info (order_info_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);

ALTER TABLE customers
DROP INDEX email_address;

DROP TABLE customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender CHAR(1),
    email_address VARCHAR(255),
    number_of_complaints INT DEFAULT 0,
    PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

INSERT INTO customers (first_name, last_name)
VALUES ('Jo', 'Mack');

SELECT 
    *
FROM
    customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20),
    product_price INT,
    warehouse_id INT,
    FOREIGN KEY (warehouse_id)
        REFERENCES warehouse (warehouse_id)
);

ALTER TABLE products
ADD UNIQUE KEY (product_name);

ALTER TABLE products
DROP INDEX product_name_2;

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
    PRIMARY KEY (company_id),
    UNIQUE KEY (headquarters_phone_number)
);

DROP TABLE products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20) DEFAULT 'no-name',
    product_price INT,
    warehouse_id INT,
    FOREIGN KEY (warehouse_id)
        REFERENCES warehouse (warehouse_id),
    UNIQUE KEY (product_name)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;

CREATE TABLE products 
(
    product_id 		INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    product_name 	VARCHAR(20) DEFAULT 'no-name' NOT NULL,
    product_price 	INT NOT NULL,
    warehouse_id 	INT NOT NULL,
FOREIGN KEY (warehouse_id)
REFERENCES warehouse (warehouse_id),
UNIQUE KEY (product_name)
);

/* 
COMMENT, LARGE ONE
*/
 
 # smaller comment
 
 -- another small comment