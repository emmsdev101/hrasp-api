const dbConnection = require('./../config/DbConnection')

const con = dbConnection.con


exports.getProfileDetails = (req, res)=>{
    const accountId = req.session.accountId

    const sql = "SELECT accounts.email, applicants.firstname, applicants.middlename, applicants.lastname, applicants.gender, date_format(applicants.birthday,'%Y-%m-%d') as birthday, applicants.contact from applicants INNER JOIN accounts ON applicants.account_id = accounts.id WHERE accounts.id = ?"
    con.query(sql, accountId,(err, result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)
        }
        console.log(result[0])
        if(!result[0])return res.send({})
        return res.send(result[0])
    })
}
exports.changePassword = (req, res)=> {
    const applicantId = req.session.accountId
    const currentPassword=req.body.currentPassword
    const newPassword=req.body.newPassword
    const sql = "UPDATE accounts SET password = ? WHERE id = ? AND password = ? AND type = 'applicant'"

    con.query(sql,[newPassword,applicantId, currentPassword],(err, result)=>{
        if(err){
            console.log(err)
           return res.send({success:false, error:"Something went wrong"})
        }
        if(!result.affectedRows){
            return res.send({success:false, error:"Current password is incorrect"})
        }
        res.send({success:true})
    })
}
exports.editProfile = (req, res)=> {
    const applicantId = req.session.accountId

    const data = [
       req.body.firstname,
       req.body.middlename,
       req.body.lastname,
       req.body.gender,
       req.body.birthday,
       req.body.contact,
       applicantId
    ]
    const sql ="UPDATE applicants SET firstname = ?, middlename = ?, lastname = ?, gender = ?, birthday = ?, contact = ?  WHERE account_id = ?"

    con.query(sql,data,(err,result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)
        }
        console.log(result)
        if(result.affectedRows){
            return res.send({success:true})
        }
        else return res.send({success:false})
    })
}

exports.register = (req, res)=>{
    const userData = req.body.userData

    const accountData = {
        email:userData.email,
        password:userData.password,
        type:"applicant"
    }
    con.connect(function (err) {
        if (err) {
          console.log("error")
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
      });
   


}
exports.login = (req, res)=>{
    const email = req.body.email
    const password = req.body.password

    con.query("SELECT id, email, password, status from accounts WHERE email=? AND type = 'applicant'", email,(err, result)=>{
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
            if(data.status === "pending"){
                res.send({status:"pending"})
            }else req.session.save(()=>{
                res.send({status:"success"})
            })
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
    let sql = "SELECT applications.status, job_posts.title, panels.departmentType from applications INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applicant_id = ?"
    con.query(sql, applicant_id, (err, result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)}
        if(result.length===0)return res.send("")
        console.log("Application",result)
        res.send(result)

        

        
    })

}
exports.getSchedule = (req, res) => {
    const applicant_id = req.session.accountId
    let sql = "SELECT date_format(interview.date,'%m-%d-%Y')as date, interview.time, interview.room_id, interview.status FROM interview INNER JOIN applications ON interview.application_id = applications.id WHERE applications.applicant_id=?"
    con.query(sql, applicant_id, (err, result)=>{
        if(err){
            console.log(err)
            res.sendStatus(500)
        }
        res.send(result[0])
    })
}

exports.sendConfirmation = (req, res)=>{
    
}