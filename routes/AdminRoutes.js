const express = require('express')
const router = express.Router()

var multer = require('multer');

var storage = multer.diskStorage({
    destination: 'uploads/admin/images/jobPosts',
    filename: function(req, file, callback) {
      callback(null, file.originalname);
    }
  });
  var upload = multer({ storage: storage })

const adminControlloer = require('./../controllers/AdminController')

router.get('/', (req, res)=>{
    res.send("Wellcome to admin api")
})
router.post('/postJob', (req, res)=>{
    adminControlloer.postJob(req, res);
    
})
router.post('/upload', upload.single('file'), (req, res)=>{
    adminControlloer.upload(req, res)
} )
module.exports = router