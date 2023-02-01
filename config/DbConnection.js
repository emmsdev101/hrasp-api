var mysql = require('mysql2');

exports.con = mysql.createConnection({
  host: "localhost",
  user: "root",
  database:"hrasp"
});