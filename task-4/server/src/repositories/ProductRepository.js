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

const create = async (productData) => {
    return await Product.create(productData)
}

export default {
    findAll,
    findById,
    findByCategoryId,
    create
}