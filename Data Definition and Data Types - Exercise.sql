CREATE DATABASE  `minions`;
USE `minions`;

CREATE TABLE `minions` (
`id` INT AUTO_INCREMENT NOT NULL,
`name` VARCHAR(45),
`age` INT UNSIGNED,
CONSTRAINT `pk_minions`
PRIMARY KEY (`id`)
);

CREATE TABLE `towns` (
`town_id` INT AUTO_INCREMENT NOT NULL,
`name` VARCHAR(45),
CONSTRAINT `pk_towns`
PRIMARY KEY (`town_id`)
);

ALTER TABLE `towns`
CHANGE COLUMN `town_id` `id` INT AUTO_INCREMENT NOT NULL;

ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_minions_towns`
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);

INSERT INTO `towns` VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO `minions` VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

TRUNCATE `minions`;

DROP TABLE `minions`;
DROP TABLE `towns`; 

CREATE TABLE `people` (
`id` INT AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` DOUBLE(5,2),
`weight` DOUBLE(5,2),
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT,
CONSTRAINT `pk_people`
PRIMARY KEY (`id`)
);

INSERT INTO `people` (`name`, `gender`, `birthdate`)
VALUES 
('Test', 'M', DATE(NOW())),
('Test', 'M', DATE(NOW())),
('Test', 'M', DATE(NOW())),
('Test', 'M', DATE(NOW())),
('Test', 'M', DATE(NOW()));

CREATE TABLE `users` (
`id` INT AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` DATETIME,
`is_deleted` BOOLEAN,
CONSTRAINT `pk_users`
PRIMARY KEY (`id`)
);

INSERT INTO `users` (`username`, `password`)
VALUES 
('Test1', 'Pass'),
('Test2', 'Pass'),
('Test3', 'Pass'),
('Test4', 'Pass'),
('Test5', 'Pass');

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`, `username`);

ALTER TABLE `users`
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME DEFAULT NOW();

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`),
--CHANGE COLUMN `username` `username` VARCHAR(30) NOT NULL UNIQUE;
ADD CONSTRAINT `uk_users`
UNIQUE (`id`);

CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors` (
`id` INT AUTO_INCREMENT,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT,
CONSTRAINT `pk_directors`
PRIMARY KEY (`id`)
);

CREATE TABLE `genres` (
`id` INT AUTO_INCREMENT,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT,
CONSTRAINT `pk_genres`
PRIMARY KEY (`id`)
);

CREATE TABLE `categories` (
`id` INT AUTO_INCREMENT,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT,
CONSTRAINT `pk_categories`
PRIMARY KEY (`id`)
);

CREATE TABLE `movies` (
`id` INT AUTO_INCREMENT,
`title` VARCHAR(100) NOT NULL,
`director_id` INT,
`copyright_year` YEAR,
`length` INT,
`genre_id` INT,
`category_id` INT,
`rating` DECIMAL(5,2),
`notes` TEXT,
CONSTRAINT `pk_genres`
PRIMARY KEY (`id`)
);

INSERT INTO `directors`(`director_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `genres`(`genre_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `categories`(`category_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `movies` (`title`)
VALUES 
('TestMovie1'),
('TestMovie2'),
('TestMovie3'),
('TestMovie4'),
('TestMovie5');

CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories` (
`id` INT AUTO_INCREMENT,
`category` VARCHAR(50),
`daily_rate` DOUBLE,
`weekly_rate` DOUBLE,
`monthly_rate` DOUBLE,
`weekend_rate` DOUBLE,
CONSTRAINT `pk_categories`
PRIMARY KEY (`id`)
);

INSERT INTO `categories` (`category`)
VALUES 
('TestName1'),
('TestName2'),
('TestName3'); 

CREATE TABLE `cars` (
`id` INT AUTO_INCREMENT,
`plate_number` VARCHAR(20),
`make` VARCHAR(20),
`model` VARCHAR(20),
`car_year` YEAR,
`category_id` INT,
`doors` INT,
`picture` BLOB,
`car_condition` VARCHAR(30),
`available` BOOLEAN,
CONSTRAINT `pk_cars`
PRIMARY KEY (`id`)
);

INSERT INTO `cars` (`plate_number`)
VALUES 
('TestName1'),
('TestName2'),
('TestName3');

CREATE TABLE `employees` (
`id` INT AUTO_INCREMENT,
`first_name` VARCHAR(50),
`last_name` VARCHAR(50),
`title` VARCHAR(40),
`notes` TEXT,
CONSTRAINT `pk_employees`
PRIMARY KEY (`id`)
);

INSERT INTO `employees` (`first_name`, `last_name`)
VALUES 
('TestName1', 'TestName1'),
('TestName2', 'TestName2'),
('TestName3', 'TestName3');

CREATE TABLE `customers` (
`id` INT AUTO_INCREMENT,
`driver_licence_number` VARCHAR(20),
`full_name` VARCHAR(100),
`address` VARCHAR(60),
`city` VARCHAR(20),
`zip_code` VARCHAR(10),
`notes` TEXT,
CONSTRAINT `pk_customers`
PRIMARY KEY (`id`)
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`)
VALUES 
('TestName1', 'TestName1'),
('TestName2', 'TestName2'),
('TestName3', 'TestName3');

CREATE TABLE `rental_orders` (
`id` INT AUTO_INCREMENT,
`employee_id` INT,
`customer_id` INT,
`car_id` INT,
`car_condition` VARCHAR(40),
`tank_level` VARCHAR(20),
`kilometrage_start` INT,
`kilometrage_end` INT,
`total_kilometrage` INT,
`start_date` DATE,
`end_date` DATE,
`total_days` INT,
`rate_applied` DOUBLE,
`order_status` VARCHAR(20),
`notes` TEXT,
CONSTRAINT `pk_rental_orders`
PRIMARY KEY (`id`)
);

INSERT INTO `rental_orders` (`employee_id`, `customer_id`)
VALUES 
(1, 2),
(2, 3),
(3, 1);

CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns` (
`id` INT AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
CONSTRAINT `pk_towns`
PRIMARY KEY (`id`)
);

CREATE TABLE `addresses` (
`id` INT AUTO_INCREMENT,
`address_text` VARCHAR(45) NOT NULL,
`town_id` INT,
CONSTRAINT `pk_addresses`
PRIMARY KEY (`id`),
CONSTRAINT `fk_addresses_towns`
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`)
);

CREATE TABLE `departments` (
`id` INT AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
CONSTRAINT `pk_departments`
PRIMARY KEY (`id`) 
);

CREATE TABLE `employees` (
`id` INT AUTO_INCREMENT,
`first_name` VARCHAR(45) NOT NULL,
`middle_name` VARCHAR(45),
`last_name` VARCHAR(45) NOT NULL,
`job_title` VARCHAR(45),
`department_id` INT NOT NULL,
`hire_date` DATE,
`salary` DECIMAL(19,2),
`address_id` INT,
CONSTRAINT `pk_employees`
PRIMARY KEY (`id`),
CONSTRAINT `fk_employees_departments`
FOREIGN KEY (`department_id`)
REFERENCES `departments`(`id`),
CONSTRAINT `fk_employees_addresses`
FOREIGN KEY (`address_id`)
REFERENCES `addresses`(`id`)
);

INSERT INTO `towns` (`name`)
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO `departments` (`name`)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`,`salary`)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

SELECT * FROM `towns` ORDER BY `name`;
SELECT * FROM `departments` ORDER BY `name`;
SELECT * FROM `employees` ORDER BY `salary` DESC;

SELECT `name` FROM `towns` ORDER BY `name`;
SELECT `name` FROM `departments` ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees` ORDER BY `salary` DESC;

UPDATE `employees`
SET `salary` = `salary` * 1.1; 
SELECT `salary` FROM `employees`;

TRUNCATE `occupancies`;



 







