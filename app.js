const express = require('express')
const app = express()
const bodyParser = require("body-parser");
var cookieParser = require("cookie-parser");
var session = require("express-session");
var cors = require('cors')

const conn = require('./config/DbConnection').con


const PORT = 4000

const adminRoute = require("./routes/AdminRoutes")


app.use(cors({origin:'*'}))

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use(bodyParser.json());


app.use('/admin', adminRoute)



app.get("/", (req, res)=>{
    res.send("Wellcome to API")
})
app.listen(PORT, ()=>{
    console.log("Server is listening at port: "+PORT)
})
conn.connect(function (err) {
    if (err) {
      throw err;
    }
    console.log("Database connected")
    
  });
module.exports = app