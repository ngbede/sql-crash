-- find all comments for photo with id 3 along side username of comment AUTHORIZATION
SELECT contents, username, photo_id 
FROM comments -- ran first
-- combine comments and users table into one using the users id and comments user_id as the descriptor to MATCH
JOIN users on users.id = comments.user_id; 


-- for each comment list the contents of the comment and the url of the photo comment was added to
SELECT photos.id AS photo_id, contents, url
FROM comments -- AS p we can rename the table and reference it later on in queries
LEFT JOIN photos ON comments.photo_id = photos.id;


SELECT url, username
FROM photos
LEFT JOIN users ON users.id = photos.user_id;

SELECT url, username
FROM users RIGHT JOIN photos ON users.id = photos.user_id;

-- full join returns all results
SELECT url, username
FROM users 
FULL JOIN photos ON users.id = photos.user_id;

-- find for photo with id and get number of comments attached to it
-- find avg number of comments per photo
-- find user with most activity (most comment + photos)
-- find photo with most comments attached to it
-- calculate avg number of characters per comment


-- who is commenting on their own photos
-- WE can add where clauses after the Join statement
SELECT url, contents
FROM comments AS c
JOIN photos AS p on c.photo_id = p.id
WHERE c.user_id = p.user_id;

-- 3 way joins to include the username
-- second JOIN contains the bulk of the logic
SELECT username, url, contents
FROM comments AS c
JOIN photos AS p on c.photo_id = p.id
JOIN users AS u ON u.id = c.user_id AND u.id = p.user_id -- merge the users table
-- WHERE c.user_id = p.user_id;