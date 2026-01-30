import { Order, OrderItem, Product } from '../models/index.js'
import sequelize from '../config/database.js'

const create = async (orderData, items) => {
    const transaction = await sequelize.transaction()

    try {
        const order = await Order.create(orderData, { transaction })

        const orderItems = items.map(item => ({
            ...item,
            orderId: order.id
        }))

        await OrderItem.bulkCreate(orderItems, { transaction })

        await transaction.commit()

        return await findById(order.id)
    } catch (error) {
        await transaction.rollback()
        throw error
    }
}

const findById = async (id) => {
    try {
        return await Order.findByPk(id, {
            include: [
                {
                    model: OrderItem,
                    as: 'items',
                    include: [
                        {
                            model: Product,
                            as: 'product'
                        }
                    ]
                }
            ]
        })
    } catch (error) {
        throw error
    }
}

const findByUserId = async (userId) => {
    try {
        return await Order.findAll({
            where: { userId },
            include: [
                {
                    model: OrderItem,
                    as: 'items',
                    include: [
                        {
                            model: Product,
                            as: 'product'
                        }
                    ]
                }
            ],
            order: [['createdAt', 'DESC']]
        })
    } catch (error) {
        throw error
    }
}

const findByUserIdAndStatus = async (userId, status) => {
    return await Order.findAll({
        where: {
            userId,
            status
        },
        include: [
            {
                model: OrderItem,
                as: 'items',
                include: [
                    {
                        model: Product,
                        as: 'product'
                    }
                ]
            }
        ],
        order: [['createdAt', 'DESC']]
    })
}

const updateStatus = async (orderId, status) => {
    const order = await Order.findByPk(orderId)
    if (!order) {
        throw new Error('Order not found')
    }

    order.status = status
    await order.save()

    return order
}

export default {
    findById,
    create,
    findByUserId,
    findByUserIdAndStatus,
    updateStatus
}