USE vk;
SHOW TABLES;

SELECT * FROM users LIMIT 10;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

DESC profiles;
ALTER TABLE profiles MODIFY COLUMN gender ENUM('M', 'F');
SELECT * FROM profiles LIMIT 10;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;

DESC messages;
SELECT * FROM messages LIMIT 100;

DESC media_types;
SELECT * FROM media_types;
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');

DESC media;
ALTER TABLE media MODIFY metadata JSON;
SELECT * FROM media LIMIT 20;
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
UPDATE media SET `size` = FLOOR(10000 + RAND() * 1000000) WHERE `size` < 1000;
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');
SELECT * FROM extensions;
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);
UPDATE media SET metadata = CONCAT(
  '{"owner":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
  '"}'
);

DESC friendship_statuses;
SELECT * FROM friendship_statuses;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

DESC friendship;
ALTER TABLE friendship DROP COLUMN requested_at;
SELECT * FROM friendship;
UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3);
UPDATE friendship SET confirmed_at = NOW() WHERE confirmed_at < created_at;
UPDATE friendship SET updated_at = NOW() WHERE updated_at <confirmed_at;

DESC communities;
ALTER TABLE communities ADD COLUMN owner_id INT UNSIGNED NOT NULL AFTER id;
SELECT * FROM communities;
DELETE FROM communities WHERE id > 20;
UPDATE communities SET owner_id = FLOOR(1 + RAND() * 100);
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;

DESC communities_users;
SELECT * FROM communities_users;
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);