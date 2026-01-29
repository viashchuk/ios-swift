import express from 'express'
import PaymentController from '../controllers/paymentController.js'
import { authenticateToken } from '../middleware/authMiddleware.js'

const router = express.Router()

router.post('/process', authenticateToken, PaymentController.processPayment)
// router.get('/history', authenticateToken, PaymentController.getPaymentHistory)
// router.get('/:id', authenticateToken, PaymentController.getPaymentById)
// router.post('/:id/refund', authenticateToken, PaymentController.refundPayment)

export default router