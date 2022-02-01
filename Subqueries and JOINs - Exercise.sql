SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

SELECT first_name, last_name, t.`name`, address_text
FROM employees AS e
JOIN addresses AS a ON e.address_id = a.address_id
JOIN towns AS t ON a.town_id = t.town_id
ORDER BY first_name, last_name
LIMIT 5;

SELECT employee_id, first_name, last_name, d.`name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.`name` = 'Sales'
ORDER BY employee_id DESC;

SELECT employee_id, first_name, salary, d.`name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

SELECT employee_id, first_name 
FROM employees AS e
WHERE e.employee_id NOT IN (SELECT employee_id FROM employees_projects)
ORDER BY employee_id DESC
LIMIT 3;

SELECT first_name, last_name, hire_date, d.`name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.`name` IN ('Sales', 'Finance') AND DATE(hire_date) > '1999-01-01'
ORDER BY hire_date;

SELECT e.employee_id, first_name, p.`name`
FROM employees AS e
JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE DATE(start_date) > '2002-08-13' AND end_date IS NULL
ORDER BY first_name, p.`name`
LIMIT 5; 

SELECT e.employee_id, first_name, IF(YEAR(start_date) >= 2005, NULL, p.`name`) AS project_name
FROM employees AS e
JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE e.employee_id = 24
ORDER BY p.`name`;

SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
FROM employees AS e
JOIN employees AS m ON e.manager_id = m.employee_id
WHERE e.manager_id IN (3, 7)
ORDER BY e.first_name;

SELECT e.employee_id, CONCAT_WS(' ', e.first_name, e.last_name) AS employee_name,  CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name, d.`name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
JOIN employees AS m ON e.manager_id = m.employee_id
ORDER BY e.employee_id
LIMIT 5;

SELECT MIN(q.salary) AS min_average_salary
FROM (SELECT AVG(salary) AS salary FROM employees GROUP BY department_id) AS q;

SELECT country_code, mountain_range, peak_name, elevation 
FROM mountains_countries AS mc 
JOIN mountains AS m ON mc.mountain_id = m.id
JOIN peaks AS p ON m.id = p.mountain_id
WHERE country_code = 'BG' AND elevation > 2835
ORDER BY elevation DESC;

SELECT country_code, COUNT(mountain_range) AS `count`
FROM mountains_countries AS mc 
JOIN mountains AS m ON mc.mountain_id = m.id
WHERE country_code IN ('BG', 'RU', 'US')
GROUP BY country_code
ORDER BY `count` DESC;

SELECT country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr ON c.country_code = cr.country_code
LEFT JOIN rivers AS r ON cr.river_id = r.id
WHERE continent_code = 'AF'
ORDER BY country_name
LIMIT 5;

SELECT 
            currency_code
        FROM
            countries AS c2
        WHERE
           c2.continent_code = 'AF'
        GROUP BY currency_code
        ORDER BY COUNT(currency_code) DESC
        LIMIT 1;

SELECT 
    continent_code, currency_code, COUNT(*) AS cnt
FROM
    countries AS c
GROUP BY c.continent_code , c.currency_code
HAVING cnt > 1
    AND cnt = (SELECT 
        COUNT(*)
    FROM
        countries AS c2
    WHERE
        c.continent_code = c2.continent_code
    GROUP BY currency_code
    ORDER BY COUNT(currency_code) DESC
    LIMIT 1)
ORDER BY c.continent_code , c.currency_code;

SELECT COUNT(*)
FROM countries AS c
WHERE country_code NOT IN (SELECT country_code FROM mountains_countries);

SELECT country_name, MAX(elevation) AS highest_peak_elevation, MAX(length) AS longest_river_length
FROM countries AS c 
LEFT JOIN countries_rivers AS cr ON c.country_code = cr.country_code
LEFT JOIN rivers as r on cr.river_id = r.id
LEFT JOIN mountains_countries AS mc ON c.country_code = mc.country_code
LEFT JOIN mountains AS m ON mc.mountain_id = m.id
LEFT JOIN peaks AS p ON m.id = p.mountain_id
GROUP BY country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, country_name
LIMIT 5;

