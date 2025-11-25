-- ORDER BY

SELECT DISTINCT release_year, type
FROM  netflix.netflix_titles
ORDER BY release_year ASC, type ASC;

SELECT DISTINCT productLine
FROM classicmodels.products
ORDER BY productLine DESC;

SELECT DISTINCT country, city
FROM classicmodels.customers
ORDER BY country, city;

-- WHERE 

SELECT * 
FROM netflix_titles
WHERE release_year="2018"
AND type="TV show" 
AND (duration="9 seasons"
OR duration = "8 seasons");

SELECT *
FROM netflix.netflix_titles
WHERE release_year IN (2021)
AND date_added IN 
("September 14, 2021",
"September 7, 2021",
"July 15, 2021");

SELECT * 
FROM classicmodels.products
WHERE productLine NOT IN
("Classic cars",
"Vintage cars");

SELECT * 
FROM classicmodels.orders
WHERE comments LIKE "%or_er%";

SELECT * 
FROM netflix.netflix_titles
WHERE title LIKE "%G_ME%";

SELECT * 
FROM netflix.netflix_titles
WHERE title NOT LIKE "%GAME%";

-- JOIN

SELECT *
FROM netflix_titles
INNER JOIN show_director
ON netflix_titles.show_id=show_director.show_id
INNER JOIN directors
ON show_director.director_id = directors.director_id;

SELECT *
FROM netflix_titles
LEFT JOIN show_director
ON netflix_titles.show_id = show_director.show_id
LEFT JOIN directors
ON show_director.director_id=directors.director_id;

SELECT * 
FROM classicmodels.customers cust
LEFT JOIN classicmodels.orders ord
ON cust.customerNumber = ord.customerNumber
WHERE ord.orderNumber IS NULL;

SELECT customerName, city, orderDate, orderNumber
FROM classicmodels.orders ord
RIGHT JOIN classicmodels.customers cust
ON ord.customerNumber = cust.customerNumber;

SELECT customerName, city, orderDate, orderNumber
FROM classicmodels.customers cust
LEFT JOIN classicmodels.orders ord
ON cust.customerNumber = ord.customerNumber;

SELECT 
	emp.firstName as employee_name, 
    emp.lastName as employee_last_name, 
	emp_2.firstName as reports_to_firstname, 
    emp_2.lastName as reports_to_lastName
FROM classicmodels.employees emp
LEFT JOIN classicmodels.employees emp_2
ON emp.reportsTo = emp_2.employeeNumber;

SELECT * 
FROM classicmodels.customers c
INNER JOIN classicmodels.payments p
ON c.customerNumber = p.customerNumber;

SELECT * 
FROM classicmodels.customers c
LEFT JOIN classicmodels.payments p
ON c.customerNumber = p.customerNumber
WHERE p.customerNumber IS NULL;

SELECT * 
FROM netflix.netflix_titles t
LEFT JOIN netflix.rating r
ON t.Rating_ID = r.Rating_ID;

-- UNION 

SELECT 
	netflix.cast.Name,
    'Cast' as Type
FROM netflix.cast
WHERE netflix.cast.Name = 'Seth Rogen'
UNION ALL
SELECT 
	netflix.directors.Director_Name,
    'Director' as Type
FROM netflix.directors
WHERE netflix.directors.Director_Name = 'Seth Rogen';

-- AGGREGATION

SELECT 
	MIN(classicmodels.orders.orderDate) as first_order
FROM classicmodels.orders;

SELECT 
	MAX(classicmodels.orders.orderDate) as last_order
FROM classicmodels.orders;

SELECT 
	SUM(classicmodels.orderdetails.quantityOrdered) as total_quantity
FROM classicmodels.orderdetails;

SELECT 
	COUNT(DISTINCT classicmodels.orderdetails.orderNumber) as count_products
FROM classicmodels.orderdetails;

SELECT
	classicmodels.payments.paymentDate,
	SUM(classicmodels.payments.amount) as total_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.paymentDate
ORDER BY total_payments_to_date;

SELECT
	classicmodels.payments.paymentDate,
	AVG(classicmodels.payments.amount) as average_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.paymentDate
ORDER BY average_payments_to_date;

SELECT 
	cust.customerName, 
	MIN(ord.orderDate) AS first_order,
    MAX(ord.orderDate) AS last_order
FROM classicmodels.orders ord
INNER JOIN classicmodels.customers cust
ON ord.customerNumber = cust.customerNumber
GROUP BY cust.customerName;

SELECT 
	cust.customerName, 
	COUNT(DISTINCT ord.orderNumber) AS orders_placed
FROM classicmodels.orders ord
INNER JOIN classicmodels.customers cust
ON ord.customerNumber = cust.customerNumber
GROUP BY cust.customerName
ORDER BY orders_placed DESC;

SELECT 
	cust.customerName, 
	COUNT(DISTINCT ord.orderNumber) AS orders_placed, 
	MIN(ord.orderDate) AS first_order,
    MAX(ord.orderDate) AS last_order
FROM classicmodels.orders ord
INNER JOIN classicmodels.customers cust
ON ord.customerNumber = cust.customerNumber
GROUP BY cust.customerName
ORDER BY orders_placed DESC;

-- SUBQUERIES

SELECT
	AVG(total_payments_to_date)
FROM
(SELECT
	classicmodels.payments.paymentDate,
	SUM(classicmodels.payments.amount) as total_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.paymentDate) T1;

SELECT 
	customerName, 
    AVG(order_value) as average_order_value
FROM
(SELECT 
	c.customerName,
    ord.orderDate,
    ord.orderNumber,
    SUM(det.priceEach * det.quantityOrdered) order_value
FROM classicmodels.orders ord
INNER JOIN classicmodels.orderdetails det
ON ord.orderNumber = det.orderNumber
INNER JOIN classicmodels.customers c
ON ord.customerNumber = c.customerNumber
GROUP BY c.customerName, ord.orderDate, ord.orderNumber) t1
GROUP BY customerName;

SELECT
	classicmodels.payments.customerNumber,
	SUM(classicmodels.payments.amount) as total_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.customerNumber;

SELECT cust.*, pay.total_payments_to_date
FROM classicmodels.customers cust
INNER JOIN 
(SELECT
	classicmodels.payments.customerNumber,
	SUM(classicmodels.payments.amount) as total_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.customerNumber) pay
ON cust.customerNumber = pay.customerNumber;

SELECT cust.*, pay.total_payments_to_date
FROM classicmodels.customers cust
LEFT JOIN 
(SELECT
	classicmodels.payments.customerNumber,
	SUM(classicmodels.payments.amount) as total_payments_to_date
FROM classicmodels.payments
GROUP BY classicmodels.payments.customerNumber) pay
ON cust.customerNumber = pay.customerNumber
WHERE pay.total_payments_to_date IS NULL;

-- CASE

SELECT 
	netflix_titles.release_year, 
    netflix_titles.title,
CASE 
	WHEN netflix_titles.release_year < 2000 THEN 'Old'
	WHEN  netflix_titles.release_year BETWEEN 2001 AND 2010 THEN 'Recent'
ELSE 'New'
END AS category_year
FROM netflix_titles;

SELECT 
	netflix_titles.title,
    netflix_titles.release_year, 
CASE 
	WHEN  release_year BETWEEN 2000 AND 2099 THEN '21st'
    WHEN  release_year BETWEEN 1900 AND 1999 THEN '20th'
ELSE 'Other'
END AS century
FROM netflix_titles;

SELECT 
	century, 
	COUNT(t.title) as count_of_titles
FROM
(SELECT 
	netflix_titles.title,
    netflix_titles.release_year, 
CASE 
	WHEN  netflix_titles.release_year BETWEEN 2000 AND 2099 THEN '21st'
    WHEN  netflix_titles.release_year BETWEEN 1900 AND 1999 THEN '20th'
ELSE 'Other'
END AS century
FROM netflix_titles) t
GROUP BY century;



-- TASKS

-- Calculate the average order amount for each country
SELECT 
	c.country, 
    AVG(od.quantityOrdered * od.priceEach) AS avg_order_amount
FROM classicmodels.customers c
JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country;

-- Calculate the total sales amount for each product line
SELECT pl.productLine, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM classicmodels.orderdetails od
JOIN classicmodels.products p ON od.productCode = p.productCode
JOIN classicmodels.productlines pl ON p.productLine = pl.productLine
GROUP BY pl.productLine
ORDER BY total_sales DESC;

-- List the top 10 best-selling products based on total quantity sold
SELECT p.productName, SUM(od.quantityOrdered) AS total_quantity_sold
FROM classicmodels.orderdetails od
JOIN classicmodels.products p ON od.productCode = p.productCode
GROUP BY p.productName
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Evaluate the sales performance of each sales representative
SELECT 
	e.firstName,
	e.lastName, 
	SUM(p.amount) AS total_sales
FROM classicmodels.employees e
LEFT JOIN classicmodels.customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
GROUP BY e.firstName, e.lastName
ORDER BY total_sales DESC;

-- Calculate the average number of orders placed by each customer
SELECT COUNT(o.orderNumber) / COUNT(DISTINCT c.customerNumber) AS avg_orders_per_customer
FROM classicmodels.customers c
LEFT JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber;

-- Calculate the percentage of orders that were shipped on time
SELECT 
    SUM(CASE WHEN o.shippedDate <= o.requiredDate THEN 1 ELSE 0 END) / COUNT(*) * 100 AS percentage_on_time
FROM orders o;
SELECT *
FROM orders o
WHERE o.shippedDate >= o.requiredDate;

-- Calculate the profit margin for each product by subtracting the cost of goods sold (COGS) from the sales revenue
SELECT 
    p.productCode,
    p.productName,
    (SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice)) AS profit_margin
FROM 
    classicmodels.products p
JOIN 
    classicmodels.orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode, p.productName;

-- Segment customers based on their total purchase amount
SELECT 
	customerNumber,
    total_purchase_amount,
	CASE 
		WHEN  total_purchase_amount > 100000 THEN 'High'
		WHEN  total_purchase_amount BETWEEN 50000 AND 100000 THEN 'Medium'
	ELSE 'Low'
	END AS customer_segment
FROM
(
SELECT 
	ord.customerNumber, 
    SUM(det.quantityOrdered * det.priceEach) AS total_purchase_amount
FROM classicmodels.orderdetails det
JOIN classicmodels.orders ord
ON det.orderNumber = ord.orderNumber
GROUP BY ord.customerNumber
) AS customer_purchase_amounts;

    
SELECT *
FROM classicmodels.customers c
LEFT JOIN 
(
SELECT 
    customer_purchase_amounts.customerNumber,
    total_purchase_amount,
    CASE 
        WHEN total_purchase_amount > 100000 THEN 'High Value'
        WHEN total_purchase_amount > 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM 
    (
    SELECT 
		ord.customerNumber, 
        SUM(det.quantityOrdered * det.priceEach) AS total_purchase_amount
     FROM classicmodels.orderdetails det
     INNER JOIN classicmodels.orders ord ON det.orderNumber = ord.orderNumber
     GROUP BY ord.customerNumber
     ) 
     AS customer_purchase_amounts
) v
ON c.customerNumber = v.customerNumber
;

-- Identify frequently co-purchased products to understand cross-selling opportunities
SELECT 
    od1.productCode AS product1,
    p1.productname AS productname1, 
    od2.productCode AS product2,
    p2.productname AS productname2,
    COUNT(*) AS co_purchase_count
FROM 
    orderdetails od1
JOIN 
    orderdetails od2 ON od1.orderNumber = od2.orderNumber AND od1.productCode <> od2.productCode
JOIN 
	products p1 ON od1.productCode = p1.productCode
JOIN 
	products p2 ON od2.productCode = p2.productCode
GROUP BY 
    product1, productname1, product2, productname2
ORDER BY 
    co_purchase_count DESC;
    












