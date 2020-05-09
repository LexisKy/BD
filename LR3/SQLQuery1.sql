CREATE DATABASE Cinema

/* Создание таблиц */

CREATE TABLE actor(
  id_actor INT NOT NULL PRIMARY KEY IDENTITY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  date_of_birth DATETIME NOT NULL,
  id_gender INT NOT NULL
)

CREATE TABLE producer(
  id_producer INT NOT NULL PRIMARY KEY IDENTITY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  date_of_birth DATETIME NOT NULL,
  id_gender INT NOT NULL
)

CREATE TABLE role(
  id_role INT NOT NULL PRIMARY KEY IDENTITY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL
)

CREATE TABLE gender(
  id_gender INT NOT NULL PRIMARY KEY IDENTITY,
  sex VARCHAR(3) NOT NULL
)

CREATE TABLE movie_card(
  id_movie_card INT NOT NULL PRIMARY KEY IDENTITY,
  title VARCHAR(50) NOT NULL,
  description VARCHAR(250) NOT NULL,
  timing TIME NOT NULL,
  id_producer INT NOT NULL
)

CREATE TABLE movies(
  id_movies INT NOT NULL PRIMARY KEY IDENTITY,
  id_movie_card INT NOT NULL,
  id_actor INT NOT NULL,
  id_role INT NOT NULL,
  actor_price REAL NOT NULL
)

/* Таблица для TRUNCATE*/
CREATE TABLE table_for_truncate(
  id_table INT NOT NULL PRIMARY KEY IDENTITY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL
)

INSERT INTO table_for_truncate      	--1.1 Без указания списка полей INSERT INTO table_name VALUES (value1, value2, value3, ...);                               
VALUES
  ('Имя1', 'Фамилия1'),
  ('Имя2', 'Фамилия2')

/* Çàïîëíåíèå òàáëèö èíôîðìàöèåé */
INSERT INTO gender
VALUES
  ('муж'),
  ('жен')

INSERT INTO actor (name, surname, date_of_birth, id_gender) --1.2 С указанием списка полей INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
VALUES
  ('Алексей', 'Зайнуллин', '1997-10-27T10:34:09', 1),
  ('Ольга', 'Степанова', '1998-11-22T11:34:09', 2),
  ('Игорь', 'Запеканов', '1996-05-21T05:34:09', 1),
  ('Клавдия', 'Макарова', '1995-07-23T03:34:09', 2),
  ('Михаил', 'Ороспаев', '1993-08-25T05:34:09', 1),
  ('Апполинария', 'Ирмушкина', '1997-03-24T01:34:09', 2)

DELETE  --2.1. Всех записей
  FROM
    actor

DELETE --	2.2 По условию DELETE FROM table_name WHERE condition;
  FROM
    actor WHERE
	  id_gender = 2

TRUNCATE TABLE table_for_truncate --	2.3. Очистить таблицу TRUNCATE

UPDATE table_for_truncate -- 3.1. Всех записей
  SET name = 'Заменено'

UPDATE table_for_truncate  --3.2. По условию обновляя один атрибут UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
  SET name = 'Заменено с условием'
  WHERE
    surname = 'Фамилия1'

UPDATE table_for_truncate --3.	3.По условию обновляя несколько атрибутов UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
  SET name = 'Заменен первый атрибут', surname = 'Заменен второй атрибут'
  WHERE
    surname = 'Фамилия1'

SELECT name FROM table_for_truncate --4.1. С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)

SELECT * FROM table_for_truncate --4.2. Со всеми атрибутами (SELECT * FROM...)

SELECT name FROM table_for_truncate WHERE surname = 'Фамилия2' --4.3.С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")

INSERT INTO producer (name, surname, date_of_birth, id_gender)  --	3.3 По условию обновляя несколько атрибутов INSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
SELECT
  name, surname, date_of_birth, id_gender
FROM
  actor
WHERE
  surname = 'Зайнуллин'

INSERT INTO producer 
VALUES
  ('Михаил', 'Галустян', '2005-10-15T05:05:05', 1),
  ('Ирина', 'Степанова', '1998-10-15T05:05:05', 2),
  ('Евгений', 'Галин', '2005-10-15T05:05:05', 1)

INSERT INTO role 
VALUES
  ('Танкист', 'Сидит в танке'),
  ('Бухгалтер', 'Ведёт документацию'),
  ('Бармен', 'Делает напитки'),
  ('Лётчик', 'Летает')

INSERT INTO movie_card
VALUES
  ('Три танкиста', 'Танкисты ездят на танках', '02:01:15.1', 3),
  ('Интересный', 'Про интересное', '02:25:15.0', 1),
  ('Про офис', 'Бухгалтер работает с бумагами', '03:01:15.0', 2),
  ('Летающий самолёт', 'Лётчик летает на самолёте', '01:30:15.0', 3)

ALTER TABLE movies
  ADD CONSTRAINT
    fk_movies_movie_card FOREIGN KEY(id_movie_card)
  REFERENCES
    movie_card(id_movie_card)
  ON DELETE CASCADE
  ON UPDATE CASCADE

ALTER TABLE movies
  ADD CONSTRAINT
    fk_movies_actor FOREIGN KEY(id_actor)
  REFERENCES
    actor(id_actor)
  ON DELETE CASCADE
  ON UPDATE CASCADE

ALTER TABLE movies
  ADD CONSTRAINT
    fk_movies_role FOREIGN KEY(id_role)
  REFERENCES
    role(id_role)
  ON DELETE CASCADE
  ON UPDATE CASCADE

ALTER TABLE actor
   ADD CONSTRAINT
    fk_actor_gender FOREIGN KEY(id_gender)
  REFERENCES
    gender(id_gender)
  ON DELETE CASCADE
  ON UPDATE CASCADE

ALTER TABLE producer
  ADD CONSTRAINT
    fk_producer_gender FOREIGN KEY(id_gender)
  REFERENCES
    gender(id_gender)

ALTER TABLE movie_card
  ADD CONSTRAINT
    fk_movie_card_producer FOREIGN KEY(id_producer)
  REFERENCES
    producer(id_producer)

INSERT INTO movies
VALUES
  (1, 3, 1, '15000'),
  (1, 2, 4, '19000'),
  (2, 1, 3, '500000'),
  (3, 1, 1, '13000'),
  (3, 2, 3, '16000'),
  (3, 3, 4, '14000'),
  (3, 4, 2, '15000')

SELECT TOP(4) * --5.1. С сортировкой по возрастанию ASC + ограничение вывода количества записей
FROM actor
ORDER BY id_gender ASC

SELECT * --5.2 С сортировкой по убыванию DESC
FROM actor
ORDER BY id_gender DESC

SELECT TOP(6) * --5.3. С сортировкой по двум атрибутам + ограничение вывода количества записей
FROM actor
ORDER BY id_gender, id_actor ASC

SELECT TOP(6) *
FROM actor
ORDER BY id_gender, id_actor DESC

SELECT TOP(6) * --5.4. С сортировкой по первому атрибуту, из списка извлекаемых
FROM actor
ORDER BY 1 ASC

SELECT *                       --6.1 WHERE по дате
FROM actor
WHERE date_of_birth = '1997-10-27T10:34:09'

SELECT YEAR (date_of_birth) --6.2. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора. Для этого используется функция.
FROM actor
WHERE date_of_birth = '1997-10-27T10:34:09'

SELECT COUNT(*) AS id_gender --7.5 COUNT
FROM actor
GROUP BY id_gender

SELECT MIN(name) --7.1 MIN
FROM actor
GROUP BY name

SELECT MAX(name) --7.2 MAX
FROM actor
GROUP BY name

SELECT AVG(id_gender) --7.3 AVG
FROM actor
GROUP BY id_gender

SELECT SUM(id_gender) --7.4 SUM
FROM actor
GROUP BY id_gender

SELECT name, COUNT(movies.id_movie_card) AS movie_count --8.1 1. Написать 3 разных запроса с использованием GROUP BY + HAVING
FROM movies
LEFT JOIN actor ON actor.id_actor = movies.id_actor
GROUP BY name
HAVING COUNT(movies.id_movie_card) >= 2

SELECT title, MAX(timing) As timing --8.1 1. Написать 3 разных запроса с использованием GROUP BY + HAVING
FROM movie_card
GROUP BY title
HAVING MAX(timing) >= '02:25:00'

SELECT name, MAX(id_gender) As gender --8.1 1. Написать 3 разных запроса с использованием GROUP BY + HAVING
FROM actor
GROUP BY name
HAVING MAX(id_gender) > 1

SELECT * --9.1. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
FROM actor
LEFT JOIN gender ON actor.id_gender = gender.id_gender

SELECT TOP(4) * --9.2. RIGHT JOIN. Получить такую же выборку, как и в 5.1
FROM actor
RIGHT JOIN gender ON actor.id_gender = gender.id_gender
ORDER BY id_actor ASC

SELECT actor_price, title, role.description, timing, actor.name, actor.surname --9.3. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
FROM movies
LEFT JOIN movie_card ON movies.id_movie_card = movie_card.id_movie_card
LEFT JOIN actor ON actor.id_actor = movies.id_actor
LEFT JOIN role ON role.id_role = movies.id_role
WHERE movies.actor_price > '15000' AND movie_card.timing > '02:00:00' AND YEAR(actor.date_of_birth) > 1997 

SELECT* --9.4. FULL OUTER JOIN двух таблиц
FROM producer
FULL OUTER JOIN gender ON gender.id_gender = producer.id_gender

SELECT * --10.1. Написать запрос с WHERE IN (подзапрос)
FROM producer
WHERE producer.id_producer IN (SELECT movie_card.id_producer FROM movie_card)

SELECT name, surname, YEAR(date_of_birth) AS age, sex --10.2. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...  
FROM actor
LEFT JOIN gender ON gender.id_gender = actor.id_gender
