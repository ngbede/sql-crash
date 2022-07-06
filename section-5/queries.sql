-- Group by finds the unique instances of a given column
-- then takes each row and assigns it to the group based on the given column
SELECT user_id, COUNT(contents) AS number_of_comments
FROM comments GROUP BY user_id;

-- Aggregate functions include COUNT AVG MIN MAX SUM etc
-- used independently of select mixed with other columns or alongside the GROUP BY keyword

-- AGGREGATEs functs applied on group by returns only result of each groupreturns only result of each grouplt of each grouplt of each group

-- COUNT doesn't include null rows by DEFAULT
-- to bypass that we can use COUNT(*) advisable to use this when trying to get actual no. of rows 

-- No of comments for each photo
SELECT photo_id, COUNT(*)
FROM comments 
GROUP BY photo_id
ORDER BY photo_id;

-- HAVING keyword is used to filter on GROUP BY statements 
SELECT photo_id, COUNT(*)
FROM comments WHERE photo_id < 3
GROUP BY photo_id
HAVING COUNT(comments) > 2; -- check using AGGREGATE function where there are more than 2 comments 

-- FIND users where user commented on first 2 photos and user added more than 2 comments on these photos 

SELECT c.user_id, COUNT(*)
FROM comments c
WHERE c.photo_id <= 50
GROUP BY c.user_id
HAVING COUNT(*) > 20 -- user has more than 20 comments per photo
ORDER BY c.user_id;
