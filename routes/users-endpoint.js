/**
 * Provides an endpoint for accessing the Users data
 */

var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/*
 * Endpoint (GET) for determining whether a user exists in the database.
 *
 * Clients must specify a username, which will be checked for in the database.
 * Returns true if the username exists, or false otherwise.
 *
 * */
router.get('/', function(req, res, next) {
    console.log("Checking username " + req.query.username);


    pg.connect(global.databaseURI, function(err, client, done) {

        // Prepare the SQL query using string interpolation to populate username and password
        var QUERYSTRING = "SELECT * FROM Users WHERE username='%NAME%';".replace("%NAME%", req.query.username);

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
            console.log(error);
            if(error) {
                console.error('Failed to execute query');
                console.error(error);
                return;
            }
            else if (result.rowCount === 0){
                res.send(false); // The username is NOT in the DB
                return;
            } else {
                res.send(true); // The username IS in the DB
                return;
            }
        })
    });

});

module.exports = router;