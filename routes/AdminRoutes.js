const express = require('express');
const  auth = require('../helper/auth');
const router = express.Router()

const uploader = require('../helper/uploader')

const adminControlloer = require('./../controllers/AdminController')


router.get('/', (req, res)=>{
    res.send("wellcome")
})
router.post('/postJob', (req, res)=>adminControlloer.postJob(req, res))
router.post('/upload', uploader.upload('uploads/admin/images/jobPosts').single('file'), (req, res)=>{
    adminControlloer.upload(req, res)
} )
router.post("/login", (req, res)=>adminControlloer.login(req, res))

router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res))
router.get("/getApplicants", adminControlloer.getApplicants)

module.exports = router