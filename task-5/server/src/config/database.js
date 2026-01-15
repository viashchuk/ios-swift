import { Sequelize } from 'sequelize'
import dotenv from 'dotenv'


dotenv.config()

const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: process.env.DATABASE_URL, 
})

// { force: true }
sequelize.sync({ force: true })
  .then(async () => {
})
  .catch((err) => console.error('Database sync error:', err))

export default sequelize