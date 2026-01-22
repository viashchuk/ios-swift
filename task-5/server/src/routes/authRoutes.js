import { Router } from 'express'
import authController from '../controllers/authController.js'

const router = Router()

router.post('/login', authController.login)
router.post('/register', authController.register)
router.post('/oauth/google', authController.googleAuth)
router.post('/oauth/github', authController.githubAuth)

export default router