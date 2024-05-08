const express = require('express')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const { User } = require('../models/index')
const router = express.Router()
const salt = process.env.JWT_SECRET

const hashPassword = async (password, saltRound) => {
    let hashed = await bcrypt.hash(password, saltRound)
    console.log(hashed)
    return hashed
}

const upload = require('./upload')
router.post('/sign-up', upload.single('image'))

router.post('/sign-up', async (req, res) => {
    const user = req.body
    user.fileName = req.fileName
    user.password = await hashPassword(user.password, 10)
    try {
        const result = await User.create(user)
        res.json({ success: true, documents: result, message: "Success" })
    } catch (err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

router.post('/sign-in', async (req, res) => {
    const { userId, password } = req.body
    const options = {
        attributes: ['userId', 'userName', 'password', 'fileName'],
        where: { userId: userId }
    }
    const user = await User.findOne(options)
    if (!user) { res.json({ success: false, message: "Not found" }) }

    if (bcrypt.compare(password, user.password)) {
        const token = jwt.sign({ uid: userId, rol: 'admin' }, salt)
        res.json({ success: true, 
            token: token, 
            user: {
                userId,
                "userName": user.userName,
                "fileName": user.fileName
            }, 
            message: "Success" })
    } else { 
        res.json({ success: false, message: "Invalid" })
    }
})

module.exports = router