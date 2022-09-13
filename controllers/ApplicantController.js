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

    con.query("SELECT id, email, password from accounts WHERE email=?", email,(err, result)=>{
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
    const appicationData = {
        applicant_id : req.session.accountId,
        letter : req.body.letter,
        pds : req.body.pds,
        tor : req.body.tor,
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