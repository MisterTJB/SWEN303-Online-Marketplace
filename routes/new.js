var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/', function(req, res, next) {


         pg.connect(global.databaseURI, function(err, client, done){
             client.query("SELECT * FROM stock WHERE status='pending'", function(error, result){
                 console.log(result.rows);
                 res.render('new', {results: result.rows});
             });
         });
});

module.exports = router;
