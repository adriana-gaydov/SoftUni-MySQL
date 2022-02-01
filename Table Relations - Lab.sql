CREATE TABLE `mountains` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(45) NOT NULL,
`mountain_id` INT,
CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
);

SELECT v.driver_id, v.vehicle_type, CONCAT_WS(' ', c.first_name, c.last_name) AS driver_name
FROM vehicles AS v
JOIN campers AS c ON v.driver_id = c.id;

SELECT r.starting_point, r.end_point, r.leader_id, CONCAT_WS(' ', c.first_name, c.last_name) AS leader_name
FROM routes AS r
JOIN campers AS c ON r.leader_id = c.id;


CREATE TABLE `mountains` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(45) NOT NULL,
`mountain_id` INT,
CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
ON DELETE CASCADE
);
