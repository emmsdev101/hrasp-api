const express = require('express');
const router = express.Router()
const adminControlloer = require('./../controllers/AdminController')


router.get('/', (req, res)=>{
    res.send("wellcome")
})
router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res))

router.post("/admin-login", (req, res)=>adminControlloer.login(req, res))


module.exports = router