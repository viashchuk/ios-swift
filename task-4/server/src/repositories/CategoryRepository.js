import Category from '../models/Category.js'

const findAll = async () => {
    return await Category.findAll({
        order: [['name', 'ASC']]
    })
}

export default {
    findAll
}