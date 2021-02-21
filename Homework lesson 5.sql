
drop table USERS;

--Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
create table users (
	id int unsigned not null primary key auto_increment,
	name VARCHAR (255) not null,
	created_at VARCHAR (255),
	updated_at VARCHAR (255)
);

INSERT into users (name) values ('Виктор'), ('Антон'),('Андрей');

UPDATE users SET updated_at = NOW();
UPDATE users SET created_at = NOW();

--Таблица users была неудачно спроектирована.
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
 
UPDATE users SET 
  created_at = str_to_date(created_at, '%Y-%c-%d %H:%i:%s'),
  updated_at = str_to_date(updated_at, '%Y-%c-%d %H:%i:%s');
  
ALTER TABLE users
MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

--В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
Однако нулевые запасы должны выводиться в конце, после всех записей.

DROP TABLE STOREHOUSES_PRODUCTS;
create table storehouses_products (
	id int unsigned not null primary key auto_increment,
	value INT,
	product VARCHAR (255),
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP
);

INSERT INTO storehouses_products (value) VALUES (0), (2500), (0), (30), (500), (1);

SELECT VALUE from STOREHOUSES_PRODUCTS ORDER BY if (value > 0,0,1), VALUE;

--Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
Месяцы заданы в виде списка английских названий (may, august)

create table new_users(
	id int unsigned not null primary key auto_increment,
	name VARCHAR (255),
	birthday VARCHAR (100),
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP
);

INSERT into new_users (name, BIRTHDAY) values 
('Виктор', 'may'), 
('Андрей', 'august'), 
('Антон', 'september');

SELECT * FROM new_users where BIRTHDAY = 'may' or  BIRTHDAY = 'august';

--Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Отсортируйте записи в порядке, заданном в списке IN.

create table catalogs (
	id int unsigned not null primary key,
	name VARCHAR (255),
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP
);

INSERT into CATALOGS (id, name) values 
(1, 'Системный блок'), 
(2, 'Монитор'), 
(3, 'Материнские платы'),
(4, 'Процессоры'), 
(5, 'Клавиатуры'), 
(6, 'Видеокарты');

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
order by
	CASE
    WHEN id = 5 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
  END; 
 
 --Подсчитайте средний возраст пользователей в таблице users.
 
 CREATE TABLE new_new_users (
  id int unsigned not null primary key auto_increment,
  name VARCHAR(255),
  birthday DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO new_new_users (name, birthday) VALUES
  ('Виктор', '1991-05-21'),
  ('Антон', '1995-08-12'),
  ('Андрей', '2000-01-10');
 
 SELECT avg(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS avg_age FROM new_new_users;
 

	