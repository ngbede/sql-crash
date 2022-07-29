// command to create migration is listed below
// npm run migrate 'descriptive name for migration"

const express = require("express")
const bodyParser = require("body-parser")
const app = express()
const db = require("./db")
const userRoute = require("./routes/users")

app.use(bodyParser.json())

app.get("/posts", async (req, res, next) => {
    const client = db.pgClient()
    try {
        await client.connect()
        const { rows } = await client.query('SELECT id, url, loc FROM posts;')
        return res.status(200).json(rows)    
    } catch (error) {
        return res.status(500).json(error)
    }
    
})

app.post("/posts", async (req, res, next) => {
    const body = req.body
    const client = db.pgClient()
    try {
        await client.connect()
        const { rows } = await client.query(`
            INSERT INTO posts (url, loc) 
            VALUES ('${body.url}', '(${body.lat}, ${body.long})')
        `)
        console.log(rows)
        return res.status(200).json({message: 'success', data: rows})    
    } catch (error) {
        console.log(error)
        return res.status(500).json(error)
    }
    
})

app.use(userRoute)

module.exports = app
