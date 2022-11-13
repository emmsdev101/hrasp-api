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
    console.log("REquest body",req.body)

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
exports.getApplicants = (req, res) => {
    const status = req.params.status === "all"?"":req.params.status 
    console.log(status)
    let q = "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id "
    let sql =status? q+" WHERE status = '" + status+"'": q 
    
    con.query(sql, (err, result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)
        }
        res.send(result)
    })

}
exports.acceptApplication = (req, res) => {
    let sql = "UPDATE applications SET status = ? WHERE id = ?"

    const id = req.body.id
    const status = req.body.status
    console.log("id and status", {id, status})
    $stmt = con.query(sql, [status, id],(err, result)=>{
        if(err){
            return res.sendStatus(500)
        }
        console.log(result)
        res.send(true)
    })
}
exports.getApplicationDetails = (req, res) =>{
    let sql = "SELECT * FROM applications where id = ?"
    
    const applicant = req.params.id
    console.log("id ",applicant)
    con.query(sql, applicant, (err, result)=>{
        if(err){
            return res.sendStatus(500)
        }
        console.log(result)
        res.send(result[0])
    })
}
