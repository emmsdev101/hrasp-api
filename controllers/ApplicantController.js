const dbConnection = require('./../config/DbConnection')

const con = dbConnection.con
exports.register = (req, res)=>{
    const userData = req.body.userData

    const accountData = {
        email:userData.email,
        password:userData.password,
        type:"applicant"
    }
    con.query("INSERT INTO accounts SET ?", accountData, (err, accountResult)=>{
        if(err){
            res.send(err)
            throw err
        }
        if(accountResult.affectedRows < 1){
            res.send({
                status:"insert-failed"
            })
            console.log("Account not inserted")
            return 0
        }
        console.log("Account:",accountResult)

        const accoutId = accountResult.insertId

        const toInsert = {
            account_id:accoutId,
            firstname: userData.firstname,
            middlename: userData.middlename,
            lastname: userData.lastname,
            gender: userData.gender,
            age:userData.age,
            birthday:userData.birthDay,
            contact: userData.contact
        }

        con.query("INSERT INTO applicants SET ?", toInsert, (err1, applicantResult)=>{
            if(err1){
                res.sendStatus(500)
                throw err1
            }
            console.log("Applicant Result:",applicantResult)
            if(applicantResult.affectedRows < 0){
                res.send({
                    status:"insert-failed"
                })
                console.log("Applicant not inserted")
                return 0
            }
            res.send({
                status:"success"
            })
    
        })
    })


}
exports.login = (req, res)=>{
    const email = req.body.email
    const password = req.body.password

    con.query("SELECT id, email, password from accounts WHERE email=? AND type = 'applicant'", email,(err, result)=>{
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
            req.session.type = "applicant"
            req.session.save()
            res.send({status:"success"})
        }
        else res.send({status:"wrong-password"})
    })
    
}
exports.apply = (req, res)=>{

    const certPaths = {
        certificates:req.body.certs
    }
    const psdPaths = {
        pds:req.body.pds
    }
    const torPaths = {
        tors:req.body.tor
    }
    const letterPaths = {
        letter:req.body.letter
    }

    const appicationData = {
        applicant_id : req.session.accountId,
        letter : JSON.stringify(letterPaths),
        pds : JSON.stringify(psdPaths),
        tor : JSON.stringify(torPaths),
        certificates : JSON.stringify(certPaths),
        job_id : req.body.jobId
    }

    console.log(appicationData)
    con.query("INSERT INTO applications SET ?",appicationData, (err, result)=>{
        if(err){
            res.sendStatus(500)
            throw err
        }
        console.log(result)
        res.sendStatus(200)

        console.log(appicationData)
    })
}
exports.getApplication = (req, res)=>{
    const applicant_id = req.session.accountId

    console.log(applicant_id)
    let sql = "SELECT applications.status, job_posts.title, job_posts.jobtype from applications INNER JOIN job_posts ON applications.job_id = job_posts.id WHERE applicant_id = ?"
    con.query(sql, applicant_id, (err, result)=>{
        if(err)return res.sendStatus(500)
        if(result.length===0)return res.send("")
        console.log("Application",result)
        res.send(result)

        

        
    })

}
exports.getSchedule = (req, res) => {
    const applicant_id = req.session.accountId
    let sql = "SELECT date_format(date,'%m-%d-%Y')as date, time FROM interview INNER JOIN applications ON interview.application_id = applications.id WHERE applications.applicant_id=?"
    con.query(sql, applicant_id, (err, result)=>{
        if(err){
            console.log(err)
            res.sendStatus(500)
        }
        res.send(result[0])
    })
}