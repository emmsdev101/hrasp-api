const dbConnection = require('../config/DbConnection')
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
exports.getJobPosts = (req, res)=>{
    const sql = "SELECT * FROM job_posts"

    con.query(sql,(err, result)=>{
        if(err){
            res.sendStatus(500)
            throw err
        }

        res.send(result)
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
exports.login = (req, res)=>{
    const email = req.body.username
    const password = req.body.password

    con.query("SELECT id, email, password from accounts WHERE email=? AND type = 'admin'", email,(err, result)=>{
        if(err){
            res.sendStatus(500)
            throw err
        }
        if(result.length === 0){
            res.send({
                status:"wrong-email"
            })
            console.log("Wrong email")
            return 0
        }
        const data = result[0]
        if(data.password === password){
            req.session.accountId=data.id
            req.session.type = "admin"
            req.session.save()
            res.send({status:"success"})
        }
        else res.send({status:"wrong-password"})
    })
    
}