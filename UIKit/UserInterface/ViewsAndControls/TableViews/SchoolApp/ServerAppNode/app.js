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
app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.get("/student", (req, res) => {
    let sql = "SELECT * FROM student"
    if (req.query.id) {
        sql = `SELECT * FROM student WHERE id = ${req.query.id}`
    } else if (req.query.major) {
        sql = `SELECT * FROM student WHERE major LIKE "${req.query.major}%"`
    }

    connection.query(sql, (err, result) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: result, message: "Success" })
        }
    })
})

app.post("/student", (req, res) => {
    const sql = `INSERT INTO student(id, name, gender, grade) VALUES (?, ?, ?, ?)`
    const params = [req.body.id, req.body.name, req.body.gender, req.body.grade]

    connection.query(sql, params, (err, _) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: [req.body], message: "Success" })
        }
    })
})

app.listen(3000, () => {
    console.log("Listening on port 3000")
})