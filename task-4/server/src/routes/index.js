import { Router } from 'express'

import authRoutes from './authRoutes.js'
import productRoutes from './productRoutes.js'
import orderRoutes from './orderRoutes.js'

const router = Router()

router.use('/api/', authRoutes)
router.use('/api/', productRoutes)
router.use('/api/', orderRoutes)

export default router