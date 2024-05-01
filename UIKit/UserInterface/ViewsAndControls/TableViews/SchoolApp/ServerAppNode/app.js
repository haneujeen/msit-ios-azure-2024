const mysql = require('mysql2')
const connection = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "12345678",
    database: "school"
})

connection.connect()

connection.query("SELECT * FROM student", (err, result) => {
    if (err) {
        console.log(err)
        throw error
    }
    console.log("Result: ", result)
})

connection.end()