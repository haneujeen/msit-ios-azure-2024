const express = require("express")
const morgan = require('morgan')
const app = express()
const studentRouter = require("./routes/student")
const bookRouter = require("./routes/book")

app.use(morgan("dev"))
app.use(express.json()) // req.body = Raw JSON
app.use(express.urlencoded({extended: true})) // req.body = Form urlencoded 
app.use("/student", studentRouter)
app.use("/book", bookRouter)

app.listen(3000, () => {
    console.log("Listening on port 3000")
})