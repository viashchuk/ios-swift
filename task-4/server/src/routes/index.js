import { Router } from 'express'

import authRoutes from './authRoutes.js'
import productRoutes from './productRoutes.js'
import orderRoutes from './orderRoutes.js'
import categoryRoutes from './categoryRoutes.js'

const router = Router()

router.use('/api/', authRoutes)
router.use('/api/products/', productRoutes)
router.use('/api/orders/', orderRoutes)
router.use('/api/categories/', categoryRoutes)

export default router