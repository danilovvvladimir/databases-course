USE lab7;

-- 1. Добавить внешние ключи
ALTER TABLE lesson
    ADD CONSTRAINT fk_lesson_id_group
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE,

    ADD CONSTRAINT fk_lesson_id_subject
        FOREIGN KEY (id_subject) REFERENCES subject (id_subject)
            ON UPDATE CASCADE ON DELETE CASCADE,

    ADD CONSTRAINT fk_lesson_id_teacher
        FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE student
    ADD CONSTRAINT fk_student_id_group
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE mark
    ADD CONSTRAINT fk_mark_id_lesson
        FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson)
            ON UPDATE CASCADE ON DELETE CASCADE,

    ADD CONSTRAINT fk_mark_id_student
        FOREIGN KEY (id_student) REFERENCES student (id_student)
            ON UPDATE CASCADE ON DELETE CASCADE;


-- 2. Выдать оценки студентов по информатике если они обучаются данному предмету. Оформить выдачу данных с использованием view
DROP VIEW IF EXISTS informatics_marks;

CREATE VIEW informatics_mark AS
SELECT st.name, m.mark, l.date
FROM mark m
         JOIN lesson l ON m.id_lesson = l.id_lesson
         JOIN subject sb ON l.id_subject = sb.id_subject AND sb.name = 'Информатика'
         JOIN student st ON m.id_student = st.id_student;

SELECT *
FROM informatics_mark;

/*
 3. Дать информацию о должниках с указанием фамилии студента и названия предмета. Должниками считаются студенты,
 не имеющие оценки по предмету,который ведется в группе. Оформить в виде процедуры, на входе идентификатор группы
 */
 
DROP PROCEDURE IF EXISTS students_debtor_procedure;

DELIMITER //
CREATE PROCEDURE students_debtor_procedure (IN id_group INT)
BEGIN
	SELECT st.`name`, sub.`name`, MAX(m.mark) AS max_mark
	FROM student st
		LEFT JOIN lesson l ON l.id_group = st.id_group
		LEFT JOIN `subject` sub ON sub.id_subject = l.id_subject
		LEFT JOIN mark m ON m.id_lesson = l.id_lesson AND m.id_student = st.id_student
	WHERE st.id_group = id_group
	GROUP BY st.`name`, sub.`name`
	HAVING max_mark IS NULL
	ORDER BY st.`name`, sub.`name`;
END//
DELIMITER ;

CALL students_debtor_procedure(4);

-- 4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов.
SELECT sub.`name`, COUNT(DISTINCT st.id_student) AS student_amount, AVG(m.mark) AS average_mark
FROM lesson l
	JOIN `group` g ON g.id_group = l.id_group
	JOIN student st ON st.id_group = g.id_group
	JOIN `subject` sub ON sub.id_subject = l.id_subject
	JOIN mark m ON m.id_lesson = l.id_lesson
WHERE m.id_student = st.id_student
GROUP BY l.id_subject
HAVING student_amount > 35;
/*
 5. Дать оценки студентов специальности ВМ по всем проводимым предметам с
 указанием группы, фамилии, предмета, даты. При отсутствии оценки заполнить
 значениями NULL поля оценки.
 */

SELECT st.name AS student, sj.name AS subject, l.date AS date, m.mark AS mark
FROM student st
         INNER JOIN `group` g ON st.id_group = g.id_group AND g.name = 'ВМ'
         INNER JOIN lesson l ON g.id_group = l.id_group
         INNER JOIN subject sj ON l.id_subject = sj.id_subject
         LEFT JOIN mark m ON st.id_student = m.id_student AND l.id_lesson = m.id_lesson
ORDER BY 1;

-- 6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.
UPDATE mark m
    JOIN lesson l ON m.id_lesson = l.id_lesson AND l.date < '2019-05-12'
    JOIN subject sb ON l.id_subject = sb.id_subject AND sb.name = 'БД'
    JOIN `group` g ON l.id_group = g.id_group AND g.name = 'ПС'
SET m.mark = m.mark + 1
WHERE m.mark < 5;

-- 7. Добавить необходимые индексы.
CREATE INDEX idx_group_name
    ON `group` (name);

CREATE INDEX idx_subject_name
    ON subject (name);

CREATE INDEX idx_lesson_date
    ON lesson (date);