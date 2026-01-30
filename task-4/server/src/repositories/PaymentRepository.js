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

const findByStripePaymentIntentId = async (stripePaymentIntentId) => {
  try {
    return await Payment.findOne({
      where: { stripePaymentIntentId: stripePaymentIntentId }
    })
  } catch (error) {
      throw new Error('Payment not found')
  }
}

const updateStatus = async (id, status) => {
  try {
    const payment = await findById(id)
    if (!payment) {
      throw new Error('Payment not found')
    }
    payment.status = status
    return await payment.save()
  } catch (error) {
    throw error
  }
}

export default {
  findById,
  create,
  findByOrderId,
  findByStripePaymentIntentId,
  updateStatus
}