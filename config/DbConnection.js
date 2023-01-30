var mysql = require('mysql');

exports.con = mysql.createConnection({
  host: "18.191.54.215",
  user: "hrasp",
  password:"1234",
  database:"hrasp"
});