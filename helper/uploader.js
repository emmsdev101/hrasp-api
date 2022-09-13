var multer = require('multer');


  exports.upload = (path)=>{
    var storage = multer.diskStorage({
        destination: path,
        filename: function(req, file, callback) {
          callback(null, file.originalname);
        }
    });
    return multer({ storage: storage })
  }
  exports.getPathSingle =(req, res)=>{
    if(!req.file){
        res.sendStatus(500)
        throw "File not uploaded"
    }
    const filePath = req.file.path
    console.log(filePath)
    res.send(filePath)
}
exports.getPathArray=(req, res)=>{
    const files = req.files
    const paths = []
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        paths.push(file.path)
    }
    res.send(paths) 
}