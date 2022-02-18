CREATE DATABASE online_store;
USE online_store;

CREATE TABLE brands (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE categories (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE reviews (
id INT AUTO_INCREMENT PRIMARY KEY,
content TEXT,
rating DECIMAL(10, 2) NOT NULL,
picture_url VARCHAR(80) NOT NULL,
published_at DATETIME NOT NULL
);

CREATE TABLE products (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(40) NOT NULL,
price DECIMAL(19, 2) NOT NULL,
quantity_in_stock INT,
`description` TEXT,
brand_id INT NOT NULL,
category_id INT NOT NULL,
review_id INT,
CONSTRAINT `fk_products_brands`
FOREIGN KEY (brand_id)
REFERENCES brands(id),
CONSTRAINT `fk_products_categories`
FOREIGN KEY (category_id)
REFERENCES categories(id),
CONSTRAINT `fk_products_reviews`
FOREIGN KEY (review_id)
REFERENCES reviews(id) 
);

CREATE TABLE customers (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
phone VARCHAR(30) UNIQUE NOT NULL,
address VARCHAR(60) NOT NULL,
discount_card BIT(1) NOT NULL DEFAULT FALSE
);

CREATE TABLE orders (
id INT AUTO_INCREMENT PRIMARY KEY,
order_datetime DATETIME NOT NULL,
customer_id INT NOT NULL,
CONSTRAINT `fk_orders_customers`
FOREIGN KEY (customer_id)
REFERENCES customers(id)
);

CREATE TABLE orders_products (
order_id INT,
product_id INT,
CONSTRAINT `fk_orders_products_orders`
FOREIGN KEY (order_id)
REFERENCES orders(id),
CONSTRAINT `fk_orders_products_products`
FOREIGN KEY (product_id)
REFERENCES products(id)
);

-- 2
INSERT INTO reviews (`content`, `picture_url`, `published_at`, `rating`)
SELECT LEFT(`description`, 15) AS content, REVERSE(`name`), '2010-10-10' AS published_at, price / 8 AS rating 
FROM products
WHERE id >= 5;

-- 3
UPDATE products
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock BETWEEN 60 AND 70;

-- 4
DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);

-- 5
SELECT * FROM categories
ORDER BY `name` DESC;

-- 6
SELECT id, brand_id, `name`, quantity_in_stock
FROM products
WHERE  price > 1000 AND quantity_in_stock < 30
ORDER BY quantity_in_stock, id;

-- 7
SELECT id, content, rating, picture_url, published_at
FROM reviews
WHERE content LIKE 'My%' AND CHAR_LENGTH(content) > 61
ORDER BY rating DESC;

-- 8 
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name, address, order_datetime 
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE YEAR(order_datetime) <= 2018
ORDER BY full_name DESC;

-- 9
SELECT COUNT(*) AS items_count, categories.`name`, SUM(quantity_in_stock) AS total_quantity
FROM categories
LEFT JOIN products ON categories.id = products.category_id
GROUP BY categories.id
ORDER BY items_count DESC, total_quantity
LIMIT 5;

-- 10
DELIMITER //

CREATE FUNCTION `udf_customer_products_count` (`name` VARCHAR(30))
RETURNS INTEGER
DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(*) AS total_products
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN orders_products ON orders.id = orders_products.order_id
WHERE first_name = `name`);
END //

DELIMITER ;

-- 11
DELIMITER //

CREATE PROCEDURE `udp_reduce_price` (category_name VARCHAR(50))
BEGIN
UPDATE products
JOIN categories ON products.category_id = categories.id
JOIN reviews ON products.review_id = reviews.id
SET price = price * 0.7
WHERE categories.`name` = category_name AND rating < 4;
END //

DELIMITER ;