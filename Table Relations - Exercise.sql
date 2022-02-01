DROP DATABASE `table_relations`;
CREATE DATABASE `table_relations`;
USE `table_relations`;

CREATE TABLE `passports` (
	`passport_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `passport_number` CHAR(8) NOT NULL UNIQUE
) AUTO_INCREMENT = 101;

CREATE TABLE `people` (
	`person_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(45) NOT NULL,
    `salary` DECIMAL(8, 2) NOT NULL,
    `passport_id` INT UNSIGNED UNIQUE,
    CONSTRAINT `fk_people_passports`
    FOREIGN KEY (`passport_id`)
    REFERENCES `passports`(`passport_id`)
);

INSERT INTO `passports` (`passport_number`)
VALUES ('N34FG21B'),
		('K65LO4R7'),
        ('ZE657QP2');
        
INSERT INTO `people` (`first_name`, `salary`, `passport_id`)
VALUES ('Roberto', 43300.00, 102),
		('Tom', 56100.00, 103),
        ('Yana', 60200.00, 101);
 
CREATE TABLE `manufacturers` (
	`manufacturer_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    `established_on` DATE NOT NULL
);

CREATE TABLE `models` (
	`model_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    `manufacturer_id` INT UNSIGNED NOT NULL,
    CONSTRAINT `fk_models_manufacturers`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `manufacturers`(`manufacturer_id`)
) AUTO_INCREMENT = 101;

INSERT INTO `manufacturers` (`name`, `established_on`)
VALUES ('BMW', '1916-03-01'),
		('Tesla', '2003-01-01'),
        ('Lada', '1966-05-01');
        
INSERT INTO `models` (`name`, `manufacturer_id`) 
VALUES ('X1', 1),
		('i6', 1),
        ('Model S', 2),
        ('Model X', 2),
        ('Model 3', 2),
        ('Nova', 3);
        
CREATE TABLE `students` (
	`student_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(45) NOT NULL
);

CREATE TABLE `exams` (
	`exam_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(60) NOT NULL
) AUTO_INCREMENT = 101;

CREATE TABLE `students_exams` (
	`student_id` INT UNSIGNED NOT NULL,
    `exam_id` INT UNSIGNED NOT NULL,
    CONSTRAINT `pk_students_exams`
    PRIMARY KEY (`student_id`, `exam_id`),
    CONSTRAINT `fk_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `students`(`student_id`),
    CONSTRAINT `fk_exams`
    FOREIGN KEY (`exam_id`)
    REFERENCES `exams`(`exam_id`)
);

INSERT INTO `students` (`name`)
VALUES ('Mila'),
		('Toni'),
        ('Ron');
        
INSERT INTO `exams` (`name`)
VALUES ('Spring MVC'),
		('Neo4j'),
        ('Oracle 11g');
        
INSERT INTO `students_exams` VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

CREATE TABLE `teachers` (
`teacher_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(45) NOT NULL,
`manager_id` INT UNSIGNED 
) AUTO_INCREMENT = 101;

INSERT INTO `teachers` (`name`, `manager_id`)
VALUES ('John', NULL),
		('Maya', 106),
		('Silvia', 106),
        ('Ted', 105),
        ('Mark', 101),
        ('Greta', 101);
        
ALTER TABLE `teachers`
ADD CONSTRAINT `fk_teachers`
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

CREATE TABLE `item_types` (
	`item_type_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

CREATE TABLE `items` (
	`item_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `item_type_id` INT,
    CONSTRAINT `fk_items_item_types`
    FOREIGN KEY (`item_type_id`)
    REFERENCES `item_types`(`item_type_id`)
);

CREATE TABLE `cities` (
	`city_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

CREATE TABLE `customers` (
	`customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `birthday` DATE,
    `city_id` INT,
    CONSTRAINT `fk_customers_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities`(`city_id`)
);

CREATE TABLE `orders` (
	`order_id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT,
    CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `order_items` (
	`order_id` INT,
    `item_id` INT,
    CONSTRAINT `pk_order_items`
    PRIMARY KEY (`order_id`, `item_id`),
    CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `orders`(`order_id`),
    CONSTRAINT `fk_order_items_items`
    FOREIGN KEY (`item_id`)
    REFERENCES `items`(`item_id`)
);

USE test1;

CREATE TABLE `subjects` (
	`subject_id` INT AUTO_INCREMENT PRIMARY KEY,
    `subject_name` VARCHAR(50)
);

CREATE TABLE `majors` (
	`major_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

CREATE TABLE `students` (
	`student_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_number` VARCHAR(12),
    `student_name` VARCHAR(50),
    `major_id` INT,
    CONSTRAINT `fk_students_majors`
    FOREIGN KEY (`major_id`)
    REFERENCES `majors`(`major_id`)
);

CREATE TABLE `payments` (
	`payment_id` INT AUTO_INCREMENT PRIMARY KEY,
    `payment_date` DATE,
    `payment_amount` DECIMAL(8,2),
    `student_id` INT(11),
    CONSTRAINT `fk_majors_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `students`(`student_id`)
);

CREATE TABLE `agenda` (
	`student_id` INT,
    `subject_id` INT,
    CONSTRAINT `pk_agenda`
    PRIMARY KEY (`student_id`, `subject_id`),
    CONSTRAINT `fk_agenda_subjects`
    FOREIGN KEY (`subject_id`)
    REFERENCES `subjects`(`subject_id`),
    CONSTRAINT `fk_agenda_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `students`(`student_id`)
);

SELECT `m`.`mountain_range`, `p`.`peak_name`, `p`.`elevation`
FROM `peaks` AS `p`
JOIN `mountains` AS `m`
ON `p`.`mountain_id` = `m`.`id`
WHERE `m`.`id` = 17
ORDER BY `p`.`elevation` DESC;