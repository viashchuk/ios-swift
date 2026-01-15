import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'

import userRepository from '../repositories/userRepository.js'

const login = async (req, res) => {
  const { email, password } = req.body
  const user = await userRepository.findByEmail(email)

  if (!user) {
    return res.status(401).json({ error: 'Invalid email' })
  }

  const validatePassword = await bcrypt.compare(password, user.password)

  if (!validatePassword) {
    return res.status(401).json({ message: 'Invalid password' })
  }

  const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' })

  const { id, email: userEmail, name: userName } = user

  res.status(200).json({
    token,
    user: {
      id,
      name: userName,
      email: userEmail,
    },
  })
}

const register = async (req, res) => {
  const { name, email, password } = req.body

  const existingUser = await userRepository.findByEmail(email)

  if (existingUser) {
    return res.status(400).json({ error: 'User already exists' })
  }

  const hashedPassword = await bcrypt.hash(password, 10)

  const newUser = await userRepository.create({
    name,
    email,
    password: hashedPassword,
  })

  const token = jwt.sign({ id: newUser.id }, process.env.JWT_SECRET, { expiresIn: '1h' })

  res.status(201).json({
    token,
    user: {
      id: newUser.id,
      email: newUser.email,
      name: newUser.name,
    },
  })
}

export default {
  login,
  register
}