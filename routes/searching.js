var express = require('express');
var router = express.Router();
var pg = require('pg').native;


var database = "postgres://vanhunick:dolphins@depot:5432/SWEN303vanhunick";

router.get('/searching', function(req, res){

    // input value from search
    var val = req.query.search;
    response = searchDatabase(val,res);

});

function searchDatabase(val,res){

        // Connect to the database
        pg.connect(database, function(err, client, done) {

        // Prepare the SQL query using string interpolation to populate label
        var QUERYSTRING = "SELECT * FROM Stock WHERE label='%LABEL%';".replace("%LABEL%", val);

        // Check whether the connection to the database was successful
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        console.log('Connected to database');

        // Execute the query -- an empty result indicates that the username:password pair does
        // not exist in the database
        client.query(QUERYSTRING, function(error, result){

            console.log(result);
            if(error) {
                console.error('Failed to execute query');
                console.error(error);
                return;
            }
             else {
                res.send(result.rows); // Send the search results
                return;
            }
        })
    });
}
module.exports = router;
