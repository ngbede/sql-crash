const pg = require("pg")
require("dotenv/config")

const pgClient = () => {
    console.error(`using Postgres ${process.env.host}`)
    const client = new pg.Client({
      user: process.env.user,
      host: process.env.host,
      database: process.env.database,
      password: process.env.password,
      port: parseInt(process.env.port)
    })
    return client
}

class Pool {
  _pool = null

  connect(testMode, user, password) {
    this._pool = new pg.Client({
      user: user ?? process.env.user,
      host: process.env.host,
      database: testMode ? 'social-test' : process.env.database,
      password: password ?? process.env.password,
      port: parseInt(process.env.port)
    })
    console.log("Running in test env");
    return this._pool.connect()
  }

  close () {
    return this._pool.end()
  }

  // sql injection oga...
  query (sql, params) {
    return this._pool.query(sql, params)
  }
}

module.exports = new Pool()
