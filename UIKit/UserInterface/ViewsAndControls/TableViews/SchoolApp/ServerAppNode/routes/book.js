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
    book.id = +book.id
    book.sid = +book.sid
    
    connection.query(sql, params, (err, result) => {
        if (err) {
            res.json({ success: false, documents: [], message: err.message })
        } else {
            res.json({ success: true, documents: [], message: "Success" })
        }
    })
})

router.put("/:id", (req, res) => {
    const sql = "UPDATE book SET title = ? WHERE id = ?"
    const params = [req.body.title, req.params.id]
    
    connection.query(sql, params, (err, _) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: [{}], message: "Success" })
        }
    })
})

router.delete("/", (req, res) => {
    const sql = ""
    const params = []
    
    connection.query(sql, params, (err, result) => {
        if (err) {
            res.json({ success: false, documents: [{}], message: err.message })
        } else {
            res.json({ success: true, documents: result, message: "Success" })
        }
    })
})

module.exports = router