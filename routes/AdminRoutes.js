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
router.post("/acceptApplication", adminControlloer.acceptApplication)


router.get('/getJobPosts', (req, res)=>adminControlloer.getJobPosts(req, res))
router.get("/getApplicants/:status", adminControlloer.getApplicants)
router.get("/getApplicationDetails/:id", adminControlloer.getApplicationDetails)
router.get("/getJobPositions", adminControlloer.getJobPositions)
router.get("/getPanels",(req, res)=>adminControlloer.getPanels(req, res))
router.get("/getCommittees",(req, res)=>adminControlloer.getCommitees(req, res))

router.post('/setSchedule', adminControlloer.setSchedule)
router.post('/resetSchedule', adminControlloer.resetSchedule)
router.post('/startInterview', adminControlloer.startInterview)
router.post('/addPanel',(req, res)=>adminControlloer.addPanel(req,res))
router.post("/editPanel/:id", (req, res)=>adminControlloer.editPanel(req, res))
router.post("/deletePanel",(req, res)=>adminControlloer.deletePanel(req, res))
router.post("/approve-request",(req, res)=>adminControlloer.approveRequest(req, res))
router.post('/addCommitee', adminControlloer.addCommittee)
router.post("/editCommittee/:id", (req, res)=>adminControlloer.editCommittee(req, res))
router.post("/deleteCommittee",(req, res)=>adminControlloer.deleteCommittee(req, res))
router.post("/endInterview",adminControlloer.endInterview)

module.exports = router