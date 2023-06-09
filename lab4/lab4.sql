-- 3.1 INSERT
-- 3.1 a) Без указания списка полей
INSERT INTO company 
	VALUES (DEFAULT, "wh-IT-e tea", "USA, California, LA", NULL);
INSERT INTO company 
	VALUES (DEFAULT, "IAutumn", "USA, California, SF", "+1(800)469-92-69");
    
-- 3.1 b) С указанием списка полей
INSERT INTO project_done (id_company, name, date_start, date_finish) 
	VALUES (1, "Internet Shop IAmaver", "2020-01-01", "2020-02-01");
INSERT INTO project_done (id_company, name, date_start, date_finish) 
	VALUES (5, "Landing PEoS", "2021-05-11", "2021-05-12");
    
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (1, "Front-End", 20);
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (1, "Back-End", 10);
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (1, "Design", 10);
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (5, "Front-End", 10);
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (5, "Design", 14);
INSERT INTO employee_group (id_company, name, max_employees) 
	VALUES (5, "Back-End", 10);

INSERT INTO employee (id_employee_group, id_company, first_name, last_name, birthdate) 
	VALUES (1, 1, "Ivan", "Ivanov", "2000-02-10");
INSERT INTO employee (id_employee_group, id_company, first_name, last_name, birthdate) 
	VALUES (2, 1, "Danil", "Krilov", "2004-02-04");
INSERT INTO employee (id_employee_group, id_company, first_name, last_name, birthdate) 
	VALUES (5, 5, "Vladimir", "Vladimirov", "2002-12-14");
INSERT INTO employee (id_employee_group, id_company, first_name, last_name, birthdate) 
	VALUES (5, 5, "Alexandr", "Agapov", "1992-10-24");

INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (2, 5);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (2, 7);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (1, 1);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (1, 2);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (1, 3);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (3, 1);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (3, 2);
INSERT INTO participation_in_project (id_project_done, id_employee_group) 
	VALUES (3, 3);
    
-- 3.1 c) С чтением значения из другой таблицы
INSERT INTO project_done (id_company, name, date_start, date_finish) VALUES(
	(SELECT id_company FROM company WHERE name = "wh-IT-e tea" ), 
	"Landing SFss", 
    "2020-11-11",
    "2020-12-11"
);

-- 3.2 DELETE
-- 3.2 a) Всех записей
DELETE
FROM employee;

-- 3.2 b) По условию
DELETE
FROM employee
WHERE first_name = "Andrew";

-- 3.3 UPDATE
-- 3.3 a) Всех записей
UPDATE employee
SET first_name = "Andrew";

-- 3.3 b) По условию обновляя один атрибут
UPDATE employee
SET first_name = "Vladimir"
WHERE last_name = "Vladimirov";

UPDATE employee
SET first_name = "Alexandr"
WHERE last_name = "Agapov";

UPDATE employee
SET id_company = "Ivan"
WHERE last_name = "Ivanov";

-- 3.3 c) По условию обновляя несколько атрибутов
UPDATE project_done
SET date_start = "2020-03-03", date_finish = "2020-04-03"
WHERE date_start = "2020-01-01" AND date_finish = "2020-02-01";

SELECT * FROM employee;
-- 3.4 SELECT
-- 3.4 a) С набором извлекаемых атрибутов
SELECT name, date_start, date_finish
FROM project_done;

-- 3.4 b) Со всеми атрибутами
SELECT * 
FROM employee_group;

-- 3.4 c) С условием по атрибуту
SELECT name, date_start, date_finish
FROM project_done
WHERE date_start > "2020-12-31";

-- 3.5 SELECT ORDER BY + TOP (LIMIT)
-- 3.5 a) С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT *
FROM employee
ORDER BY birthdate ASC;

-- 3.5 b) С сортировкой по убыванию DESC
SELECT *
FROM employee
ORDER BY birthdate DESC;

-- 3.5 c) С сортировкой подвум атрибутам + ограничение вывода количества записей
SELECT * 
FROM project_done
ORDER BY id_company, date_start ASC
LIMIT 2;

-- 3.5 d) С сортировкой по первому атрибуту, из списка извлекаемых
SELECT * 
FROM employee
ORDER BY 1 DESC;

-- 3.6 Работа с датами
-- 3.6 a) WHERE по дате
SELECT *
FROM employee
WHERE birthdate = "2002-12-14";

-- 3.6 b) WHERE дата в диапазоне
SELECT *
FROM employee
WHERE birthdate BETWEEN "2000-01-01" AND "2003-01-01";

-- 3.6 c) Извлечь из таблицы не всю дату, а только год.
SELECT first_name, YEAR(birthdate) AS birth_year
FROM employee;

-- 3.7 Функции агрегации
-- 3.7 a) Посчитать количество записей в таблице
SELECT COUNT(*) AS amount_of_employees FROM employee;

-- 3.7 b) Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT name) AS unique_employee_group_name FROM employee_group;

-- 3.7 c) Вывести уникальные значения столбца
SELECT DISTINCT first_name
FROM employee;

-- 3.7 d) Найти максимальное значение столбца
SELECT MAX(max_employees) AS max_employees_capacity
FROM employee_group;

-- 3.7 e) Найти минимальное значение столбца
SELECT MIN(max_employees) AS max_employees_capacity
FROM employee_group;

-- 3.7 f) Написать запрос COUNT() + GROUP BY
SELECT id_company, SUM(max_employees) AS max_employees_in_company
FROM employee_group
GROUP BY id_company;

-- 3.8 SELECT GROUP BY + HAVING
-- 3.8 a) Написать 3 разных запроса с использованием GROUP BY + HAVING.

-- [1] Когда максимальное число сотрудников в компании больше 35.
SELECT id_company, SUM(max_employees) AS max_employees_in_company
FROM employee_group
GROUP BY id_company
HAVING max_employees_in_company > 35;

-- [2] Когда максимальное число сотрудников в отделе больше 15.
SELECT id_company, MAX(max_employees) AS max_employees_in_company
FROM employee_group
GROUP BY id_company
HAVING max_employees_in_company > 15;

-- [3] Когда минимальное число сотрудников в отделе меньше или равно 10.
SELECT id_company, MIN(max_employees) AS max_employees_in_company
FROM employee_group
GROUP BY id_company
HAVING max_employees_in_company <= 10;

-- 3.9 SELECT JOIN
-- 3.9 a) LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT c.name AS company_name, pd.name as name_of_project
FROM company c
	LEFT JOIN project_done pd ON c.id_company = pd.id_company;
    
-- 3.9 b) RIGHT JOIN. Получить такую же выборку, как и в (a)
SELECT c.name AS company_name, pd.name as name_of_project
FROM project_done pd
	RIGHT JOIN company c ON c.id_company = pd.id_company;

-- 3.9 c) LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT c.name, e.first_name, e.last_name
FROM company c
	LEFT JOIN employee e ON c.id_company = e.id_company
    LEFT JOIN employee_group eg ON eg.id_employee_group = e.id_employee_group
    WHERE eg.name = "Front-End";

-- 3.9 d) INNER JOIN двух таблиц
SELECT *
FROM company c
	INNER JOIN employee e ON e.id_company = c.id_company;

-- Подзапросы
-- 3.10 a) Написать запрос сусловием WHERE IN (подзапрос)
SELECT *
FROM employee
WHERE id_company IN (SELECT id_company FROM project_done);

-- 3.10 b) Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT 
	first_name, 
	last_name, 
    (SELECT c.name FROM company c WHERE c.id_company = e.id_company) AS company_name
FROM employee e;

-- 3.10 c) Написать запрос вида SELECT*FROM (подзапрос)
SELECT *
FROM (SELECT first_name, last_name FROM employee) AS names;

-- 3.10 d) Написать запрос вида SELECT * FROM table JOIN (подзапрос)ON ...
SELECT *
FROM project_done pd
	JOIN (SELECT c.id_company, c.name FROM company c) as tbl
    ON pd.id_company = tbl.id_company;