-- =========================================
-- RETAIL SALES SQL PROJECT
-- =========================================

-- =========================================
-- CREATE TABLE
-- =========================================

CREATE TABLE sales (
    order_id INTEGER,
    order_date TEXT,
    customer_name TEXT,
    region TEXT,
    category TEXT,
    product_name TEXT,
    quantity INTEGER,
    sales REAL,
    profit REAL
);

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================

INSERT INTO sales VALUES
(1, '2025-01-01', 'Alice', 'North', 'Technology', 'Laptop', 2, 1200, 300),
(2, '2025-01-02', 'Bob', 'South', 'Furniture', 'Chair', 5, 500, 100),
(3, '2025-01-03', 'Charlie', 'East', 'Office Supplies', 'Notebook', 10, 150, 40),
(4, '2025-01-05', 'David', 'West', 'Technology', 'Phone', 3, 900, 200),
(5, '2025-01-07', 'Emma', 'North', 'Furniture', 'Table', 1, 350, 80),
(6, '2025-01-10', 'Frank', 'South', 'Technology', 'Keyboard', 4, 200, 50),
(7, '2025-01-12', 'Grace', 'East', 'Office Supplies', 'Pen', 20, 100, 30),
(8, '2025-01-15', 'Helen', 'West', 'Furniture', 'Cupboard', 1, 800, 150),
(9, '2025-02-01', 'Henry', 'North', 'Technology', 'Monitor', 2, 500, 120),
(10, '2025-02-03', 'Isabella', 'East', 'Furniture', 'Sofa', 1, 700, 150),
(11, '2025-02-05', 'Jack', 'South', 'Office Supplies', 'Printer Paper', 15, 75, 20),
(12, '2025-02-06', 'Karen', 'West', 'Technology', 'Tablet', 3, 900, 250),
(13, '2025-02-08', 'Leo', 'North', 'Furniture', 'Bookshelf', 1, 250, 60),
(14, '2025-02-10', 'Mia', 'East', 'Technology', 'Headphones', 5, 400, 90),
(15, '2025-02-12', 'Nathan', 'South', 'Furniture', 'Lamp', 4, 180, 50),
(16, '2025-02-15', 'Olivia', 'West', 'Office Supplies', 'Stapler', 10, 60, 15),
(17, '2025-02-18', 'Paul', 'North', 'Technology', 'Camera', 1, 650, 180),
(18, '2025-02-20', 'Queen', 'East', 'Furniture', 'Cabinet', 2, 500, 140);

-- =========================================
-- VIEW ALL DATA
-- =========================================

SELECT * FROM sales;

-- =========================================
-- TOTAL SALES
-- =========================================

SELECT SUM(sales) AS total_sales
FROM sales;

-- =========================================
-- TOTAL PROFIT
-- =========================================

SELECT SUM(profit) AS total_profit
FROM sales;

-- =========================================
-- SALES BY REGION
-- =========================================

SELECT region,
       SUM(sales) AS total_sales
FROM sales
GROUP BY region;

-- =========================================
-- SALES BY CATEGORY
-- =========================================

SELECT category,
       SUM(sales) AS total_sales
FROM sales
GROUP BY category;

-- =========================================
-- BEST SELLING PRODUCTS
-- =========================================

SELECT product_name,
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC;

-- =========================================
-- HIGHEST PROFIT PRODUCTS
-- =========================================

SELECT product_name,
       SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC;

-- =========================================
-- MONTHLY SALES TREND
-- =========================================

SELECT substr(order_date,1,7) AS month,
       SUM(sales) AS monthly_sales
FROM sales
GROUP BY month;

-- =========================================
-- FILTER TECHNOLOGY PRODUCTS
-- =========================================

SELECT *
FROM sales
WHERE category = 'Technology';

-- =========================================
-- SALES GREATER THAN 500
-- =========================================

SELECT *
FROM sales
WHERE sales > 500;

-- =========================================
-- NORTH REGION SALES
-- =========================================

SELECT *
FROM sales
WHERE region = 'North';

-- =========================================
-- TOTAL ORDERS
-- =========================================

SELECT COUNT(*) AS total_orders
FROM sales;

-- =========================================
-- ORDERS PER REGION
-- =========================================

SELECT region,
       COUNT(*) AS total_orders
FROM sales
GROUP BY region;

-- =========================================
-- AVERAGE SALES
-- =========================================

SELECT AVG(sales) AS average_sales
FROM sales;

-- =========================================
-- AVERAGE PROFIT BY CATEGORY
-- =========================================

SELECT category,
       AVG(profit) AS average_profit
FROM sales
GROUP BY category;

-- =========================================
-- TOP 3 HIGHEST SALES
-- =========================================

SELECT *
FROM sales
ORDER BY sales DESC
LIMIT 3;

-- =========================================
-- UNIQUE CATEGORIES
-- =========================================

SELECT DISTINCT category
FROM sales;

-- =========================================
-- REGION WITH HIGHEST PROFIT
-- =========================================

SELECT region,
       SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC
LIMIT 1;

-- =========================================
-- CUSTOMER WITH HIGHEST PURCHASE
-- =========================================

SELECT customer_name,
       SUM(sales) AS total_purchase
FROM sales
GROUP BY customer_name
ORDER BY total_purchase DESC;

-- =========================================
-- CATEGORY WITH MOST SALES
-- =========================================

SELECT category,
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY category
ORDER BY total_quantity DESC;

-- =========================================
-- HAVING CLAUSE
-- =========================================

SELECT region,
       SUM(sales) AS total_sales
FROM sales
GROUP BY region
HAVING total_sales > 1000;

-- =========================================
-- CASE WHEN
-- =========================================

SELECT product_name,
       profit,

       CASE
           WHEN profit >= 100 THEN 'High Profit'
           WHEN profit >= 50 THEN 'Medium Profit'
           ELSE 'Low Profit'
       END AS profit_category

FROM sales;

-- =========================================
-- SUBQUERY
-- =========================================

SELECT product_name,
       sales
FROM sales
WHERE sales >
(
    SELECT AVG(sales)
    FROM sales
);

-- =========================================
-- HIGHEST PROFIT PRODUCT
-- =========================================

SELECT product_name,
       profit
FROM sales
WHERE profit =
(
    SELECT MAX(profit)
    FROM sales
);

-- =========================================
-- CTE EXAMPLE
-- =========================================

WITH regional_sales AS
(
    SELECT region,
           SUM(sales) AS total_sales
    FROM sales
    GROUP BY region
)

SELECT *
FROM regional_sales;

-- =========================================
-- CTE WITH FILTER
-- =========================================

WITH regional_sales AS
(
    SELECT region,
           SUM(sales) AS total_sales
    FROM sales
    GROUP BY region
)

SELECT *
FROM regional_sales
WHERE total_sales > 1500;

-- =========================================
-- ROW NUMBER
-- =========================================

SELECT product_name,
       sales,

       ROW_NUMBER() OVER
       (
           ORDER BY sales DESC
       ) AS ranking

FROM sales;

-- =========================================
-- RANK FUNCTION
-- =========================================

SELECT product_name,
       sales,

       RANK() OVER
       (
           ORDER BY sales DESC
       ) AS sales_rank

FROM sales;

-- =========================================
-- RUNNING TOTAL
-- =========================================

SELECT order_date,
       sales,

       SUM(sales) OVER
       (
           ORDER BY order_date
       ) AS running_total

FROM sales;

-- =========================================
-- CREATE CUSTOMER TABLE
-- =========================================

CREATE TABLE customers (
    customer_name TEXT,
    city TEXT,
    age INTEGER
);

-- =========================================
-- INSERT CUSTOMER DATA
-- =========================================

INSERT INTO customers VALUES
('Alice', 'Chennai', 28),
('Bob', 'Delhi', 35),
('Charlie', 'Mumbai', 30),
('David', 'Bangalore', 40),
('Emma', 'Hyderabad', 25),
('Frank', 'Pune', 33),
('Grace', 'Kolkata', 29);

-- =========================================
-- VIEW CUSTOMERS
-- =========================================

SELECT * FROM customers;

-- =========================================
-- INNER JOIN
-- =========================================

SELECT s.customer_name,
       s.product_name,
       s.sales,
       c.city

FROM sales s

INNER JOIN customers c
ON s.customer_name = c.customer_name;

-- =========================================
-- LEFT JOIN
-- =========================================

SELECT s.customer_name,
       s.product_name,
       c.city

FROM sales s

LEFT JOIN customers c
ON s.customer_name = c.customer_name;

-- =========================================
-- TOP 5 CUSTOMERS
-- =========================================

SELECT customer_name,
       SUM(sales) AS total_sales

FROM sales

GROUP BY customer_name

ORDER BY total_sales DESC

LIMIT 5;

-- =========================================
-- PROFIT MARGIN
-- =========================================

SELECT product_name,
       sales,
       profit,

       ROUND((profit * 100.0 / sales),2) AS profit_margin

FROM sales;