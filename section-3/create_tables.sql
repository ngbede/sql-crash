-- create users table
-- SERIAL datatype autogenerates integers automatically
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

-- INSERT INTO users (username) VALUES ('ngbede');

-- create photos table
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(255),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

-- ON DELETE SET NULL => this CONSTRAINT sets every reference to NULL on delete of origin