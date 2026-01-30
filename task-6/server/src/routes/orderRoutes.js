import express from 'express'
import OrderController from '../controllers/orderController.js'
import PaymentController from '../controllers/paymentController.js'
import { authenticateToken } from '../middleware/authMiddleware.js'

const router = express.Router()

router.get('/orders', authenticateToken, OrderController.getUserOrders)
router.post('/orders/:id/pay', authenticateToken, PaymentController.processPayment)
router.post('/orders/:id/stripe-pay', authenticateToken, PaymentController.processStripePayment)
router.post('/orders/:id/stripe-confirm', authenticateToken, PaymentController.confirmStripePayment)

export default router