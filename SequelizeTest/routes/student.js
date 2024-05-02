const express = require("express")
const router = express.Router()
const { Student, Book } = require("../models")

router.get("/", async (req, res) => {
    let where = { deletedAt: null }
    Object.keys(req.query).forEach(key => {
        where[key] = req.query[key]
    })

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

router.post("/", (req, res) => {
    const newStudent = req.body
    // const student = await Student.create(student)
    Student.create(newStudent).then((student) => {
        res.json({ success: true, documents: [student], message: "Success" })
    }).catch((err) => {
        res.json({ success: false, documents: [], message: err.message })
    })
})

router.put("/:id", async (req, res) => {
    try {
        const student = await Student.findByPk(req.params.id)
        const editedStudent = await student.update(req.body)
        res.json({ success: true, documents: [editedStudent], message: "Success" })
    } catch(err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

router.delete("/:id", async (req, res) => {
    try {
        const student = await Student.findByPk(req.params.id)
        await student.destroy()
        res.json({ success: true, documents: [student], message: "Success" })
    } catch(err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

module.exports = router