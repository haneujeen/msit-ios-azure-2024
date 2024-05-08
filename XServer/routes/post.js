const express = require('express')
const { Post } = require('../models/index')
const router = express.Router()

router.get('/', async (req, res) => {
    try {
        const allPosts = await Post.findAll()
        res.json({ success: true, documents: allPosts, message: "Success" })
    } catch (err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

router.get('/my', async (req, res) => {
    const options = {
        where: { userId: req.userId }
    }
    try {
        const allPosts = await Post.findAll(options)
        res.json({ success: true, documents: allPosts, message: "Success" })
    } catch (err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

router.post('/add', async (req, res) => {
    const post = req.body
    post.userId = req.userId;

    try {
        const result = await Post.create(post);
        res.json({ success: true, documents: result, message: "Success" })
    } catch (err) {
        res.json({ success: false, documents: [], message: err.message })
    }
})

router.put('/', async (req, res) => {
    const id = req.query.id
    try {
        const post = await Post.findOne({ where: { id: id, userId: req.userId } });
        const updatedPost = await post.update(req.body);
        res.json({ success: true, documents: updatedPost, message: "Success" });
    } catch (err) {
        res.json({ success: false, documents: [], message: err.message });
    }
})

router.delete('/', async (req, res) => {
    const id = req.query.id
    // Delete post...
})

module.exports = router