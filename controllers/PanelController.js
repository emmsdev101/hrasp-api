const dbConnection = require("../config/DbConnection");
const con = dbConnection.con;

exports.getProfileDetails = (req, res) => {
  const accountId = req.session.accountId;
  let sql =
    "SELECT panels.*, accounts.email FROM panels INNER JOIN accounts ON panels.account_id = accounts.id WHERE accounts.id = ?";

  con.query(sql, [accountId], (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(500);
    }
    res.send(result[0]);
  });
};
exports.login = (req, res) => {
  const email = req.body.username;
  const password = req.body.password;
  console.log("REquest body", req.body);

  con.query(
    "SELECT id, email, password from accounts WHERE email=? AND type = 'panel'",
    email,
    (err, result) => {
      if (err) {
        res.sendStatus(500);
        throw err;
      }
      if (result.length === 0) {
        res.send({
          status: "wrong-email",
        });
        console.log("Wrong email");
        return 0;
      }
      const data = result[0];
      if (data.password === password) {
        req.session.accountId = data.id;
        req.session.type = "panel";
        req.session.save(() => {
          res.send({ status: "success" });
        });
      } else res.send({ status: "wrong-password" });
    }
  );
};
exports.getHiring = (req, res) => {
  const userType = req.session.type;
  const sql = "SELECT * FROM job_posts";

  con.query(sql, (err, result) => {
    if (err) {
      res.sendStatus(500);
      throw err;
    }

    res.send(result);
  });
};
exports.requestHiring = (req, res) => {
  const reqData = req.body.postingData;
  const userId = req.session.accountId;

  let insertSql = "INSERT INTO job_posts SET ?";

  const date = new Date().toISOString().slice(0, 19).replace("T", " ");

  const postData = {
    title: reqData.position,
    description: reqData.description,
    poster: userId,
    date: date,
    num_persons: reqData.numPersons,
    qualifications: JSON.stringify({ qualifications: reqData.qualifications }),
  };
  con.query(insertSql, postData, (err, postResult) => {
    if (err) {
      console.log(err);
      return res.sendStatus(err);
    }
    console.log("Post Result:", postResult);
    if (!postResult.insertId) return res.send({ success: false });
    res.send({ success: true });
  });
};
exports.editHiring = (req, res) => {
  const id = req.params.id;

  console.log("Hiring", id);
  const reqData = req.body.postingData;
  const title = reqData.position;
  const description = reqData.description;
  const num_persons = reqData.numPersons;
  const qualifications = JSON.stringify({
    qualifications: reqData.qualifications,
  });

  let updateSql =
    "UPDATE job_posts SET title = ?, description = ?, num_persons = ?, qualifications = ? WHERE id = ?";

  con.query(
    updateSql,
    [title, description, num_persons, qualifications, id],
    (err, postResult) => {
      if (err) {
        console.log(err);
        return res.sendStatus(err);
      }
      console.log("Post Result:", postResult);
      if (!postResult.affectedRows) return res.send({ success: false });
      res.send({ success: true });
    }
  );
};
exports.getJobPosts = (req, res) => {
  const userId = req.session.accountId;
  const sql =
    "SELECT job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE poster = ?";

  con.query(sql, [userId], (err, result) => {
    if (err) {
      res.sendStatus(500);
      throw err;
    }

    res.send(result);
  });
};
exports.getJobData = (req, res) => {
  const jobId = req.params.id;

  const sql =
    "SELECT job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.id = ?";

  con.query(sql, [jobId], (err, result) => {
    if (err) {
      res.sendStatus(500);
      throw err;
    }

    res.send(result[0]);
  });
};
exports.cancelRequest = (req, res) => {
  const id = req.body.id;

  con.query("DELETE FROM job_posts WHERE id = ?", [id], (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send({ success: true });
  });
};
exports.getApplicants = (req, res) => {
  const status = req.params.status === "all" ? "" : req.params.status;

  const accountId = req.session.accountId
  let sql =
    "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.poster = "+accountId;

  if (status === "to-interview") {
    sql =
      "SELECT DISTINCT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, date_format(interview.date,'%m-%d-%Y') as date, interview.time FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN interview on applications.id = interview.application_id WHERE applications.status = 'to-interview' AND job_posts.poster = "+accountId+" GROUP BY applicants.account_id";
  } else sql = status ? sql + " AND applications.status ='" + status + "'": sql;
  con.query(sql,(err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};

exports.getJobPositions = (req, res) => {
    const userId = req.session.accountId;

    const sql = "SELECT sum(job_posts.num_persons) as total_persons, job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' AND poster = ? GROUP BY job_posts.poster, job_posts.title;";

    con.query(sql,[userId],(err, result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)
        }
        res.send(result)
    })
}
