--select * from users order by id
--alter table users add column friend_id INT;
--alter table users add foreign key (friend_id) references users

WITH RECURSIVE r AS (
   SELECT id, friend_id, username
   FROM users
   WHERE id = 1

   UNION

   SELECT users.id, users.friend_id, users.username
   FROM users
      JOIN r
          ON users.id = r.friend_id
)

SELECT * FROM r;