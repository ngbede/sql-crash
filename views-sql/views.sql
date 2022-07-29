with alltags as (
    select user_id from photo_tags

    UNION ALL

    SELECT user_id from caption_tags
)

SELECT username, COUNT(*) as tag_count 
from alltags
join users on users.id = alltags.user_id
GROUP BY (username)
ORDER BY tag_count DESC
limit 10;


-- A view is kinda like a fake table that has references to rows from other tables in the DB.
-- somewhat similar to a CTE, can be made ahead of time and referenced in any place we'd reference a table
-- it doesn't actually create a new table or move any data around
-- any kind of query can be used in a view
-- its a query that gets executed every time you refer to it

-- view to merge both photo and caption tags

-- we first create the view "table"
-- CREATE VIEW tags AS (
--     select id, created_at, user_id, post_id, 'photo_tag' as type from photo_tags
--     UNION ALL
--     select id, created_at, user_id, post_id, 'caption_tag' as type from caption_tags
-- );


-- when to use views
-- use them for queries that require current/recent data

making changes to a VIEW
CREATE OR REPLACE VIEW tags AS (
    -- query to replace old view goes in here
    select id, user_id, post_id, 'photo_tag' as type from photo_tags
    UNION ALL
    select id, user_id, post_id, 'caption_tag' as type from caption_tags
);

-- then we can make use of it anywhere in our queries
select * from tags;

DROP VIEW tags: to delete a view


-- Matertialized View: a query that gets executed only at a very specifc time, but the results are saved and can be referenced without rerunning the query
-- results are saved and can be referred to without rerun. Good for use cases that involve expensive queries.

-- below query might be expensive
-- for each week, show number of likes that posts & comments received use post & comment created_at
select date_trunc(
    'week', COALESCE(posts.created_at, comments.created_at)
) as week, 
COUNT(posts.id) as num_posts_likes, 
COUNT(comments.id) as num_comments_likes
from likes 
left join posts on posts.id = likes.post_id
left join comments on comments.id = likes.comment_id
GROUP BY week
ORDER BY week;
--limit 1000;
-- DATE TRUNC: pulls one peice of info out of a timestamp, rounds down the info to the nearest value i.e nearest week, mearest day, month etc


-- using materialized view to iimprove the above query
CREATE MATERIALIZED VIEW weekly_likes AS (
        select date_trunc(
        'week', COALESCE(posts.created_at, comments.created_at)
    ) as week, 
    COUNT(posts.id) as num_posts_likes, 
    COUNT(comments.id) as num_comments_likes
    from likes 
    left join posts on posts.id = likes.post_id
    left join comments on comments.id = likes.comment_id
    GROUP BY week
    ORDER BY week
) WITH DATA; -- the 'WITH DATA' command tells postgres to run the query one time and hold all the results 

-- downside of MATERIALIZED view
-- modification made on table used to build the MATERIALIZED view don't sync to the already cached MATERIALIZED view unless manual rerun is done

-- In order to update a materialized view to carry new table changes
REFRESH MATERIALIZED VIEW name_of_view;
