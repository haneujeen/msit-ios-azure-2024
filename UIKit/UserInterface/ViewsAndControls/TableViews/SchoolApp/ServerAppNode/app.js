const mysql = require('mysql2')
const connection = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "12345678",
    database: "school"
})
const express = require("express")
const morgan = require('morgan')
const app = express()
app.use(morgan("dev"))

app.get("/student", (req, res) => {
    connection.query("SELECT * FROM student", (err, result) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: result, message: "Success" })
        }
    })
})

app.listen(3000, () => {
    console.log("Listening on port 3000")
})