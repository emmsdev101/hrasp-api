const dbConnection = require("../config/DbConnection");
const con = dbConnection.con;

exports.getProfileDetails = (req, res) => {
  const accountId = req.session.accountId;
  let sql =
    "SELECT panels.*, accounts.email FROM panels INNER JOIN accounts ON panels.account_id = accounts.id WHERE accounts.id = ?";

  con.query(sql, [accountId], (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result[0]);
  });
};
exports.changePassword = (req, res)=> {
  const applicantId = req.session.accountId
  const currentPassword=req.body.currentPassword
  const newPassword=req.body.newPassword
  const sql = "UPDATE accounts SET password = ? WHERE id = ? AND password = ?"

  con.query(sql,[newPassword,applicantId, currentPassword],(err, result)=>{
      if(err){
          console.log(err)
         return res.send({success:false, error:"Something went wrong"})
      }
      if(!result.affectedRows){
          return res.send({success:false, error:"Current password is incorrect"})
      }
      res.send({success:true})
  })
}
exports.getCommitteeProfileDetails = (req, res) => {
  const accountId = req.session.accountId;
  let sql =
    "SELECT committees.*, accounts.email FROM committees INNER JOIN accounts ON committees.account_id = accounts.id WHERE accounts.id = ?";

  con.query(sql, [accountId], (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result[0]);
  });
};
exports.editProfile = (req, res) => {
  const applicantId = req.session.accountId

    const data = [
       req.body.firstname,
       req.body.middlename,
       req.body.lastname,
       req.body.gender,
       applicantId
    ]
    const sql ="UPDATE applicants SET firstname = ?, middlename = ?, lastname = ?, gender = ?, birthday = ?, contact = ?  WHERE account_id = ?"

    con.query(sql,data,(err,result)=>{
        if(err){
            console.log(err)
            return res.sendStatus(500)
        }
        console.log(result)
        if(result.affectedRows){
            return res.send({success:true})
        }
        else return res.send({success:false})
    })
}
exports.editCommitteeProfile = (req, res)=>{
  
}


exports.getPanelDetails = (req,res) => {
  const id = req.params.id

  const sql = `SELECT CONCAT(firstname, ' ', middlename, ' ', lastname) as fullname, departmentType, department, position FROM panels WHERE account_id = ?`

  con.query(sql, id, (err, result)=>{
    if(err){
      console.log(err)
      return req.sendStatus(500)
    }
    if(!result.length)return res.send(false)

    res.send(result[0])
  })
}
exports.getCommitteeDetails = (req,res) => {
  const id = req.params.id

  const sql = `SELECT CONCAT(firstname, ' ', middlename, ' ', lastname) as fullname, committee,position,account_id FROM committees WHERE account_id = ?`

  con.query(sql, id, (err, result)=>{
    if(err){
      console.log(err)
      return req.sendStatus(500)
    }
    if(!result.length)return res.send(false)

    res.send(result[0])
  })
}
exports.login = (req, res) => {
  const email = req.body.username;
  const password = req.body.password;
  console.log("REquest body", req.body);

  con.query(
    "SELECT id, email, password, type from accounts WHERE email=?",
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
          res.send({ status: "success", userType: data.type });
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

  const accountId = req.session.accountId;
  let sql =
    "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, panels.department, panels.departmentType FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.poster = " +
    accountId;

  if (status === "to-interview") {
    sql =
      "SELECT DISTINCT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, date_format(interview.date,'%m-%d-%Y') as date, interview.time, interview.room_id, interview.status FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN interview on applications.id = interview.application_id WHERE applications.status = 'to-interview' AND job_posts.poster = " +
      accountId +
      " GROUP BY applicants.account_id";
  } else if (status === "for-evaluation") {
    sql = `SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, 
    job_posts.title, applications.status, applications.id as application_id, panels.department, 
    panels.departmentType,date_format(interview.date,'%m-%d-%Y') as date, interview.time 
    FROM applicants INNER JOIN applications on applicants.account_id = applications.applicant_id 
    INNER JOIN job_posts on applications.job_id = job_posts.id 
    INNER JOIN panels ON job_posts.poster = panels.account_id 
    INNER JOIN interview on applications.id = interview.application_id 
    WHERE job_posts.poster = '${accountId}' AND applications.id NOT IN 
    (SELECT evaluations.application_id FROM evaluations WHERE evaluations.evaluator = ${accountId});`;
  } else
    sql = status ? sql + " AND applications.status ='" + status + "'" : sql;
  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};

exports.getJobPositionsForDepartment = (req, res) => {
  const userId = req.session.accountId;

  const sql =
    "SELECT sum(job_posts.num_persons) as total_persons, job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' AND poster = ? GROUP BY job_posts.poster, job_posts.title;";

  con.query(sql, [userId], (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};
exports.getJobPositions = (req, res)=>{
  const type = req.params.type
  const department = req.params.department
  const sql = `SELECT job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' AND panels.departmentType = ? and panels.department = ? GROUP BY job_posts.id`

  con.query(sql, [type, department],(err, result)=>{
    if(err){
      console.log(err)
      return res.sendStatus(500)
    }
    res.send(result)
  })
}

exports.getJobPositionsForCommittee = (req, res) => {
  const sql =
    "SELECT sum(job_posts.num_persons) as total_persons, job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' GROUP BY job_posts.poster, job_posts.title;";

  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
    console.log("Commitee" + result);
  });
};

exports.getJobPositionsForCommitteeHead = (req, res) => {
  const userId = req.session.accountId;

  let userSql = "SELECT * from committees WHERE account_id = ?";
  con.query(userSql, [userId], (err, userResult) => {
    if (err) {
      console.log(err);
      res.sendStatus(500);
    }
    if (!userSql[0]) req.send({ success: false });

    const committee = userResult[0].committee;

    let jobsSql =
      "SELECT sum(job_posts.num_persons) as total_persons, job_posts.*, panels.departmentType, panels.department FROM job_posts INNER JOIN panels ON job_posts.poster = panels.account_id WHERE job_posts.status = 'approved' AND panels.departmentType = ? GROUP BY job_posts.poster, job_posts.title;";

    con.query(jobsSql, [committee], (err1, jobsResult) => {
      if (err1) {
        console.log(err1);
        return res.sendStatus(500);
      }
      res.send(jobsResult);
    });
  });
};
exports.getApplicantsForCommitteeHeads = (req, res) => {
  const status = req.params.status === "all" ? "" : req.params.status;

  console.log("Request Status", status);

  const userId = req.session.accountId;

  let userSql = "SELECT * from committees WHERE account_id = ?";

  con.query(userSql, [userId], (err, userResult) => {
    if (err) {
      console.log(err);
      res.sendStatus(500);
    }
    if (!userSql[0]) req.send({ success: false });

    const committee = userResult[0].committee;

    let sql =
      "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, panels.department, panels.departmentType,date_format(interview.date,'%Y-%m-%d') as date, interview.time FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id INNER JOIN interview ON applications.id = interview.application_id ";

    if (status === "to-interview") {
      sql =
        "SELECT DISTINCT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, date_format(interview.date,'%Y-%m-%d') as date, interview.time,interview.room_id, interview.status, panels.department, panels.departmentType FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN interview on applications.id = interview.application_id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'to-interview'  && panels.departmentType = ? GROUP BY applicants.account_id";
    } else if (status === "for-evaluation") {
      sql = `SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, 
      job_posts.title, applications.status, applications.id as application_id, panels.department, 
      panels.departmentType,date_format(interview.date,'%m-%d-%Y') as date, interview.time
      FROM applicants
      INNER JOIN applications on applicants.account_id = applications.applicant_id 
      INNER JOIN job_posts on applications.job_id = job_posts.id 
      INNER JOIN panels ON job_posts.poster = panels.account_id 
      INNER JOIN interview on applications.id = interview.application_id
      WHERE panels.departmentType = ? AND applications.id NOT IN (SELECT evaluations.application_id FROM evaluations WHERE evaluations.evaluator = ${userId} AND evaluations.total != 'NULL')`;
    } else
      sql = status
        ? sql +
          " WHERE applications.status ='" +
          status +
          "' && panels.departmentType = ?"
        : sql + "WHERE panels.departmentType = ?";
    con.query(sql, [committee], (err, result) => {
      if (err) {
        console.log(err);
        return res.sendStatus(500);
      }
      res.send(result);
    });
  });
};
exports.getApplicantsForCommitteeMember = (req, res) => {
  const status = req.params.status === "all" ? "" : req.params.status;
  const accountId = req.session.accountId;
  console.log("Request Status", status);

  let sql =
    "SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, panels.department, panels.departmentType,date_format(interview.date,'%Y-%m-%d') as date, interview.time FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id INNER JOIN interview ON applications.id = interview.application_id ";

  if (status === "to-interview") {
    sql =
      "SELECT DISTINCT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, date_format(interview.date,'%Y-%m-%d') as date, interview.time,interview.room_id, interview.status, panels.department, panels.departmentType FROM `applicants` INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN interview on applications.id = interview.application_id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'to-interview'  && panels.departmentType = ? GROUP BY applicants.account_id";
  } else if (status === "for-evaluation") {
    sql = `SELECT applicants.firstname, applicants.middlename, applicants.lastname, applicants.account_id, job_posts.title, applications.status, applications.id as application_id, panels.department, panels.departmentType,date_format(interview.date,'%m-%d-%Y') as date, interview.time FROM applicants INNER JOIN applications on applicants.account_id = applications.applicant_id INNER JOIN job_posts on applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id INNER JOIN interview on applications.id = interview.application_id WHERE applications.id NOT IN (SELECT evaluations.application_id FROM evaluations WHERE evaluations.evaluator = ${accountId} AND evaluations.total != 'NULL');`;
  } else sql = status ? sql + " WHERE applications.status ='" + status : sql;
  con.query(sql, (err, result) => {
    if (err) {
      console.log(err);
      return res.sendStatus(500);
    }
    res.send(result);
  });
};
exports.evaluate = (req, res) => {
  const applicationId = req.body.applicationId;
  const id = req.body.id;
  const training = req.body.training;
  const remarks = req.body.remarks;
  const considireation = req.body.considiration;
  const total = req.body.total;
  const ratings = req.body.ratings;

  const sql =
    "UPDATE evaluations SET ratings=?, recommendation=?,remarks=?, training=?, total=? where id = ?";
  const data = [
    JSON.stringify(ratings),
    considireation,
    remarks,
    training,
    total,
    id,
  ];
  con.query(sql, data, (err, result) => {
    if (err) {
      console.log(err);
      res.send({ success: false });
    }
    console.log(result);
    res.send({ succes: true });
  });
};

exports.getEvaluationResults = (req, res) => {
  const id = req.session.accountId;
  const sql =
    "SELECT evaluations.id, CONCAT(applicants.firstname, ' ', applicants.middlename, ' ', applicants.lastname) as applicant_name, job_posts.title, panels.department, panels.departmentType, evaluations.recommendation, evaluations.remarks, evaluations.total FROM evaluations INNER JOIN applications ON evaluations.application_id = applications.id INNER JOIN applicants ON applications.applicant_id = applicants.account_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'for-evaluation' AND job_posts.poster = ? AND evaluations.total != 'NULL' GROUP BY evaluations.application_id ORDER BY total DESC;";
  con.query(sql, id, (err, result) => {
    if (err) {
      console.log(err);
    }
    res.send(result);
  });
};
exports.getEvaluationResultsForCommitteemember =(req, res)=>{
  const id = req.session.accountId
  const sql = `
  SELECT evaluations.id, CONCAT(applicants.firstname, ' ', applicants.middlename, ' ', applicants.lastname) as applicant_name, job_posts.title, panels.department, panels.departmentType, evaluations.recommendation, evaluations.remarks, evaluations.total FROM evaluations INNER JOIN applications ON evaluations.application_id = applications.id INNER JOIN applicants ON applications.applicant_id = applicants.account_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'for-evaluation' AND evaluations.total != 'NULL' AND evaluations.evaluator = ${id}  GROUP BY evaluations.application_id ORDER BY total DESC;`
    con.query(sql, id, (err, result) => {
      if (err) {
        console.log(err);
      }
      res.send(result);
    });
}
exports.getEvaluationResultsForCommitteeHead = (req, res) => {
  const id = req.session.accountId;

  const sql1 = "SELECT committee from committees WHERE account_id = ?";

  con.query(sql1, id, (err, result) => {
    if (err) {
      console.log(err);
    }
    const panelData = result[0];
    console.log(result);

    if (panelData) {
      const departmentType = panelData.committee;
      const sql2 = `SELECT evaluations.id, CONCAT(applicants.firstname, ' ', applicants.middlename, ' ', applicants.lastname) as applicant_name, job_posts.title, panels.department, panels.departmentType, evaluations.recommendation, evaluations.remarks, evaluations.total FROM evaluations INNER JOIN applications ON evaluations.application_id = applications.id INNER JOIN applicants ON applications.applicant_id = applicants.account_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id WHERE applications.status = 'for-evaluation' AND panels.departmentType = ? AND evaluations.evaluator = ${id} GROUP BY evaluations.application_id ORDER BY total DESC;`
      con.query(sql2, departmentType, (err, result) => {
        if (err) {
          console.log(err);
        }

        res.send(result);
      });
    }
  });
};
exports.getApplicantsVolume = (req, res) => {
  const accountId = req.session.accountId 
  const sql = `SELECT COUNT(*) as num_applicants FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN job_posts ON applications.job_id = job_posts.id  WHERE job_posts.poster = ?`
  con.query(sql,accountId,(err,result)=>{
    if(err){
      console.log(err)
      return res.sendStatus(500)
    }
    if(!result[0])return res.send({success:false})
    res.send(result[0])
  })
}
exports.getPendingVolume = (req, res) => {
  const accountId = req.session.accountId 
  const sql = `SELECT COUNT(*) as pending FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN job_posts ON applications.job_id = job_posts.id  WHERE applications.status = "pending" and job_posts.poster = ?`
  con.query(sql,accountId,(err,result)=>{
    if(err){
      console.log(err)
      return res.sendStatus(500)
    }
    if(!result[0])return res.send({success:false})
    res.send(result[0])
  })
}

exports.getCommitteeHeadApplicantsVolume = (req, res) => {
  const accountId = req.session.accountId 
  
  const sql2 = "SELECT * FROM committees WHERE account_id = ?"

  con.query(sql2,accountId,(err, result)=>{
    if(err){
      console.log(err)
      return res.sendStatus(500)
    }
    const data = result[0]

    const sql3 = `SELECT COUNT(*) as num_applicants FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id  WHERE panels.departmentType = ?`
    con.query(sql3,data.committee,(err,result)=>{
      if(err){
        console.log(err)
        return res.sendStatus(500)
      }
      if(!result[0])return res.send({success:false})
      res.send(result[0])
    })

  })

}
exports.getCommitteeHeadPendingVolume = (req, res) => {
  const accountId = req.session.accountId 
  
  const sql2 = "SELECT * FROM committees WHERE account_id = ?"

  con.query(sql2,accountId,(err, result)=>{
    if(err){
      console.log(err)
      return res.sendStatus(500)
    }
    const data = result[0]

    const sql3 = `SELECT COUNT(*) as pending FROM accounts INNER JOIN applications ON accounts.id = applications.applicant_id INNER JOIN job_posts ON applications.job_id = job_posts.id INNER JOIN panels ON job_posts.poster = panels.account_id  WHERE panels.departmentType = ? AND applications.status ='pending'`
    con.query(sql3,data.committee,(err,result)=>{
      if(err){
        console.log(err)
        return res.sendStatus(500)
      }
      if(!result[0])return res.send({success:false})
      res.send(result[0])
    })

  })
}