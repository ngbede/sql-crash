const db = require("../../db")
require("dotenv/config")

const migrate = async () => {
    const client = db()
    try {
        await client.connect()
        client.query(`
            UPDATE posts
            SET loc = POINT(lat, long)
            WHERE loc IS NULL
        `).then(res => {
            console.log("update complete!")
            client.end()
        }).catch(err => {
            console.error(err)
        })

    } catch (error) {
        console.error(error)
    }
    
}

migrate()
