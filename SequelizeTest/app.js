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
const { Student,Book, Car } = require("./models")
const port = process.env.PORT || 3000

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const { Op } = require("sequelize")

app.get("/students", async (req, res) => {
    let where = { deletedAt: null }
    if (req.query.major && req.query.grade) {
        where = { ...where, major: req.query.major, grade: { [Op.gte]: req.query.grade } }
    }

    const options = {
        attributes: ["id", "name", "gender", "major", "grade"],
        where: where
    }

    try {
        const result = await Student.findAll(options)
        res.json({ success: true, documents: [result], message: "Success" })
    } catch(err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

app.post("/students", (req, res) => {
    const newStudent = req.body
    // const student = await Student.create(student)
    Student.create(newStudent).then((student) => {
        res.json({ success: true, documents: [student], message: "Success" })
    }).catch((err) => {
        res.json({ success: false, documents: [], message: err.message })
    })
})

app.put("/students/:id", async (req, res) => {
    try {
        const student = await Student.findByPk(req.params.id)
        const editedStudent = await student.update(req.body)
        res.json({ success: true, documents: [editedStudent], message: "Success" })
    } catch(err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

app.delete("/students/:id", async (req, res) => {
    try {
        const student = await Student.findByPk(req.params.id)
        await student.destroy()
        res.json({ success: true, documents: [student], message: "Success" })
    } catch(err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

app.listen(port)