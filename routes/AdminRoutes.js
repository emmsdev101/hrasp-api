const express = require('express')
const router = express.Router()

const uploader = require('./../helper/uploader')

const adminControlloer = require('./../controllers/AdminController')

router.get('/', (req, res)=>{
    res.send("Wellcome to admin api")
})
router.post('/postJob', (req, res)=>adminControlloer.postJob(req, res))
router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res))
router.post('/upload', uploader.upload('uploads/admin/images/jobPosts').single('file'), (req, res)=>{
    adminControlloer.upload(req, res)
} )
module.exports = router