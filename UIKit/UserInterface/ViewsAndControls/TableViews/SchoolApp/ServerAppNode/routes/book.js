const express = require("express")
const router = express.Router()
const connection = require("../config/db")

router.get("/", (req, res) => {
    const sql = "SELECT id, title, author FROM book"

    connection.query(sql, (err, result) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: result, message: "Success" })
        }
    })
})

router.post("/", (req, res) => {
    const book = req.body
    const sql = "INSERT INTO book (id, title, author, sid) VALUES (?, ?, ?, ?)"
    const params = [book.id, book.title, book.author, book.sid]
    
    connection.query(sql, params, (err, _) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: [{}], message: "Success" })
        }
    })
})

module.exports = router