const express = require('express');
const { sendMail } = require('../helper/mailer');
const router = express.Router()
const adminControlloer = require('./../controllers/AdminController')
const panelController = require('./../controllers/PanelController')

router.get('/', (req, res)=>{
    res.send("wellcome")
})
router.get('/testEmail',sendMail)
router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res))
router.post("/admin-login", (req, res)=>adminControlloer.login(req, res))
router.post("/panel-login", (req, res)=>panelController.login(req, res))

router.post("/logout", (req, res)=>{
    console.log("logging out...")
    req.session.destroy((err)=>{
        req.session = null
        res.send({success:true})
    })
})


module.exports = router