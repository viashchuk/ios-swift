import { User } from '../models/index.js'

const findByEmail = async (email) => {
    return await User.findOne({ where: { email } })
}

const create = async (userData) => {
    return await User.create(userData)
}

export default {
    findByEmail,
    create
}