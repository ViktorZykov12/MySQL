
-- Проанализировать какие запросы могут выполняться наиболее
-- часто в процессе работы приложения и добавить необходимые индексы.
CREATE  INDEX users_last_name_first_name_idx ON users(last_name, first_name);

CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX profiles_city_idx ON profiles(city);

CREATE INDEX messages_body_idx ON messages(body(100));
CREATE INDEX posts_body_idx ON posts(body(100));

CREATE INDEX media_filename_idx ON media(filename);

SHOW INDEX FROM messages; 

/*
Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы;
среднее количество пользователей в группах;
самый молодой пользователь в группе;
самый старший пользователь в группе;
общее количество пользователей в группе;
всего пользователей в системе;
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100.
*/

SELECT 
  DISTINCT c.name AS groups_name,
  COUNT(*) OVER() / (SELECT COUNT(*) FROM communities) AS avg_users_groups,
  FIRST_VALUE(CONCAT(u.first_name, ' ', u.last_name, ' ', p.birthday)) OVER (w ORDER BY p.birthday DESC) AS young_user,
  FIRST_VALUE(CONCAT(u.first_name, ' ', u.last_name, ' ', p.birthday)) OVER (w ORDER BY p.birthday) AS old_user,
  COUNT(*) OVER w AS users_in_group,
  (SELECT COUNT(*) FROM users) AS users_in_data,
  COUNT(*) OVER w / (SELECT COUNT(*) FROM users) * 100 AS `%%`
FROM users u
  LEFT JOIN profiles p ON u.id = p.user_id
    LEFT JOIN communities_users cu ON p.user_id = cu.user_id
     LEFT JOIN communities c ON cu.community_id = c.id
WINDOW w AS (PARTITION BY cu.community_id)
ORDER BY groups_name;