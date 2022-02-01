USE lection1;

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`last_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `products` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`category_id` INT NOT NULL
);

INSERT INTO `employees` VALUES
(0, 'Martin', 'Ivanov'),
(0, 'Valya', 'Semova'),
(0, 'Dimitar', 'Dimov');

ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(50)
AFTER `first_name`;

ALTER TABLE `products`
ADD CONSTRAINT `fk_products_categories`
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`);

ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);