const multer = require('multer')
const path = require('path')
const fs = require('fs')

try {
    fs.readdirSync('files')
} catch (err) {
    console.error(err)
    fs.mkdirSync('files')
}

const upload = multer({
    storage: multer.diskStorage({
        destination(req, res, next) {
            next(null, 'files/')
        },
        filename(req, res, next) {
            const ext = path.extname(res.originalname)
            req.fileName = path.basename(res.originalname, ext) + Date.now() + ext
            next(null, req.fileName)
        }
    }),
    limits: { fileSize: 50 * 1024 * 1024 }
})

module.exports = upload