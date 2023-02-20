const express = require('express');
const  auth = require('../helper/auth');
const router = express.Router()

const uploader = require('../helper/uploader')

const adminControlloer = require('./../controllers/AdminController')
const panelController = require('./../controllers/PanelController')

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
router.get('/getEvaluationResults/:type/:department/:position',adminControlloer.getEvaluationResults)
router.get("/getEvaluationData/:id",adminControlloer.getEvaluationData)
router.get("/getAccounts",adminControlloer.getAccounts)
router.get("/getPanelEvaluations/:applicationId",adminControlloer.getPanelEvaluations)
router.get("/getCommitteeDetails/:id", panelController.getCommitteeDetails)
router.get("/getPanelDetails/:id",panelController.getPanelDetails)
router.get("/getJobPositions/:type/:department", panelController.getJobPositions)



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
router.post("/acceptAccount",adminControlloer.acceptAccount)
router.post("/decline",adminControlloer.decline)
router.post("/deactivate",adminControlloer.deactivate)

module.exports = router