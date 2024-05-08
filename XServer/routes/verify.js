const jwt = require('jsonwebtoken')
const salt = process.env.JWT_SECRET

const isVerified = async (req, res, next) => {
    const auth = req.get('Authorization')
    if (!(auth && auth.startsWith('Bearer '))) {
        res.json({ success: false, message: "No token" })
    }

    const token = auth.split(' ')[1]
    jwt.verify(token, salt, (err, decoded) => {
        if (err) {
            res.json({ success: false, message: "Invalid token" })
        } else {
            req.userId = decoded.uid
            req.role = decoded.rol
            next()
        }
    })
}

module.exports = isVerified