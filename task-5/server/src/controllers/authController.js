import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import fetch from 'node-fetch'

import userRepository from '../repositories/userRepository.js'

const GOOGLE_TOKEN_INFO_URL = process.env.GOOGLE_TOKEN_INFO_URL
const JWT_SECRET = process.env.JWT_SECRET

const GITHUB_CLIENT_ID = process.env.GITHUB_CLIENT_ID
const GITHUB_CLIENT_SECRET = process.env.GITHUB_CLIENT_SECRET

const GITHUB_ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token"
const GITHUB_USER_API = "https://api.github.com/user"
const GITHUB_USER_EMAILS_API = "https://api.github.com/user/emails"

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

export const googleAuth = async (req, res) => {
  try {
    const { email, name, token } = req.body; 

    if (!token) {
      return res.status(400).json({ message: "Token is required" });
    }

    const googleVerifyRes = await fetch(`${GOOGLE_TOKEN_INFO_URL}?id_token=${token}`);  

    const googleData = await googleVerifyRes.json();

    if (googleData.error_description) {
      return res.status(401).json({ message: "Invalid Google Token" });
    }

    let user = await userRepository.findByEmail(email);

    if (!user) {
      user = await userRepository.create({ 
        name, 
        email, 
        googleToken: token
      });
    } else {
      await userRepository.updateGoogleToken(user.id, token);
    }

    const internalToken = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '1h' })

    res.status(200).json({
      token: internalToken,
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      }
    });

  } catch (error) {
    console.error("Auth Error:", error)
  }
}

export const githubAuth = async (req, res) => {
  const { code } = req.body

  if (!code) {
    return res.status(400).json({ message: "Code is required" })
  }

  try {
    const tokenRequestData = new URLSearchParams({
      code,
      client_id: process.env.GITHUB_CLIENT_ID,
      client_secret: process.env.GITHUB_CLIENT_SECRET,
    });

    const tokenResponse = await fetch(GITHUB_ACCESS_TOKEN_URL, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: tokenRequestData,
    })

    const { access_token, error, error_description } = await tokenResponse.json()

    if (error) {
      return res.status(401).json({ message: error_description || error })
    }

const userInfoResponse = await fetch(`${GITHUB_USER_API}`, {
      headers: {
        Authorization: 'token ' + access_token,
        'User-Agent': 'Node-Fetch'
      }
    })

    const userInfo = await userInfoResponse.json()

    const name = userInfo.name || userInfo.login
    let email = userInfo.email

    if (!email) {
      email = await fetchPrimaryEmail(access_token)
    }

    let user = await userRepository.findByEmail(email)

    if (!user) {
      user = await userRepository.create({ 
        name, 
        email, 
        githubToken: access_token 
      })
    } else {

      await userRepository.updateGithubToken(user.id, access_token)
    }

    const internalToken = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '1h' });

    res.status(200).json({
      token: internalToken,
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      }
    })

  } catch (error) {
    console.error("GitHub Auth Error:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
}

async function fetchPrimaryEmail(access_token) {
  const response = await fetch('https://api.github.com/user/emails', {
    headers: {
      'Authorization': `token ${access_token}`,
      'User-Agent': 'Node-Fetch'
    }
  });

  const emails = await response.json();
  const primaryEmailObj = emails.find(email => email.primary && email.verified);
  
  return primaryEmailObj ? primaryEmailObj.email : emails[0].email;
}

export default {
  login,
  register,
  googleAuth,
  githubAuth
}