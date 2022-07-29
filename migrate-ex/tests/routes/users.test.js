const request = require("supertest")
const buildApp = require("../../index")
const userRepo = require("../../repos/user-repo")
const pool = require("../../db")
const { randomBytes } = require("crypto")
const { default: migrate } = require("node-pg-migrate")
const format = require("pg-format")
const Context = require("../context")
require("dotenv/config")


let context
jest.setTimeout(30000)
// runs before every other fnction is executed in this file
beforeAll( async () => {
  context = await Context.build()
})

beforeEach( async () => {
  await context.reset()
})

// runs after all function tests are done
afterAll(() => {
  // console.log("Done!");
  return context.close()
  // return pool.close()
})


// jest.useRealTimers()

it("create a user", async () => {
  
  const initialUserCount = await userRepo.count()

  await request(buildApp).post("/users").send({
    username: "test",
    bio: "this is a test"
  }).expect(200)

  const finalUserCount = await userRepo.count()
  expect(finalUserCount - initialUserCount).toEqual(1)
})
