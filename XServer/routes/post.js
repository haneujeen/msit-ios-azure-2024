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

router.post('/add', async (req, res) => {
    const post = req.body;
    post.userId = req.userId; 
    console.log("Attempting to save post:", post);

    try {
        const result = await Post.create(post);
        res.json({ success: true, documents: result, message: "Success" });
    } catch (err) {
        console.log("Error creating post:", err);
        res.json({ success: false, documents: [], message: err.message });
    }
});

module.exports = router