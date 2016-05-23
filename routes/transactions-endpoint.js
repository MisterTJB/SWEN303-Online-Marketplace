var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/:name', function(req, res, next) {


    var user = req.params.name;


    pg.connect(global.databaseURI, function(err, client, done) {

        // Prepare the SQL query using string interpolation
        var QUERY = "SELECT * FROM transactions WHERE uid=(SELECT uid FROM users WHERE username='%USER%') ORDER BY tid DESC;"
        QUERY = QUERY.replace("%USER%", user);

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
            } else {
                res.send(result.rows);
            }
        });
        done();
    });

});

router.post('/:name/order', function(req, res, next) {


    var user = req.params.name;
    var cart = Array.from(req.body['cartArray[]']).map(function(element){return parseInt(element);});


    console.log(user);
    console.log(cart);



    pg.connect(global.databaseURI, function(err, client, done) {

        // Prepare the SQL query using string interpolation
        var QUERY = "INSERT INTO transactions(uid, products) VALUES ((SELECT uid FROM users WHERE username='%USER%'), ARRAY[%ARRAY%]);"
        QUERY = QUERY.replace("%USER%", user);
        QUERY = QUERY.replace("%ARRAY%", cart);


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
        });
        res.send();
        done();
    });

});

module.exports = router;