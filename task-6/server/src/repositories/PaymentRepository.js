import { Order, Payment } from '../models/index.js'

const create = async (paymentData) => {
  try {
    return await Payment.create(paymentData)
  } catch (error) {
    throw error
  }
}

const findById = async (id) => {
  try {
    return await Payment.findByPk(id, {
      include: [
        {
          model: Order,
          as: 'order'
        }
      ]
    })
  } catch (error) {
    throw error
  }
}

const findByOrderId = async (orderId) => {
  try {
    return await Payment.findOne({
      where: { orderId },
      include: [
        {
          model: Order,
          as: 'order'
        }
      ]
    })
  } catch (error) {
    throw error
  }
}

export default {
  findById,
  create,
  findByOrderId
}