const app = require("./index")
const pool = require("./db")

pool.connect()
.then(() => {
    app.listen(3001, async () => {
        // const client = db()
        // await client.connect()
        // client.query("SELECT 1 + 1").then(res => console.log(res))
        console.log("running on port 3001");
    })
    
}).catch(err => {
    console.error(err)
    return "internal server error"
})
