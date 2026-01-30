import Product from '../models/Product.js'
import Category from '../models/Category.js'

const findAll = async () => {
    return await Product.findAll({
        include: [
            {
                model: Category,
                as: 'category'
            }
        ],
        order: [['name', 'ASC']]
    })
}

const findById = async (id) => {
    return await Product.findByPk(id, {
        include: [
            {
                model: Category,
                as: 'category'
            }
        ]
    })
}

const findByCategoryId = async (categoryId) => {
    return await Product.findAll({
        where: { categoryId },
        include: [
            {
                model: Category,
                as: 'category'
            }
        ],
        order: [['name', 'ASC']]
    })
}

export default {
    findAll,
    findById,
    findByCategoryId
}