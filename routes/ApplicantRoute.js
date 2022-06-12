const express = require('express')
const router = express.Router()

var multer = require('multer');

var storage = multer.diskStorage({
    destination: 'uploads/applicant',
    filename: function(req, file, callback) {
      callback(null, file.originalname);
    }
  });
  var upload = multer({ storage: storage })

const applicantController = require('./../controllers/ApplicantController')

router.get('/', (req, res)=>{
    res.send("Wellcome to appliant api")
})

router.post('/upload', upload.single('file'), (req, res)=>applicantController.upload(req, res))
router.post("/register", (req, res)=>applicantController.register(req, res))
module.exports = router