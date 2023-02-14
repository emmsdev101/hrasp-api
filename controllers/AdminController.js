const uuidv4 = require("uuid").v4;
const dbConnection = require("../config/DbConnection");
const { sendMail } = require("../helper/mailer");
const { sendSms } = require("../helper/smsSender");
const con = dbConnection.con;

exports.postJob = (req, res) => {
  const reqData = req.body.postingData;
  const type = reqData.jobtype;
  const title = reqData.title;
  const description = reqData.description;
  const poster = reqData.poster;
  const numPersons = reqData.numPersons;

  const sql = "INSERT INTO job_posts SET ?";

  const date = new Date().toISOString().slice(0, 19).replace("T", " ");
  console.log("date:", date);

  const postData = {
    jobtype: type,
    title: title,
    description: description,
    poster: poster,
    date: date,
    num_persons: numPersons,
  };

  con.query(sql, postData, (err, result) => {
    if (err) {
      res.sendStatus(500);
      throw err;
    }
    console.log(result);
    res.sendStatus(200);

    console.log(postData);
  });
};
exports.getJobPosts = (req, res) => {
  const sql =
    "SELECT job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id ";

  con.query(sql, (err, result) => {
    if (err) {
      res.sendStatus(500);
      throw err;
    }

    res.send(result);
  });
};

exports.upload = (req, res) => {
  if (!req.file) {
    res.sendStatus(500);
    throw "File not uploaded";
  }
  const filePath = req.file.path;
  console.log(filePath);
  res.send(filePath);
};
exports.login = (req, res) => {
  const email = req.body.username;
  const password = req.body.password;
  console.log("REquest body", req.body);

  con.query(
    "SELECT id, email, password from accounts WHERE email=? AND type = 'admin'",
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
        req.session.type = "admin";
        req.session.save(() => {
          res.send({ status: "success" });
        });
      } else res.send({ status: "wrong-password" });
    }
  );
};
exports.getApplicants = (req, res) => {
  const status = req.params.status === "all" ? "" : req.params.status;

  let sql =
    "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, panels.department, panels.departmentType FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id ";

  if (status === "to-interview" || status === "for-evaluation") {
    sql =
      "SELECT DISTINCT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, date_format(interview.date,'%Y-%m-%d') as date, interview.time,interview.room_id, interview.status, panels.department, panels.departmentType FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN interview on applications.id = interview.application_id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'to-interview' GROUP BY applicants.account_id";
  } else
    sql = status ? sql + " WHERE applications.status ='" + status + "'" : sql;

    console.log(sql)
  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};
exports.acceptApplication = (req, res) => {
  let sql = "UPDATE applications SET status = ? WHERE id = ?";

  const id = req.body.id;
  const status = req.body.status;
  console.log("id and status", { id, status });
  $stmt = con.query(sql, [status, id], (err, result) => {
    if (err) {
      return res.sendStatus(500);
    }
    res.send(true);
  });
  let sqlEmail =
    "SELECT email, applicants.contact FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN applicants ON accounts.id = applicants.account_id WHERE applications.id = ?";

  con.query(sqlEmail, [id], (err, result) => {
    if (result[0]) {
      let message = "";

      if (status === "prequalification")
        message = `Congratulations! Your application has been accepted.
            You can now proceed to pre qualifying exam (neuro examination). Take your neuro exam at West Visayas State University Main Campus Testing Center.
            `;

      if (status === "for-interview")
        message = `Congratulations! You have passed the pre qualification. Be prepared as you will get scheduled for your interview soon.`;

      sendMail("Applicaition", result[0].email, message);
      sendSms(result[0].contact, message)

    }
  });
};
exports.getApplicationDetails = (req, res) => {
  let sql =
    "SELECT applications.*, applicants.firstname, applicants.middlename, applicants.lastname, applicants.age, applicants.gender, applicants.contact, job_posts.title, panels.department, panels.departmentType FROM applications INNER JOIN applicants ON applications.applicant_id = applicants.account_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id where applications.id = ?";

  const applicant = req.params.id;
  console.log("id ", applicant);
  con.query(sql, applicant, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    console.log(result);
    res.send(result[0]);
  });
};

exports.setSchedule = (req, res) => {
  const application_id = req.body.application_id;
  const date = req.body.date;
  const time = req.body.time;
  const roomId = uuidv4();

  let sql =
    "INSERT INTO interview (application_id, date, time, room_id) VALUES(?,?,?,?)";

  con.query(sql, [application_id, date, time, roomId], (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    sql = "UPDATE applications SET status = 'to-interview' WHERE id=?";
    con.query(sql, application_id, (err1, result) => {
      if (err1) {
        console.log(err1);
        return res.sendStatus(500);
      }
      console.log(result);
      console.log(req.body);
      res.send("ok");
    });
  });
  let sqlEmail =
    "SELECT email, applicants.contact FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN applicants ON accounts.id = applicants.account_id WHERE applications.id = ?";

  con.query(sqlEmail, [application_id], (err, result) => {
    if (result[0]) {
      let message = `Your interview has been schedule on ${date}: ${time}.`;
      sendMail("Applicaition", result[0].email, message);
      sendSms(result[0].contact, message)

    }
  });
};
exports.startInterview = (req, res) => {
  const roomId = req.body.roomId;
  const sql = "UPDATE interview SET status=? WHERE room_id = ?";
  con.query(sql, ["starting", roomId], (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(500);
    }
    if (result.affectedRows >= 1) {
      return res.send({
        success: true,
      });
    }
    return res.send({
      success: true,
    });
  });
  let sqlEmail =
    "SELECT accounts.email, applicants.contact FROM interview INNER JOIN applications ON interview.application_id = applications.id INNER JOIN accounts ON applications.applicant_id = accounts.id INNER JOIN applicants ON accounts.id = applicants.account_id WHERE interview.room_id = ?";

  con.query(sqlEmail, [roomId], (err, result) => {
    if (result[0]) {
      let message =
        "Your interivew has been stated. Please log in to the portal and join the conference.";
      sendMail("Applicaition", result[0].email, message);
      sendSms(result[0].contact, message)
    }
  });
};
exports.resetSchedule = (req, res) => {
  const application_id = req.body.application_id;

  let sql = "DELETE FROM interview WHERE application_id = ?";

  con.query(sql, application_id, (err, result) => {
    if (err) {
      res.sendStatus(500);
      return nsole.log(err);
    }
    sql = "UPDATE applications SET status = 'for-interview' WHERE id=?";
    con.query(sql, application_id, (err, result) => {
      if (err) {
        console.log(err);
        return res.sendStatus(500);
      }
      res.send("ok");
    });
  });
};
exports.endInterview = (req, res) => {
  const applicationsId = req.body.applicantionsId;
  console.log(req.body);
  const sql = "UPDATE applications SET status = ? WHERE id = ?";
  con.query(sql, ["for-evaluation", applicationsId], (err, result) => {
    if (err) {
      console.log(err);
    }
    console.log(result);
    res.send({ success: true });
  });
};
exports.addPanel = (req, res) => {
  const departmentType = req.body.departmentType;
  const department = req.body.department;
  const position = req.body.position;
  const firstname = req.body.firstname;
  const middlename = req.body.middlename;
  const lastname = req.body.lastname;
  const email = req.body.email;

  let sql = "INSERT INTO accounts (email, password, type) VALUES (?,?,?)";
  con.query(sql, [email, "hrasp", "panel"], (err, result) => {
    if (err) {
      res.sendStatus(500);
    }
    const accountId = result.insertId;

    sql =
      "INSERT INTO panels (account_id, departmentType, department, position, firstname, middlename, lastname) VALUES(?,?,?,?,?,?,?)";

    con.query(
      sql,
      [
        accountId,
        departmentType,
        department,
        position,
        firstname,
        middlename,
        lastname,
      ],
      (err, result1) => {
        if (err) {
          console.log(err);
          return res.send(500);
        }
        res.send({ success: true });
      }
    );
  });
};
exports.getPanels = (req, res) => {
  let sql =
    "SELECT panels.*, accounts.email from panels INNER JOIN accounts on panels.account_id = accounts.id WHERE accounts.enabled = 1";
  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};
exports.editPanel = (req, res) => {
  console.log(req.body);
  const accountId = req.params.id;

  const email = req.body.email;
  const departmentType = req.body.departmentType;
  const department = req.body.department;
  const position = req.body.position;
  const firstname = req.body.firstname;
  const middlename = req.body.middlename;
  const lastname = req.body.lastname;

  let sql = "UPDATE accounts SET email = ? WHERE id = ?";

  con.query(sql, [email, accountId], (err, result) => {
    if (err) {
      res.sendStatus(500);
      return console.log(err);
    }
    console.log(result);
    if (result.affectedRows !== 1) return res.send({ success: false });
    let sql1 =
      "UPDATE panels SET departmentType = ?, department = ?, position = ?, firstname = ?, middlename = ?, lastname = ? WHERE account_id = ?";

    con.query(
      sql1,
      [
        departmentType,
        department,
        position,
        firstname,
        middlename,
        lastname,
        accountId,
      ],
      (err, result1) => {
        if (err) {
          res.sendStatus(500);
          return console.log(err);
        }
        console.log(result1);
        if (result1.affectedRows !== 1) return res.send({ success: false });
        res.send({ success: true });
      }
    );
  });
};
exports.deletePanel = (req, res) => {
  const id = req.body.id;
  let sql = "UPDATE accounts SET enabled = 0 WHERE id = ? ";

  con.query(sql, [id], (err, result) => {
    if (err) {
      res.sendStatus(500);
    }
    console.log(result);
    if (result.affectedRows !== 1) return res.send({ success: false });
    res.send({ success: true });
  });
};
exports.approveRequest = (req, res) => {
  const id = req.body.id;

  let sql = "UPDATE job_posts SET status = 'approved' WHERE id = ?";

  con.query(sql, [id], (err, result) => {
    if (err) {
      console.log(err);
      return res.send(500);
    }
    res.send({ success: true });
  });
};
exports.getJobPositions = (req, res) => {
  const sql =
    "SELECT sum(job_posts.num_persons) as total_persons, job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' GROUP BY job_posts.poster, job_posts.title, job_posts.id;";

  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};

exports.addCommittee = (req, res) => {
  const association = req.body.association;
  const position = req.body.position;
  const firstname = req.body.firstname;
  const middlename = req.body.middlename;
  const lastname = req.body.lastname;
  const email = req.body.email;

  let sql = "INSERT INTO accounts (email, password, type) VALUES (?,?,?)";
  con.query(sql, [email, "hrasp", "committee-" + position], (err, result) => {
    if (err) {
      res.sendStatus(500);
    }
    const accountId = result.insertId;

    sql =
      "INSERT INTO committees (account_id, committee, position, firstname, middlename, lastname) VALUES(?,?,?,?,?,?)";

    con.query(
      sql,
      [accountId, association, position, firstname, middlename, lastname],
      (err, result1) => {
        if (err) {
          console.log(err);
          return res.send(500);
        }
        res.send({ success: true });
      }
    );
  });
};
exports.getCommitees = (req, res) => {
  let sql =
    "SELECT committees.*, accounts.email from committees INNER JOIN accounts on committees.account_id = accounts.id WHERE accounts.enabled = 1";
  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};
exports.editCommittee = (req, res) => {
  console.log(req.body);
  const accountId = req.params.id;

  const association = req.body.association;
  const position = req.body.position;
  const firstname = req.body.firstname;
  const middlename = req.body.middlename;
  const lastname = req.body.lastname;
  const email = req.body.email;

  let sql = "UPDATE accounts SET email = ? WHERE id = ?";

  con.query(sql, [email, accountId], (err, result) => {
    if (err) {
      res.sendStatus(500);
      return console.log(err);
    }
    console.log(result);
    if (result.affectedRows !== 1) return res.send({ success: false });
    let sql1 =
      "UPDATE committees SET committee = ?, position = ?, firstname = ?, middlename = ?, lastname = ? WHERE account_id = ?";

    con.query(
      sql1,
      [association, position, firstname, middlename, lastname, accountId],
      (err, result1) => {
        if (err) {
          res.sendStatus(500);
          return console.log(err);
        }
        console.log(result1);
        if (result1.affectedRows !== 1) return res.send({ success: false });
        res.send({ success: true });
      }
    );
  });
};
exports.deleteCommittee = (req, res) => {
  const id = req.body.id;
  let sql = "UPDATE accounts SET enabled = 0 WHERE id = ? ";

  con.query(sql, [id], (err, result) => {
    if (err) {
      res.sendStatus(500);
    }
    console.log(result);
    if (result.affectedRows !== 1) return res.send({ success: false });
    res.send({ success: true });
  });
};
exports.createEvaluation = (req, res) => {
  const applicationId = req.body.applicationId;
  const evaluator = req.session.accountId;
  const id = uuidv4();

  const checkSql =
    "SELECT id from evaluations WHERE application_id = ? AND evaluator = ?";

  con.query(checkSql, [applicationId, evaluator], (checkErr, checkResult) => {
    if (checkErr) {
      return res.send({ success: false });
    }
    if (checkResult.length) {
      const checkId = checkResult[0].id;
      return res.send({ success: true, evaluationId: checkId });
    }
    const sql = "INSERT INTO evaluations SET ?";

    const data = {
      id: id,
      application_id: applicationId,
      evaluator: evaluator,
    };

    con.query(sql, data, (err, result) => {
      if (err) {
        console.log(err);
        res.send(false);
      }
      if (result.affectedRows)
        return res.send({ success: true, evaluationId: id });
      return res.send({ success: false });
    });
  });
};
exports.getEvaluationData = (req, res) => {
    const evaluationId = req.params.id
    const sql = "SELECT DISTINCT evaluations.*, applicants.account_id, CONCAT(applicants.firstname,' ', applicants.middlename,' ', applicants.lastname) as fullname, job_posts.title, CONCAT(committees.firstname,' ', committees.middlename,' ', committees.lastname) as interviewer, CONCAT(panels.firstname,' ', panels.middlename,' ', panels.lastname) as panel FROM applicants INNER JOIN applications ON applicants.account_id = applications.applicant_id INNER JOIN evaluations ON applications.id = evaluations.application_id INNER JOIN job_posts ON applications.job_id = job_posts.id LEFT JOIN committees ON evaluations.evaluator = committees.account_id LEFT JOIN panels ON evaluations.evaluator = panels.account_id WHERE evaluations.id = ?;"

    con.query(sql,[evaluationId],(err, result)=>{
        if(err){
            console.log(err)
            return res.send({success:false})
        }
        console.log(result)
        res.send(result)
    })
}
exports.getEvaluationResults = (req, res)=>{
  const sql = "SELECT evaluations.id, CONCAT(applicants.firstname, ' ', applicants.middlename, ' ', applicants.lastname) as applicant_name, job_posts.title, panels.department, panels.departmentType, evaluations.recommendation, evaluations.remarks, evaluations.total FROM evaluations INNER JOIN applications ON evaluations.application_id = applications.id INNER JOIN applicants ON applications.applicant_id = applicants.account_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'for-selection' GROUP BY evaluations.application_id;"
  con.query(sql,(err, result)=>{
    if(err){
      console.log(err)
    }
    res.send(result)
  })
}

exports.getAccounts = (req, res) => {
  const sql = "SELECT applicants.account_id, applicants.firstname, applicants.middlename, applicants.lastname, applicants.gender, applicants.age, date_format(applicants.birthday,'%Y-%m-%d') as birthday,applicants.contact, accounts.email, accounts.status FROM `accounts` INNER JOIN applicants ON accounts.id = applicants.account_id WHERE accounts.type = 'applicant'"

  con.query(sql,null,(err, result)=>{
    if(err){
      console.log(err)
      res.sendStatus(500)
    }
    res.send(result)
  })
}
exports.getAccounts = (req, res) => {
  const sql = "SELECT applicants.account_id, applicants.firstname, applicants.middlename, applicants.lastname, applicants.gender, applicants.age, date_format(applicants.birthday,'%Y-%m-%d') as birthday,applicants.contact, accounts.email, accounts.status FROM `accounts` INNER JOIN applicants ON accounts.id = applicants.account_id WHERE accounts.type = 'applicant' and accounts.status != 'declined'"

  con.query(sql,null,(err, result)=>{
    if(err){
      console.log(err)
      res.sendStatus(500)
    }
    res.send(result)
  })
}
exports.acceptAccount = (req, res) => {
  const accountId = req.body.accountId
  const sql = "UPDATE accounts SET status = 'active' WHERE id = ?"

  con.query(sql,accountId,(err, result)=>{
    if(err){
      console.log(err)
      res.sendStatus(500)
    }
    console.log(result)
    if(result.affectedRows < 0)return res.send({success:false})
    res.send({success:true})
  })
}
exports.decline = (req, res) => {
  const accountId = req.body.accountId
  const sql = "UPDATE accounts SET status = 'declined' WHERE id = ?"

  con.query(sql,accountId,(err, result)=>{
    if(err){
      console.log(err)
      res.sendStatus(500)
    }
    console.log(result)
    if(result.affectedRows < 0)return res.send({success:false})
    res.send({success:true})
  })
}
exports.deactivate = (req, res) => {
  const accountId = req.body.accountId
  const sql = "UPDATE accounts SET status = 'deactivated' WHERE id = ?"

  con.query(sql,accountId,(err, result)=>{
    if(err){
      console.log(err)
      res.sendStatus(500)
    }
    console.log(result)
    if(result.affectedRows < 0)return res.send({success:false})
    res.send({success:true})
  })
}