var mysql = require('mysql2');

exports.con = mysql.createConnection({
  host: "localhost",
  port:'3306',
  user: "root",
  database:"hrasp"
});