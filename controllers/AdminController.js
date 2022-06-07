const dbConnection = require('./../config/DbConnection')
const con = dbConnection.con

exports.postJob = (req, res)=>{
    const reqData = req.body.postingData
    const type = reqData.jobtype
    const title = reqData.title
    const description = reqData.description
    const poster = reqData.poster
    const numPersons = reqData.numPersons

    const sql = "INSERT INTO job_posts SET ?"

    const date = new Date().toISOString().slice(0, 19).replace('T', ' ');
    console.log("date:", date)

    const postData = {
        jobtype:type,
        title:title,
        description: description,
        poster:poster,
        date:date,
        num_persons:numPersons
    }

    con.query(sql, postData, (err, result)=>{
        if(err){
            res.sendStatus(500)
            throw err
        }
        console.log(result)
        res.sendStatus(200)

        console.log(postData)
    })
}
exports.upload = (req, res)=>{
    if(!req.file){
        res.sendStatus(500)
        throw "File not uploaded"
    }
    const filePath = req.file.path
    console.log(filePath)
    res.send(filePath)
}