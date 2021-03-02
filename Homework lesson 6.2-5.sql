
-- 2. Создать все необходимые внешние ключи и диаграмму отношений.
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

ALTER TABLE communities
  ADD CONSTRAINT communities_owner_id_fk 
    FOREIGN KEY (owner_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_communities_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE cascade,
  ADD CONSTRAINT communities_users_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE cascade;
     
ALTER TABLE friendship
  ADD CONSTRAINT frendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE cascade,
  ADD CONSTRAINT frendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
      ON DELETE cascade,
  ADD CONSTRAINT frendship_frendship_statuses_id_fk 
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id)
      ON DELETE cascade;    

ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE cascade,
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
      ON DELETE cascade;

UPDATE posts SET community_id = FLOOR(1 + RAND() * 20);     
     
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE cascade,
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE cascade,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON DELETE cascade;
     
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE cascade,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
      ON DELETE cascade;
     
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
select * from profiles limit 10;

select * from likes limit 10;

select
	(select gender from profiles where user_id = likes.target_id) as gender,
	count(*) as likes_count
from likes
group by gender;


-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей. 

select count(*) from likes where user_id in 
(select * from (select user_id from profiles order by birthday desc limit 10) as birthdays);

 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

select user_id, count(*) as active from posts group by user_id order by active desc limit 10;
