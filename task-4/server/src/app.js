import express from 'express'
import dotenv from 'dotenv'
import cors from 'cors'

import routes from './routes/index.js'
import { seedAll } from './config/seeders.js'
import sequelize from './config/database.js'

dotenv.config()
const app = express()
const port = process.env.PORT || 8000

app.use(cors())
app.use(express.json())

app.use('/', routes)

const startServer = async () => {
  try {
    await sequelize.sync({ force: false })

    await seedAll()

    app.listen(port)
  } catch (err) {
    console.error(err)
  }
}

startServer()