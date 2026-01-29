import { User } from '../models/index.js'

const findByEmail = async (email) => {
    return await User.findOne({ where: { email } })
}

const findById = async (id) => {
    return await User.findOne({ where: { id } })
}

const create = async (userData) => {
    return await User.create(userData)
}

export default {
    findById,
    findByEmail,
    create
}