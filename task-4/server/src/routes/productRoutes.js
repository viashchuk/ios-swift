import { Router } from 'express'
import productController from '../controllers/ProductController.js'

const router = Router()

router.get('/', productController.getAllProducts)

export default router