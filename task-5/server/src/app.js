import express from 'express'
import dotenv from 'dotenv'
import cors from 'cors'


import routes from './routes/index.js'


dotenv.config()
const app = express()
const port = process.env.PORT || 8000

app.use(cors())
app.use(express.json())
app.use('/', routes)

app.listen(port)