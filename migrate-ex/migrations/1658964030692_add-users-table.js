/* eslint-disable camelcase */

exports.shorthands = undefined;

exports.up = pgm => {
    pgm.sql(`
        CREATE TABLE users (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            bio VARCHAR(400),
            username VARCHAR(30) NOT NULL
        );

        INSERT INTO users (username, bio) VALUES ('ngbede', 'Chelsea Fan');
    `)
};

exports.down = pgm => {
    pgm.sql(
       `DROP TABLE users;`
    )
};
