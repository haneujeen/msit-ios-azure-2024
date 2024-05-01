const express = require("express")
const router = express.Router()
const connection = require("../config/db")

router.get("/", (req, res) => {
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

router.post("/", (req, res) => {
    const sql = "INSERT INTO student (id, name, gender, grade) VALUES (?, ?, ?, ?)"
    const params = [req.body.id, req.body.name, req.body.gender, req.body.grade]

    connection.query(sql, params, (err, _) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: [{}], message: "Success" })
        }
    })
})

router.put("/:id", (req, res) => {
    const sql = "UPDATE student SET major = ? WHERE id = ?"
    const params = [req.body.major, req.params.id]

    connection.query(sql, params, (err, _) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: [{}], message: "Success" })
        }
    })
})

router.get("/:id/books", (req, res) => {
    const sql = "SELECT id, title, author FROM book WHERE sid = ?"
    const params = [req.params.id]

    connection.query(sql, params, (err, result) => {
        if (err) {
            res.json({ success: false, 
                documents: [{}], 
                message: err.message})
        } else {
            res.json({ success: true, documents: result, message: "Success" })
        }
    })
})

module.exports = router