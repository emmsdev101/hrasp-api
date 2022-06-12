const dbConnection = require('./../config/DbConnection')

const con = dbConnection.con
exports.register = (req, res)=>{
    const userData = req.body.userData
    const toInsert = {
        firstname: userData.firstname,
        middlename: userData.middlename,
        lastname: userData.lastname,
        gender: userData.gender,
        age:userData.age,
        birthday:userData.birthDay,
        contact: userData.contact,
    }

    con.query("INSERT INTO applicants SET ?", toInsert, (err, result)=>{
        if(err){
            res.sendStatus(500)
            throw err
        }
        console.log(result)
        if(!result.affectedRows < 1){
            res.sendStatus(500)
            throw "insert applicant error"
        }
        const accoutId = result.insertId
        const accountData = {
            id:accoutId,
            email:userData.email,
            password:userData.password
        }
        con.query("INSERT INTO applicants_account SET ?", accountData, (err1, result1)=>{
            if(err1){
                res.send(err1)
                throw err1
            }
            if(!result1.affectedRows < 1){
                res.sendStatus(500)
                throw "insert account error"
            }
            res.send({
                success:true
            })
            console.log(result1)
        })
    })
}