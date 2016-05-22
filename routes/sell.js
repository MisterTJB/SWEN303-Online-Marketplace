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


    // Execute the query
    client.query(QUERY, function(error, result){

      console.log(result);
      console.log(error);
      if(error) {
        console.error('Failed to execute query');
        console.error(error);
        return;
      }
      else {

        // Get the max number of products allowed in the new queue
        client.query("SELECT value FROM site_parameters WHERE parameter='PRODUCTS_IN_QUEUE'", function(err, result){
          var max_queue = result.rows[0].value;
          console.log("Max queue: " + max_queue);

          client.query("SELECT count(*), min(sid) FROM stock WHERE status='pending'", function(err, result){
            console.log(result.rows[0]);
            var queue_length = result.rows[0]['count'];
            var oldest_product = result.rows[0]['min'];

            // If the new queue is too long, remove products from the queue
            console.log("Queue length: " + queue_length);
            console.log("Oldest product: " + oldest_product);
            if (queue_length > max_queue){
              client.query("UPDATE stock SET status='unsuccessful' WHERE sid='%SID%'".replace("%SID%", oldest_product), function(err, result){
                console.log("Removed " + oldest_product);
              });
            }

          });


        });

        res.redirect("/product/" + result.rows[0].sid);
      }
    })
  });


});

module.exports = router;
