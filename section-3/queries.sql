-- INSERT INTO users (username) VALUES 
--     ('andrew'),
--     ('tomiwa'),
--     ('praise'),
--     ('ibk'),
--     ('wale');

SELECT * FROM users;

-- get all the photos that belong to user with id 1 i.e me
-- INSERT INTO photos (url, user_id)
-- VALUES 
--     ('https://github.com/emma', 1),
--     ('https://github.com/sule', 1),
--     ('https://github.com/etherofgod', 2),
--     ('https://github.com/wale', 6),
--     ('https://github.com/kvnmi', 3),
--     ('https://github.com/the-Apr', 4);

-- SELECT * from photos WHERE user_id = 1;

-- Join query joins two tables
SELECT * FROM photos
-- JOIN users ON users.id = photos.user_id;

-- DELETE FROM users WHERE id = 6;

-- DROP TABLE photos;

-- ALTER TABLE photos ADD CONSTRAINT
-- ON DELETE CASCADE (user_id);

--DELETE FROM users WHERE id = 6;