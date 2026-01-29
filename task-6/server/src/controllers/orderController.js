import OrderRepository from '../repositories/OrderRepository.js'
import ProductRepository from '../repositories/ProductRepository.js'

const getUserOrders = async (req, res) => {
    const { status } = req.query

    let orders
    if (status) {
        orders = await OrderRepository.findByUserIdAndStatus(req.user.id, status)
    } else {
        orders = await OrderRepository.findByUserId(req.user.id)
    }

    res.json({
        success: true,
        orders: orders,
    })
}

const getOrderById = async (req, res) => {
    const order = await OrderRepository.findById(req.params.id)

    if (!order) {
        return res.status(404).json({
            success: false,
            error: 'Order not found'
        })
    }

    if (order.userId !== req.user.id) {
        return res.status(403).json({
            success: false,
            error: 'Access denied'
        })
    }
    res.json({
        success: true,
        order
    })
}

const createOrder = async (req, res) => {
    try {
        const { items, paymentMethod } = req.body

        if (!items || !Array.isArray(items) || items.length === 0) {
            return res.status(400).json({
                success: false,
                error: 'Order items are required'
            })
        }

        if (!paymentMethod) {
            return res.status(400).json({
                success: false,
                error: 'Payment method is required'
            })
        }

        for (const item of items) {
            if (!item.productId || !item.productName || !item.size || !item.quantity || !item.price) {
                return res.status(400).json({
                    success: false,
                    error: 'Invalid item data. Each item must have productId, productName, size, quantity, and price'
                })
            }

            if (item.quantity <= 0) {
                return res.status(400).json({
                    success: false,
                    error: 'Item quantity must be greater than 0'
                })
            }

            if (item.price <= 0) {
                return res.status(400).json({
                    success: false,
                    error: 'Item price must be greater than 0'
                })
            }

            const product = await ProductRepository.findById(item.productId)
            if (!product) {
                return res.status(404).json({
                    success: false,
                    error: `Product with ID ${item.productId} not found`
                })
            }

            if (Math.abs(parseFloat(product.price) - parseFloat(item.price)) > 0.01) {
                return res.status(400).json({
                    success: false,
                    error: `Price mismatch for product ${product.name}`
                })
            }
        }

        const totalAmount = items.reduce((sum, item) => {
            return sum + (parseFloat(item.price) * parseInt(item.quantity))
        }, 0)

        const orderId = `ord_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`

        const orderItems = items.map((item, index) => ({
            id: `item_${Date.now()}_${index}`,
            productId: item.productId,
            productName: item.productName,
            size: item.size,
            quantity: item.quantity,
            price: item.price
        }))

        const order = await OrderRepository.create({
            id: orderId,
            userId: req.user.id,
            totalAmount: totalAmount.toFixed(2),
            status: 'initialized',
            paymentMethod
        }, orderItems)

        res.status(201).json({
            success: true,
            order,
            message: 'Order created successfully. Please proceed to payment.'
        })

    } catch (error) {
        console.error('Create order error:', error)
        res.status(500).json({
            success: false,
            error: 'Failed to create order',
            message: error.message
        })
    }
}


export default {
    getUserOrders,
    getOrderById,
    createOrder
}