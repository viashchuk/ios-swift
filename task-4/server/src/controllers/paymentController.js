import Stripe from 'stripe'

import PaymentRepository from '../repositories/PaymentRepository.js'
import OrderRepository from '../repositories/OrderRepository.js'

const processPayment = async (req, res) => {
    try {
        const orderId = req.params.id
        const { cardNumber, expiryDate, cvv, cardholderName } = req.body

        if (!cardNumber || !expiryDate || !cvv || !cardholderName) {
            return res.status(400).json({
                success: false,
                error: 'All payment fields are required'
            })
        }

        const order = await OrderRepository.findById(orderId)

        if (!order) {
            return res.status(404).json({
                success: false,
                error: 'Order not found'
            })
        }

        if (order.status !== 'initialized') {
            return res.status(400).json({
                success: false,
                error: `Cannot process payment for order with status: ${order.status}`
            })
        }

        console.log(cardNumber)

        const cleanedCardNumber = cardNumber.replace(/\s/g, '')
        if (cleanedCardNumber.length < 16) {
            return res.status(400).json({
                success: false,
                error: 'Invalid card number'
            })
        }

        if (cvv.length !== 3 && cvv.length !== 4) {
            return res.status(400).json({
                success: false,
                error: 'Invalid CVV'
            })
        }

        const payment = await PaymentRepository.create({
            orderId: order.id,
            userId: req.user.id,
            amount: order.totalAmount,
            currency: 'USD',
            status: 'succeeded',
            cardLast4: cleanedCardNumber.slice(-4)
        })

        const updatedOrder = await OrderRepository.updateStatus(order.id, 'completed')

        res.json({
            success: true,
            payment,
            order: updatedOrder,
            message: 'Payment processed successfully'
        })

    } catch (error) {
        console.error('Process payment error:', error)
        res.status(500).json({
            success: false,
            error: 'Failed to process payment'
        })
    }
}

const processStripePayment = async (req, res) => {
    const stripe = new Stripe(process.env.STRIPE_SECRET_KEY)

    try {
        const orderId = req.params.id
        const order = await OrderRepository.findById(orderId)

        if (!order) {
            return res.status(404).json({ success: false, error: 'Order not found' })
        }

        const paymentIntent = await stripe.paymentIntents.create({
            amount: Math.round(order.totalAmount * 100),
            currency: 'usd',
            metadata: { orderId: order.id.toString() },
            payment_method_types: ['card'],
        })

        await PaymentRepository.create({
            orderId: order.id,
            userId: req.user.id,
            amount: order.totalAmount,
            currency: 'USD',
            status: 'pending',
            stripePaymentIntentId: paymentIntent.id
        })

        res.json({
            success: true,
            clientSecret: paymentIntent.client_secret,
            stripePaymentId: paymentIntent.id,
            publishableKey: process.env.STRIPE_PUBLIC_KEY
        })

    } catch (error) {
        console.error('Stripe error:', error)
        res.status(500).json({ success: false, error: error.message })
    }
}

const confirmStripePayment = async (req, res) =>{
        const { stripePaymentId } = req.body

        const payment = await PaymentRepository.findByStripePaymentIntentId(stripePaymentId)

        if (!payment) {
            return res.status(404).json({ success: false, error: 'Payment record not found' })
        }

        await PaymentRepository.updateStatus(payment.id, 'succeeded')

        const updatedOrder = await OrderRepository.updateStatus(payment.orderId, 'completed')

        res.json({
            success: true,
            order: updatedOrder,
            payment: payment,
            message: 'Payment processed successfully'
        })
}

export default {
    processPayment,
    processStripePayment,
    confirmStripePayment
}