require("dotenv").config();
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
var cookieParser = require("cookie-parser");
var session = require("express-session");
var cors = require("cors");
const path = require("path");
const fs = require("fs");
const https = require("https");

const conn = require("./config/DbConnection").con;

const PORT = 4000;

const { auth, authAdmin, authApplicant, authPanel } = require("./helper/auth");
const adminRoute = require("./routes/AdminRoutes");
const applicantRoute = require("./routes/ApplicantRoute");
const panelRoute = require("./routes/PanelRoutes");
const noAuthRoute = require("./routes/NoAuthRoutes");
const oneDay = 1000 * 60 * 60 * 24;

const signups = {};

app.use(
  cors({
    origin: [
      "http://localhost:3000",
      "http://192.168.254.137:3000",
      "http://18.191.54.215:3000",
      "http://192.168.254.179:3000",
      "http://192.168.254.103:3000",
      "http://192.168.254.173:3000",
      "http://192.168.254.101:3000",
      "http://192.168.254.106:3000",
      "http://192.168.254.146:3000",
      "http://192.168.254.102:3000",
      "http://192.168.254.146",
      "http://192.168.126.77:3000"
      
    ],
    credentials: true,
  })
);
app.use(
  session({
    secret: "emms",
    resave: false,
    cookie: { maxAge: oneDay },
    saveUninitialized: false,
  })
);
app.use(cookieParser("emmsz"));

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.set("signups", signups);

app.use(bodyParser.json());

app.use("/admin", authAdmin);
app.use("/applicant", authApplicant);
app.use("/panel", authPanel);

app.use("/uploads", express.static(path.join(__dirname, "uploads/")));

app.use("/admin", adminRoute);
app.use("/applicant", applicantRoute);
app.use("/panel", panelRoute);

app.use("/logout", noAuthRoute);
app.use("/", noAuthRoute);

app.listen(PORT, () => {
  console.log("Server is listening at port: " + PORT);
});
if (process.env.NO_DATABASE === false) {
  conn.connect(function (err) {
    if (err) {
      console.log("error")
    }
    console.log("Database connected");
  });
}
module.exports = app;
