-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
select * from profiles limit 10;

select * from likes limit 10;

select * from target limit 10;

select profiles.gender, count(likes.user_id)
	from profiles
	join likes 
	on profiles.user_id = likes.user_id 
group by profiles.gender;



-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей. 

SELECT SUM(likes) total_likes FROM
(SELECT
  COUNT(tt.id) likes
FROM profiles p
  LEFT JOIN likes l
    ON p.user_id = l.target_id
  LEFT JOIN target_types tt 
    ON l.target_type_id = tt.id
      AND tt.name = 'users'
GROUP BY p.user_id 
ORDER BY p.birthday DESC LIMIT 10) user_likes;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

select user_id, users.first_name, users.last_name, count(posts.id) as active  
	from 
		users  
	join 
		posts on users.id = posts.user_id
group by user_id 
order by active desc limit 10;