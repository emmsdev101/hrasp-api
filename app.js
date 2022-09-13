const express = require("express");
const app = express();
const bodyParser = require("body-parser");
var cookieParser = require("cookie-parser");
var session = require("express-session");
var cors = require("cors");
const path = require("path");
const conn = require("./config/DbConnection").con;

const PORT = 4000;

const auth = require("./helper/auth");
const adminRoute = require("./routes/AdminRoutes");
const applicantRoute = require("./routes/ApplicantRoute");

app.use(cors({ origin: "http://localhost:3000", credentials:true}));
app.use(
  session({
    secret: "emms",
    resave: true,
    saveUninitialized: false,
  })
);
app.use(cookieParser("emmsz"))

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use(bodyParser.json());

app.use("/", auth.auth);

app.use("/uploads", express.static(path.join(__dirname, "uploads/")));

app.use("/admin", adminRoute);
app.use("/applicant", applicantRoute);


app.listen(PORT, () => {
  console.log("Server is listening at port: " + PORT);
});
conn.connect(function (err) {
  if (err) {
    throw err;
  }
  console.log("Database connected");
});
module.exports = app;
