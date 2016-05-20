var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/', function(req, res, next) {


	 pg.connect(global.databaseURI, function(err, client, done) {

         pg.connect(global.databaseURI, function(err, client, done){
             client.query("SELECT category FROM stock", function(error, result){
                 var resultSet = new Set();
                 for (categoryDictionary in result.rows){
                     var path = result.rows[categoryDictionary]['category'];
                     var top = path.split(".")[0];
                     resultSet.add(top);
                 }
                 res.render('index', {categories: Array.from(resultSet).sort()});
             });
         });
    });
});

module.exports = router;
