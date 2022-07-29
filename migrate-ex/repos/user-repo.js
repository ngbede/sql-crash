const pool = require("../db")
const camel = require("../utils/camel")

// option one to define the pool
// module.exports = {
//     find () {

//     },
//     findById(id) {

//     }
// }

// option two use classes

//class UserRepo {
//     find () {

//  }
// }

// could use static methods in a class

class UserRepo {
    /**
     * We never directly concate user provided input into an sql query
     */

    static async find() {
     //   await pool.connect()
        const { rows } = await pool.query('SELECT * FROM users;')
        let parsedRows = []
        // fix casing to camelCase
        if (rows.length > 0) {
            parsedRows = camel(rows)
        }
        return parsedRows
    }

    static async findById(id) {
       // await pool.connect()
        // this is the acceptable way to query stuff with custom values
        const { rows } = await pool.query(`SELECT * FROM users WHERE id = $1;`, [id])
        return camel(rows)[0]
    }

    static async insert(data) {
        //await pool.connect()
        const { rows } = await pool.query('INSERT INTO users (username, bio) VALUES ($1, $2) RETURNING *', [data.username, data.bio])
        return camel(rows)[0]
    }

    static async update(id, data) {
        //await pool.connect()
        const { rows } = await pool.query(`
            UPDATE users
            SET username = $1, bio = $2
            WHERE id = $3
            RETURNING *; -- returns the data after query
        `, [data.username, data.bio, id])
        return camel(rows)[0]
    }

    static async delete(id) {
        //await pool.connect()
        const { rows } = await pool.query(`
            DELETE FROM users
            WHERE id = $1
            RETURNING *;
        `, [id])
        return camel(rows)[0]
    }

    static async count() {
       // await pool.connect()
        const { rows } = await pool.query("SELECT COUNT(*) FROM users;")
        return parseInt(rows[0].count)
    }
}

module.exports = UserRepo