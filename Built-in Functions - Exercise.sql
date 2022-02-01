SELECT `first_name`, `last_name` FROM `employees`
WHERE `first_name` LIKE 'Sa%'
ORDER BY `employee_id`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE LOCATE('ei', `last_name`)
ORDER BY `employee_id`;

SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) AND
YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE NOT LOCATE('engineer', `job_title`)
ORDER BY `employee_id`;

SELECT `name` FROM `towns`
WHERE CHAR_LENGTH(`name`) IN (5, 6)
ORDER BY `name`;

SELECT * FROM `towns`
WHERE `name` REGEXP '^[MmKkBbEe]'
ORDER BY `name`;

SELECT * FROM `towns`
WHERE `name` NOT REGEXP '^[RrBbDd]'
ORDER BY `name`;

drop view `v_employees_hired_after_2000`;

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name` FROM `employees`
WHERE YEAR(`hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE CHAR_LENGTH(`last_name`) = 5;

SELECT `country_name`, `iso_code` FROM `countries`
WHERE `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;

SELECT `peak_name`, `river_name`, LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS `mix`
FROM `peaks`, `rivers`
WHERE RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

SELECT `name`, date_format(`start`, '%Y-%m-%d') AS `start` FROM `games`
WHERE YEAR(`start`) IN (2011, 2012)
ORDER BY `start`, `name`
LIMIT 50;

SELECT `user_name`, SUBSTR(`email`, LOCATE('@', `email`) + 1) AS `Email Provider` FROM `users`
ORDER BY `Email Provider`, `user_name`;

SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE "___.1%.%.___"
ORDER BY `user_name`;

SELECT 
    `name`,
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(`start`) BETWEEN 18 AND 23 THEN 'Evening'
    END AS `Part of the Day`,
    CASE
		WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 3 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 6 AND 10 THEN 'Long'
        ELSE 'Extra Long'
	END AS `Duration`
FROM 
    `games`;
    
SELECT `product_name`, `order_date`, ADDDATE(`order_date`, INTERVAL 3 DAY) AS `pay_due`, ADDDATE(`order_date`, INTERVAL 1 MONTH) AS `deliver_due` FROM orders;