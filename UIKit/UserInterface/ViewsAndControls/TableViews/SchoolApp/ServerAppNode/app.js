const mysql = require('mysql2')
const connection = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "12345678",
    database: "school"
})
const express = require("express")
const app = express()

connection.connect()

app.use((_, res) => {
    connection.query("SELECT * FROM student", (err, result) => {
        if (err) {
            console.log(err)
            throw err
        }
        console.log("Result: ", result)
        res.json(result)
    })
})

app.listen(3000, () => {
    console.log("Listening on port 3000")
})