const express = require('express')
const router = express.Router()

const uploader = require('./../helper/uploader')

const applicantController = require('./../controllers/ApplicantController')
const adminControlloer = require("./../controllers/AdminController")
const conferenceController = require('./../controllers/ConferenceController')

router.get('/getConferenceToken/:room_id/:fullname',conferenceController.generateUsersToken)


router.get('/', (req, res)=>{
    res.send("Wellcome")
})

router.get("/getJobPosts", adminControlloer.getJobPosts)
router.get("/getProfileDetails", applicantController.getProfileDetails)

router.post('/upload-letter', uploader.upload('uploads/applicant/letters').array("files"),(req,res)=>uploader.getPathArray(req, res))
router.post('/upload-tor', uploader.upload('uploads/applicant/tor').array("files"),(req,res)=>uploader.getPathArray(req, res))
router.post('/upload-pds', uploader.upload('uploads/applicant/pds').array("files"),(req,res)=>uploader.getPathArray(req, res))
router.post('/upload-certs', uploader.upload('uploads/applicant/certs').array("files"),(req,res)=>uploader.getPathArray(req, res))
router.post("/editProfile", applicantController.editProfile)
router.post('/apply',(req, res)=>{
  applicantController.apply(req, res)
})
router.post("/changePassword",applicantController.changePassword)

router.post("/register", (req, res)=>applicantController.register(req, res))
router.post("/login", (req, res)=>applicantController.login(req, res))
router.get("/getApplication", (req, res)=>applicantController.getApplication(req, res))
router.get("/getSchedule", (req, res)=>applicantController.getSchedule(req, res))

module.exports = router