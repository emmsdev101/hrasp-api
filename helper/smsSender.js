const { default: axios } = require("axios")

exports.sendSms = async(reciever, message)=>{

    axios.get(`http://localhost/sms-api?number=${reciever}&message=${message}`).then((result)=>{
      console.log("Message sent",result.data)
    })

    return 0

}