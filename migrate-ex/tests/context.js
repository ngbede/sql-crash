// const request = require("supertest")
// const buildApp = require("../../index")
// const userRepo = require("../../repos/user-repo")
const pool = require("../db")
const { randomBytes } = require("crypto")
const { default: migrate } = require("node-pg-migrate")
const format = require("pg-format")
require("dotenv/config")

class Context {
    static async build() {
        // generate random role name to connect to DB rolename must start with a string
        const roleName = "a" + randomBytes(4).toString("hex")

        // connect to DB 
        await pool.connect(true)

        // create a new role
        await pool.query(format('CREATE ROLE %I with LOGIN PASSWORD %L', roleName, roleName))
        await pool.query(format(`GRANT %I to postgres;`, roleName))

        // create a schema with the same name
        await pool.query(format(`CREATE SCHEMA %I AUTHORIZATION %I`, roleName, roleName))

        // Disconnect entirely from PG
        await pool.close()

        // migrations need to be run on the new schema
        await migrate({
            schema: roleName,
            direction: "up",
            log: () => {}, // dont throw logs to console
            noLock: true, // don't lock the DB while running the DB
            dir: "migrations",
            databaseUrl: {
            user: roleName,
            host: process.env.host,
            database: 'social-test',
            password: roleName,
            port: parseInt(process.env.port)
            }
        })

        return new Context(roleName)
    }

    constructor (roleName) {
        this.roleName = roleName
    }

    async close() {
        // disconnect from pg
        await pool.close()

        // reconnect as root user
        await pool.connect(true)

        // delete the role and schema we created
        await pool.query(format('DROP SCHEMA %I CASCADE', this.roleName))
        await pool.query(format('DROP ROLE %I', this.roleName))
        
        // then disconnect
        await pool.close()
    }

    async reset() {
        // DROP all table data
        return pool.query('DELETE FROM users;')
    }
}

module.exports = Context