var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/', function(req, res, next) {


	 pg.connect(global.databaseURI, function(err, client, done) {

        // Select all the distinct categories
        var QUERYSTRING = "SELECT distinct on (category) category  FROM Stock;";

        // Check whether the connection to the database was successful
        if(err){
            res.render('index', { title: 'Express' });
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        console.log('Connected to database');

        // Execute the query -- an empty result indicates that the username:password pair does
        // not exist in the database
         var categories = "";
        client.query(QUERYSTRING, function(error, result){
		done();
            console.log(result);
            if(error) {
                console.error('Failed to execute query');
                console.error(error)
                return;
            }
             else {
             	  	console.log(result);
 			


 			var i = 0;
 			for(i = 0; i < result.rows.length; i++){
 				if(result.rows[i].category != null){
 					categories += "<option value="+result.rows[i].category+">"+result.rows[i].category+"</option>";	
 				}
 			}
 			console.log(categories);


             	  
            }

        });
        res.render('index', { categories: categories });
    });
});

module.exports = router;
