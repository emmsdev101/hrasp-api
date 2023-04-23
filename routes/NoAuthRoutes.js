const express = require('express');
const { sendMail } = require('../helper/mailer');
const { sendSms } = require('../helper/smsSender');
const router = express.Router()
const adminControlloer = require('./../controllers/AdminController')
const panelController = require('./../controllers/PanelController')

router.get('/', (req, res)=>{
    let signups = req.app.get('signups')
    res.send("wellcome "+ signups)
})
router.get('/testSms/:phone/:messsage', (req, res)=>{
    const phone  = req.params.phone
    const message = req.params.messsage

    console.log(phone,message)
    const send = sendSms(phone, message)
    console.log(send)
    res.send(send)
})
router.get('/testEmail/:email/:subject/:message',(req, res)=>{
    const email  = req.params.email
    const subject = req.params.subject
    const message = req.params.message

    console.log(email,subject,message)
    const send = sendMail(subject, email, message)
    res.send(send)

})
router.post("/verifyEmail",(req, res)=>{
    const email = req.body.email

    if(!email) return res.send({success:false})

    const code = Math.floor(100000 + Math.random() * 900000)
    let signups = req.app.get('signups')
    signups[email] = code
    req.app.set('signups',signups)
    const emailId = sendMail("Email Verification",email, "Your Applicant Hiring Portal (AHP) verification code is: "+code)
    console.log(signups)
    if(emailId)return res.send({success:true})
    res.send({success:false})
})
router.post("/verifyCode",(req, res)=>{
    let signups = req.app.get('signups')
    const email = req.body.email
    const givenCode = req.body.code
    const code = signups[email]

    console.log("Generated Code:",code)
    console.log("Code Given:",givenCode)
    if(!email)return res.send({success:false, msg:"Email not specified"})
    if(!givenCode)return res.send({success:false, msg:"Code not specified"})
    res.send({correct:parseInt(code) === parseInt(givenCode)})

})
//router.get('/testEmail',sendMail)
router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res, 'portal'))
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