import express from 'express'
import OrderController from '../controllers/orderController.js'
import PaymentController from '../controllers/paymentController.js'
import { authenticateToken } from '../middleware/authMiddleware.js'

const router = express.Router()

router.get('/', authenticateToken, OrderController.getUserOrders)
router.post('/:id/pay', authenticateToken, PaymentController.processPayment)
router.post('/:id/stripe-pay', authenticateToken, PaymentController.processStripePayment)
router.post('/:id/stripe-confirm', authenticateToken, PaymentController.confirmStripePayment)

export default router