CREATE DATABASE Cinema

/* �������� ������ */

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

/* ������� ��� ������������� TRUNCATE TABLE UPDATE*/
CREATE TABLE table_for_truncate(
  id_table INT NOT NULL PRIMARY KEY IDENTITY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL
)

INSERT INTO table_for_truncate      	--1.1 ��� �������� ������ ����� INSERT INTO table_name VALUES (value1, value2, value3, ...);                               
VALUES
  ('���1', '�������1'),
  ('���2', '�������2')

/* ���������� ������ ����������� */
INSERT INTO gender
VALUES
  ('���'),
  ('���')

INSERT INTO actor (name, surname, date_of_birth, id_gender) --1.2 � ��������� ������ ����� INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
VALUES
  ('�������', '���������', '1997-10-27T10:34:09', 1),
  ('�����', '���������', '1998-11-22T11:34:09', 2),
  ('�����', '���������', '1996-05-21T05:34:09', 1),
  ('�������', '��������', '1995-07-23T03:34:09', 2),
  ('������', '��������', '1993-08-25T05:34:09', 1),
  ('�����������', '���������', '1997-03-24T01:34:09', 2)

DELETE  --2.1. ���� �������
  FROM
    actor

DELETE --	2.2 �� ������� DELETE FROM table_name WHERE condition;
  FROM
    actor WHERE
	  id_gender = 2

TRUNCATE TABLE table_for_truncate --	2.3. �������� ������� TRUNCATE

UPDATE table_for_truncate -- 3.1. ���� �������
  SET name = '��������'

UPDATE table_for_truncate  --3.2. �� ������� �������� ���� ������� UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
  SET name = '�������� � ��������'
  WHERE
    surname = '�������1'

UPDATE table_for_truncate --3.	3.�� ������� �������� ��������� ��������� UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
  SET name = '������� ������ �������', surname = '������� ������ �������'
  WHERE
    surname = '�������1'

SELECT name FROM table_for_truncate --4.1. � ������������ ������� ����������� ��������� (SELECT atr1, atr2 FROM...)

SELECT * FROM table_for_truncate --4.2. �� ����� ���������� (SELECT * FROM...)

SELECT name FROM table_for_truncate WHERE surname = '�������2' --4.3. � �������� �� �������� (SELECT * FROM ... WHERE atr1 = "")

INSERT INTO producer (name, surname, date_of_birth, id_gender)  --	3. � ������� �������� �� ������ ������� INSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
SELECT
  name, surname, date_of_birth, id_gender
FROM
  actor
WHERE
  surname = '���������'

INSERT INTO producer 
VALUES
  ('������', '��������', '2005-10-15T05:05:05', 1),
  ('�����', '���������', '1998-10-15T05:05:05', 2),
  ('�������', '�����', '2005-10-15T05:05:05', 1)

INSERT INTO role 
VALUES
  ('�������', '����� � �����'),
  ('���������', '���� ������������'),
  ('������', '������ �������'),
  ('˸����', '������')

INSERT INTO movie_card
VALUES
  ('��� ��������', '�������� ����� �� ������', '02:01:15.1', 3),
  ('����������', '��� ����������', '02:25:15.0', 1),
  ('��� ����', '��������� �������� � ��������', '03:01:15.0', 2),
  ('�������� ������', '˸���� ������ �� �������', '01:30:15.0', 3)

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

SELECT TOP(4) * --5.1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������
FROM actor
ORDER BY id_gender ASC

SELECT * --5.2 � ����������� �� �������� DESC
FROM actor
ORDER BY id_gender DESC

SELECT TOP(6) * --5.3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������
FROM actor
ORDER BY id_gender, id_actor ASC

SELECT TOP(6) *
FROM actor
ORDER BY id_gender, id_actor DESC

SELECT TOP(6) * --5.4. � ����������� �� ������� ��������, �� ������ �����������
FROM actor
ORDER BY 1 ASC

SELECT *--6.1 WHERE �� ����
FROM actor
WHERE date_of_birth = '1997-10-27T10:34:09'

SELECT YEAR (date_of_birth) --6.2. ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
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

SELECT name, MIN(Year(date_of_birth)) AS year --8.1 1. �������� 3 ������ ������� � �������������� GROUP BY + HAVING
FROM producer
GROUP BY name
HAVING MIN(Year(date_of_birth)) > 1995

SELECT title, MAX(timing) As timing --8.1 1. �������� 3 ������ ������� � �������������� GROUP BY + HAVING
FROM movie_card
GROUP BY title
HAVING MAX(timing) > '02:00:00'

SELECT name, MAX(id_gender) As gender --8.1 1. �������� 3 ������ ������� � �������������� GROUP BY + HAVING
FROM actor
GROUP BY name
HAVING MAX(id_gender) > 1

SELECT * --9.1. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
FROM actor
LEFT JOIN gender ON actor.id_gender = gender.id_gender

SELECT TOP(4) * --9.2. RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
FROM actor
RIGHT JOIN gender ON actor.id_gender = gender.id_gender
ORDER BY id_actor ASC

SELECT actor_price, title, role.description, timing, actor.name, actor.surname --9.3. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
FROM movies
LEFT JOIN movie_card ON movies.id_movie_card = movie_card.id_movie_card
LEFT JOIN actor ON actor.id_actor = movies.id_actor
LEFT JOIN role ON role.id_role = movies.id_role
WHERE movies.actor_price > '15000' AND movie_card.timing > '02:00:00' AND YEAR(actor.date_of_birth) > 1997 

SELECT* --9.4. FULL OUTER JOIN ���� ������
FROM producer
FULL OUTER JOIN gender ON gender.id_gender = producer.id_gender

SELECT * --10.1. �������� ������ � WHERE IN (���������)
FROM producer
WHERE producer.id_producer IN (SELECT movie_card.id_producer FROM movie_card)

SELECT name, surname, YEAR(date_of_birth) AS age, sex --10.2. �������� ������ SELECT atr1, atr2, (���������) FROM ...  
FROM actor
LEFT JOIN gender ON gender.id_gender = actor.id_gender