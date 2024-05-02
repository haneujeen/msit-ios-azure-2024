const { sequelize } = require("./models/index")
// sequelize.sync({ force: true, alter: true }).then((result) => {
//     console.log("Synced")
// }).catch((err) => {
//     console.log(err)
// });

const express = require("express")
const morgan = require("morgan")
const app = express() 
app.use(morgan("dev"))
const studentRouter = require("./routes/student")
const port = process.env.PORT || 3000

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use("/students", studentRouter)

app.listen(port)