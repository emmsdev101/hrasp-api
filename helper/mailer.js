const nodemailer = require('nodemailer')

let transporter = nodemailer.createTransport({
    host:"smtp.sendgrid.net",
    port:"587",
    secure:false,
    auth:{
        user:"apikey",
        pass:process.env.SEND_GRID_KEY
    }
})
exports.sendMail = async(req, res)=>{
    const info = await transporter.sendMail({
        from:'katipunan.emmanueljr@wvsu.edu.ph',
        to:"emman199810@gmail.com",
        text:"Hey! This is a test email"
    })
    const message = "Message sent: "+info.messageId
    res.send(message)
    console.log(message);
}