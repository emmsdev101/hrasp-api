var mysql = require('mysql');

exports.con = mysql.createConnection({
  host: "localhost",
  user: "root",
  database:"hrasp"
});