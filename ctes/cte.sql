-- Common table expression, allow us to define queries in one spot and use in another

with ab as (
	select * from 
	public.users u
	join likes l on u.id = l.user_id
)

select username, COUNT(*)
from ab
group by ab.username
limit 50;

-- recursive cte's 
-- useful for workng with trees or graph type data structures
-- must use a union keyword 
-- once recursive cte returns no rows at any step we end recursion

WITH RECURSIVE countdown(val) AS ( -- basically arguements in like a function
    select 10 as val -- initial or non-recursive query
    UNION
    SELECT val - 1 from countdown where val > 1 -- recursive query
)

SELECT * from countdown;

why use ctes
basically for graph and tree DS

GET recommendations of who to follow based on who the people you follow are FOLLOWING

with RECURSIVE recommendation (leader_id, follower_id, depth) AS (
    SELECT leader_id, follower_id, 1 as depth
    FROM followers
    where follower_id = 1

    UNION

    select followers.leader_id, followers.follower_id, depth + 1
    from followers
    JOIN recommendation on recommendation.leader_id = followers.follower_id
    WHERE depth < 2
)

select DISTINCT users.id, users.username 
from recommendation
JOIN users on users.id = recommendation.leader_id
where depth > 1 limit 30;