var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('sell');
});

router.post('/', function(req, res, next) {
  pg.connect(global.databaseURI, function(err, client, done) {
    var TITLE = req.body.title;
    var DESCRIPTION = req.body.description;
    DESCRIPTION = DESCRIPTION.replace(/'/g, "''");
    var PRICE = req.body.price;
    var CATEGORY = req.body.category;
    var USERNAME = req.body.username;

    // Prepare the SQL query using string interpolation to populate username and password
    QUERY = "INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES ((SELECT uid FROM users WHERE username='%USERNAME%'), '%TITLE%', '%DESCRIPTION%', %PRICE%, %QUANTITY%, '%CATEGORY%', 'pending', 0, ARRAY['%USERNAME%']) RETURNING sid;"
    QUERY = QUERY.replace(/%USERNAME%/g, USERNAME);
    QUERY = QUERY.replace("%TITLE%", TITLE);
    QUERY = QUERY.replace("%DESCRIPTION%", DESCRIPTION);
    QUERY = QUERY.replace("%PRICE%", PRICE);
    QUERY = QUERY.replace("%QUANTITY%", 1);
    QUERY = QUERY.replace("%CATEGORY%", CATEGORY);
    console.log(QUERY);
    // Check whether the connection to the database was successful
    if(err){
      console.error('Could not connect to the database');
      console.error(err);
      return;
    }

    console.log('Connected to database');

    // Execute the query -- an empty result indicates that the username:password pair does
    // not exist in the database
    client.query(QUERY, function(error, result){

      console.log(result);
      console.log(error);
      if(error) {
        console.error('Failed to execute query');
        console.error(error);
        return;
      }
      else {
        res.redirect("/product/" + result.rows[0].sid);
      }
    })
  });


});

module.exports = router;
