-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select * from orders;

select * from users;

select 
	u.name, 
	o.id
from
	users as u
join 
	orders as o
on
	u.id = o.user_id
group by u.name;

--Выведите список товаров products и разделов catalogs, который соответствует товару.

select * from products;

select * from catalogs;

select 
	p.name,
	c.name
from 
	products as p
join 
	catalogs as c
on 
	p.catalog_id = c.id;

--Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.

use example;

CREATE TABLE flights (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
`from` VARCHAR(50) NOT NULL,
`to` VARCHAR(50) NOT NULL
);

CREATE TABLE cities(
label VARCHAR(50) PRIMARY KEY, 
name VARCHAR(50)
);

INSERT INTO flights(`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

INSERT INTO cities VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
  
 SELECT * FROM cities;
 SELECT * FROM flights;
	
select 
	f.id,
	c.name as 'from',
	citi.name as 'to'
from 
	flights as f
join 
	cities as c on c.label = f.`from`
join
	cities as citi on citi.label = f.`to`;
	