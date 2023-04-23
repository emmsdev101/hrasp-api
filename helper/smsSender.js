const { default: axios } = require("axios")

exports.sendSms = async(reciever, message)=>{
    return true;

    try{
        axios.get(`http://localhost/sms-api?number=${reciever}&message=${message}`).then((result)=>{
      console.log("Message sent",result.data)
    })
    }catch(e){
        console.log(e)
    }

    return 0

}