// const sync = require('./models/sync')
// sync()

const express = require('express')
const morgan = require('morgan')
const dotenv = require('dotenv')
dotenv.config()
const port = process.env.PORT || 3000
const app = express()
const authRouter = require('./routes/auth')
const postRouter = require('./routes/post')
const verify = require('./routes/verify')

app.use(morgan('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use('/post', verify)
app.use('/auth', authRouter)
app.use('/post', postRouter)

app.listen(port)