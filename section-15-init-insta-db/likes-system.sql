CREATE TABLE insta_reactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE REFERENCES insta_users(id),
    post_id INTEGER UNIQUE REFERENCES insta_posts(id),
    reaction VARCHAR(12),
    CHECK( reaction IN ('like', 'dislike') ) -- kinda placeholder for enum
);

CREATE TABLE insta_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(40)
);

CREATE TABLE insta_posts (
    id SERIAL PRIMARY KEY,
    url VARCHAR(255) NOT NULL
);


-- COALESCE(NULL, 2) -- takes a look at values provided and returns the 1st value that is not NULL