var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('register');
});

router.post("/", function(req, res, next){

  pg.connect(global.databaseURI, function(err, client, done) {

    // Prepare the SQL query using string interpolation to populate username and password
    var QUERYSTRING = "INSERT INTO Users (username, realname, password) VALUES ('%USERNAME%', '%REALNAME%', '%PASSWORD%');";
    QUERYSTRING = QUERYSTRING.replace("%USERNAME%", req.body.username);
    QUERYSTRING = QUERYSTRING.replace("%REALNAME%", req.body.name);
    QUERYSTRING = QUERYSTRING.replace("%PASSWORD%", req.body.password);

    console.log(QUERYSTRING);

    // Check whether the connection to the database was successful
    if (err) {
      console.error('Could not connect to the database');
      console.error(err);
      return;
    }

    console.log('Connected to database');

    // Execute the query
    client.query(QUERYSTRING, function (error, result) {

      console.log(result);
      console.log(error);
      if (error) {
        console.error('Failed to execute query');
        console.error(error);
        return;
      }
    });
    res.render("index", {categories : ""});
  });
});

module.exports = router;
