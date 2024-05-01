const mysql = require('mysql2')
const connection = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "12345678",
    database: "school"
})

connection.connect()

connection.end()