const express = require("express")
const router = express.Router()
const UserRepo = require('../repos/user-repo')

router.get("/users", async (req, res) => {
    const users = await UserRepo.find()
    return res.status(200).json(users)
})

router.get("/users/:id", async (req, res) => {
    const { id } = req.params
    const user = await UserRepo.findById(id)
    
    if ( user ) {
        res.status(200).json(user)
    } else {
        res.status(404).json('user does not exist')
    }
})

router.post("/users", async (req, res) => {
    const body = req.body
    const user = await UserRepo.insert(body)
    return res.status(200).json(user)
})

router.put("/users/:id", async (req, res) => {
    const { id } = req.params
    const body = req.body
    const user = await UserRepo.update(id, body)
    if ( user ) {
        res.status(200).json(user)
    } else {
        res.status(404).json('user does not exist')
    }
})

router.delete("/users/:id", async (req, res) => {
    const { id } = req.params
    const user = await UserRepo.delete(id)
    if ( user ) {
        res.status(200).json(user)
    } else {
        res.status(404).json('user does not exist')
    }
})

// userRepo will be central point of interaction with the DB
module.exports = router