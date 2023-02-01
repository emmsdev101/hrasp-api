const nodemailer = require('nodemailer')

let transporter = nodemailer.createTransport({
    host:"smtp-relay.sendinblue.com",
    port:"587",
    secure:false,
    auth:{
        user:"emmsdevs@gmail.com",
        pass:"X3GfCRpgLF82mbNw"
    }
})
exports.sendMail = async(subject, recipient, message)=>{
    try{
        const info = await transporter.sendMail({
            from:'WVSUCC HRMO <emmsdevs@gmail.com>',
            to:recipient,
            subject:subject,
            text:message
        })
        const sent = "Message sent: "+info.messageId
        console.log(sent);
        return sent
    }catch(err){
        console.log(err)
        return false
    }
}