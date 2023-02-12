const accountSid = process.env.TWILLIO_SSID; 
const authToken = process.env.TWILLIO_TOKEN; 
const client = require('twilio')(accountSid, authToken); 
 
exports.sendSms = async(reciever, message)=>{

    console.log("sending sms:",reciever, message)
    const sent = await client.messages 
      .create({      
        body:message,   
         to: reciever,
         from:"MG831f37afd8d25361b4a251406eda0045"
       })

    return sent.sid

}