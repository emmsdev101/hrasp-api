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
router.get("/getJobPositions/committee", panelController.getJobPositionsForCommittee)
router.get("/getJobPositions/head", panelController.getJobPositionsForCommitteeHead)
router.get("/getJobPositions/department", panelController.getJobPositionsForDepartment)


router.get("/getApplicantsForCommitteeMember/:status", panelController.getApplicantsForCommitteeMember)
router.get("/getApplicantsForCommitteeHead/:status", panelController.getApplicantsForCommitteeHeads)
router.get("/getEvaluationData/:id",adminControlloer.getEvaluationData)
router.get('/getEvaluationResults',panelController.getEvaluationResults)
router.get('/getEvaluationResultsForCommitteeMember', panelController.getEvaluationResultsForCommitteemember)
router.get('/getEvaluationResultsForCommitteeHead', panelController.getEvaluationResultsForCommitteeHead)
router.post("/request-hiring",(req, res)=>{
    panelController.requestHiring(req, res)
})
router.get("/getApplicationDetails/:id", adminControlloer.getApplicationDetails)
router.post("/edit-hiring/:id",panelController.editHiring)
router.post("/cancel-request", panelController.cancelRequest)
router.post("/acceptApplication", adminControlloer.acceptApplication)
router.post("/createEvaluation",adminControlloer.createEvaluation)
router.post("/evaluate",panelController.evaluate)
module.exports = router