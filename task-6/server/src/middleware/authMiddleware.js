import jwt from 'jsonwebtoken'
import userRepository from '../repositories/UserRepository.js'

export const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]

  if (!token) {
    return res.status(401).json({ error: 'Access denied. No token provided.' })
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)

    const user = await userRepository.findById(decoded.id)

    if (!user) {
      return res.status(404).json({ error: 'User not found' })
    }

    req.user = user

    next()
  } catch (err) {
    console.error('JWT Verification Error:', err.message)
    return res.status(403).json({ error: 'Invalid or expired token' })
  }
}