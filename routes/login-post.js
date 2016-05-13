/**
 * login-post.js defines an endpoint for the login service.
 *
 * Created by Tim on 10/05/16.
 */

var express = require('express');
var router = express.Router();
var pg = require('pg').native;

// Assumes that a database named SWEN303 exists with role:swen303 and password:SWEN303
// at localhost:5432
var database = "postgres://swen303:SWEN303@localhost:5432/SWEN303";


/*
* Endpoint (POST) for logging a user in.
*
* Clients must specify an email and password, which will be validated against stored credentials.
* Returns true if credentials are correct, or false otherwise.
*
* */
router.post('/', function(req, res, next) {
    console.log("Trying to log in");


    pg.connect(database, function(err, client, done) {
        var USERNAME = req.body.email;
        var PASSWORD = req.body.password;

        // Prepare the SQL query using string interpolation to populate username and password
        var QUERYSTRING = "SELECT * FROM Users WHERE username='%NAME%' AND password='%PASSWORD%';".replace("%NAME%", USERNAME).replace("%PASSWORD%", PASSWORD);

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
                res.send(false); // The username:password is NOT in the DB
                return;
            } else {
                res.send(true); // The username:password IS in the DB
                return;
            }
        })
    });

});

module.exports = router;
