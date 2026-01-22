import { User } from '../models/index.js'

const findByEmail = async (email) => {
    return await User.findOne({ where: { email } })
}

const create = async (userData) => {
    return await User.create(userData)
}

const updateGoogleToken = async (id, token) => {
  return await User.update(
    { googleToken: token },
    { where: { id } }
  )
}

export default {
    findByEmail,
    create,
    updateGoogleToken
}