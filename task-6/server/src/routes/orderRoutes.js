import express from 'express'
import OrderController from '../controllers/orderController.js'
import PaymentController from '../controllers/paymentController.js'
import { authenticateToken } from '../middleware/authMiddleware.js'

const router = express.Router()

router.get('/orders', authenticateToken, OrderController.getUserOrders)
router.post('/orders/:id/pay', authenticateToken, PaymentController.processPayment)

export default router