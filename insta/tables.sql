-- create user table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(30) NOT NULL,
    bio VARCHAR(400) DEFAULT '',
    avatar VARCHAR(200),
    phone VARCHAR(25),
    email VARCHAR(50),
    password VARCHAR(70),
    status VARCHAR(15),
    CHECK( COALESCE(phone, email) IS NOT NULL)
);

-- post TABLE
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    url VARCHAR(200) NOT NULL,
    caption VARCHAR(240),
    lat REAL,
    lng REAL,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    CHECK (lat IS NULL OR (lat >= -90 AND lat <= 90)),
    CHECK (lng IS NULL OR (lng >= -180 AND lng <= 180))
);


-- comments table 
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    comments VARCHAR(240) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE
);

-- likes table
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
    CHECK ( 
        COALESCE((post_id)::BOOLEAN::INTEGER, 0)
        +
        COALESCE((comment_id)::BOOLEAN::INTEGER, 0)
        = 1
    ),
    UNIQUE(user_id, post_id, comment_id) -- a user can only like post or comment once
);

-- photo_tags table
CREATE TABLE photo_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    UNIQUE(user_id, post_id) -- a user can be tagged once per post
);

-- caption_tags table 
CREATE TABLE caption_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    UNIQUE(user_id, post_id)
);

-- create hashtags_table
CREATE TABLE hashtags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(30) NOT NULL UNIQUE
);

-- hashtag per post table
CREATE TABLE hashtags_posts (
    id SERIAL PRIMARY KEY,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    UNIQUE (hashtag_id, post_id)
);

-- followers table
CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    leader_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE (leader_id, follower_id)
);


-- ALTER TABLE IF EXISTS public.comments
--     RENAME comments TO contents;