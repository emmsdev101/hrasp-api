const express = require('express');
const  auth = require('../helper/auth');
const router = express.Router()

const adminControlloer = require('./../controllers/AdminController')

const panelController = require("./../controllers/PanelController")
router.get("/",(req, res)=>{
    panelController.getProfileDetails(req, res)
})
router.get("/getJobPosts",(req,res)=>panelController.getJobPosts(req, res))
router.get("/job-data/:id",(req, res)=>panelController.getJobData(req, res))
router.get("/getHiring",(req, res)=>panelController.getHiring(req, res))
router.get("/getApplicants/:status", (req, res)=>panelController.getApplicants(req, res))
router.get("/getJobPositions/:status", panelController.getJobPositions)
router.get("/getApplicantsForCommitteeMember/:status", adminControlloer.getApplicants)
router.get("/getApplicantsForCommitteeHead/:status", panelController.getApplicantsForCommitteeHeads)

router.post("/request-hiring",(req, res)=>{
    panelController.requestHiring(req, res)
})
router.get("/getApplicationDetails/:id", adminControlloer.getApplicationDetails)
router.post("/edit-hiring/:id",panelController.editHiring)
router.post("/cancel-request", panelController.cancelRequest)
router.post("/acceptApplication", adminControlloer.acceptApplication)
module.exports = router