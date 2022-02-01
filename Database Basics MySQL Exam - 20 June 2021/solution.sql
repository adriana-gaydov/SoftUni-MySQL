CREATE DATABASE stc;
USE stc;

CREATE TABLE addresses (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(100) NOT NULL
);

CREATE TABLE categories (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(10) NOT NULL
);

CREATE TABLE clients (
id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE drivers (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
age INT NOT NULL,
rating FLOAT DEFAULT 5.5 
);

CREATE TABLE cars (
id INT AUTO_INCREMENT PRIMARY KEY,
make VARCHAR(20) NOT NULL,
model VARCHAR(20),
`year` INT DEFAULT 0 NOT NULL,
mileage INT DEFAULT 0,
`condition` CHAR(1) NOT NULL,
category_id INT NOT NULL,
CONSTRAINT `fk_cars_categories`
FOREIGN KEY (category_id) 
REFERENCES categories(id)
);

CREATE TABLE courses (
id INT AUTO_INCREMENT PRIMARY KEY,
from_address_id INT NOT NULL,
`start` DATETIME NOT NULL,
`bill` DECIMAL(10, 2) DEFAULT 10,
car_id INT NOT NULL,
client_id INT NOT NULL,
CONSTRAINT `fk_courses_addresses`
FOREIGN KEY (from_address_id)
REFERENCES addresses(id),
CONSTRAINT `fk_courses_cars`
FOREIGN KEY (car_id)
REFERENCES cars(id),
CONSTRAINT `fk_courses_clients`
FOREIGN KEY (client_id)
REFERENCES clients(id)
);

CREATE TABLE cars_drivers (
car_id INT NOT NULL,
driver_id INT NOT NULL,
CONSTRAINT `pk_cars_drivers`
PRIMARY KEY (car_id, driver_id),
CONSTRAINT `fk_cars_drivers_cars`
FOREIGN KEY (car_id) 
REFERENCES cars(id),
CONSTRAINT `fk_cars_drivers_drivers`
FOREIGN KEY (driver_id)
REFERENCES drivers(id)
);


-- 2
INSERT INTO clients (`full_name`, `phone_number`)
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name, CONCAT('(088) 9999', id*2) AS phone_number
FROM drivers 
WHERE id BETWEEN 10 AND 20;

-- 3
UPDATE cars
SET `condition` = 'C'
WHERE (mileage >= 800000  OR mileage IS NULL) AND `year` <=  2010 AND make != 'Mercedes-Benz';

-- 4
DELETE FROM clients
WHERE id NOT IN (SELECT client_id FROM courses) AND char_length(full_name) > 3;

-- 5
SELECT make, model, `condition` FROM cars
ORDER BY id;

-- 6
SELECT first_name, last_name, make, model, mileage 
FROM drivers AS d
JOIN cars_drivers AS cd ON d.id = cd.driver_id
JOIN cars AS c ON cd.car_id = c.id
WHERE mileage IS NOT NULL
ORDER BY mileage DESC, first_name;

-- 7
SELECT cars.id, make, mileage, COUNT(car_id) AS count_of_courses , ROUND(AVG(bill), 2) AS avg_bill 
FROM cars
LEFT JOIN courses ON courses.car_id = cars.id
GROUP BY cars.id
HAVING count_of_courses != 2
ORDER BY count_of_courses DESC, cars.id;

-- 8
SELECT full_name, COUNT(*) AS count_of_cars, SUM(bill) AS total_sum
FROM clients AS c
LEFT JOIN courses ON c.id = courses.client_id 
WHERE SUBSTR(full_name, 2, 1) = 'a'
GROUP BY c.id
HAVING count_of_cars > 1
ORDER BY full_name;

-- 9
SELECT 
    a.name,
    CASE
        WHEN HOUR(`start`) BETWEEN 6 AND 20 THEN 'Day'
        WHEN HOUR(`start`) >= 21 OR  HOUR(`start`) <= 5 THEN 'Night'
    END AS `day_time`,
    bill,
    full_name,
    make,
    model,
    categories.name
FROM
    courses AS c
        JOIN
    addresses AS a ON c.from_address_id = a.id
        JOIN
    clients ON c.client_id = clients.id
    JOIN cars ON cars.id = c.car_id
    JOIN categories ON cars.category_id = categories.id
    ORDER BY c.id;
    
    
-- 10
DELIMITER //

CREATE FUNCTION `udf_courses_by_client` (phone_num VARCHAR(20))
RETURNS INTEGER
DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(*) AS cnt FROM
courses AS c 
JOIN clients ON c.client_id = clients.id
WHERE phone_number = phone_num);
END//

DELIMITER ;

SELECT udf_courses_by_client ('(803) 6386812') as `count`;
SELECT udf_courses_by_client ('(831) 1391236') as `count`;


-- 11

DELIMITER //

CREATE PROCEDURE `udp_courses_by_address` (address_name VARCHAR(100))
DETERMINISTIC
BEGIN
SELECT 
    addresses.`name`,
    full_name,
    CASE
        WHEN bill <= 20 THEN 'Low'
        WHEN bill <= 30 THEN 'Medium'
        ELSE 'High'
    END AS level_of_bill,
    make,
    `condition`,
    categories.`name`
FROM
    addresses
        LEFT JOIN
    courses ON addresses.id = courses.from_address_id
        JOIN
    cars ON courses.car_id = cars.id
        JOIN
    categories ON cars.category_id = categories.id
        JOIN
    clients ON clients.id = courses.client_id
    WHERE addresses.`name` = address_name
    ORDER BY make, full_name;
END //

DELIMITER ;

CALL udp_courses_by_address('66 Thompson Drive');
