CREATE table likes (
	id int unsigned not null primary key auto_increment,
	by_user_id int UNSIGNED NOT NULL comment 'от какого пользователя лайк',
	to_post_id INT UNSIGNED NOT NULL comment 'какому посту поставили лайк',
	like_status_id  int UNSIGNED NOT null comment 'лайк/дизлайк'
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP,
	unique (by_user_id, to_post_id) comment 'что бы лайки не повторялись'
);

create table likes_status (
	id int unsigned not null primary key auto_increment,
	status ENUM (0, 1) default 0 comment '0 - не лайк, 1 - лайк',
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP,	
);

create table posts (
	id int unsigned not null primary key auto_increment,
	user_id int unsigned not null unique,
	post_name VARCHAR (255) not null,
	post_body TEXT,
	media_id int unsigned not null,
	created_at datetime default current_timestamp, 
	updated_at datetime default current_timestamp on update CURRENT_TIMESTAMP,
);
	