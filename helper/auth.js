exports.users=[]

exports.auth = (req, res, next)=>{
    if(req.path === "/applicant/login" || req.path === "/applicant/register" || req.path === "/set")return next()
    if(!req.session.accountId)return res.sendStatus(403)
    next()
    
}