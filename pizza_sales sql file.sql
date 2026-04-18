CREATE TABLE pizza_sales (
    pizza_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

select * from pizza_sales;

1. Total Revenue

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

2. Average Order Value

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

3. Total Pizzas Sold

SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales;

4. Total Orders

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

5. Average Pizzas Per Order

SELECT ROUND(SUM(quantity)::numeric / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;

B. Daily Trend for Total Orders
SELECT TO_CHAR(order_date, 'Day') AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day
ORDER BY MIN(order_date);

C. Monthly Trend for Orders
SELECT TO_CHAR(order_date, 'Month') AS month_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY month_name
ORDER BY MIN(order_date);

D. % of Sales by Pizza Category
SELECT pizza_category,
       ROUND(SUM(total_price), 2) AS total_revenue,
       ROUND(SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER (), 2) AS pct
FROM pizza_sales
GROUP BY pizza_category;

E. % of Sales by Pizza Size
SELECT pizza_size,
       ROUND(SUM(total_price), 2) AS total_revenue,
       ROUND(SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER (), 2) AS pct
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

F. Total Pizzas Sold by Pizza Category (for February)
SELECT pizza_category,
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

G. Top 5 Pizzas by Revenue
SELECT pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

H. Bottom 5 Pizzas by Revenue
SELECT pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

I. Top 5 Pizzas by Quantity
SELECT pizza_name,
       SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

J. Bottom 5 Pizzas by Quantity
SELECT pizza_name,
       SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;

K. Top 5 Pizzas by Total Orders
SELECT pizza_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

L. Bottom 5 Pizzas by Total Orders
SELECT pizza_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;