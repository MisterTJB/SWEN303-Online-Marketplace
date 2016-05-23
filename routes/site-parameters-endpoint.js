var express = require('express');
var router = express.Router();
var pg = require('pg').native;


router.get('/valuations-required', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "SELECT value FROM site_parameters WHERE parameter='VALUATIONS_REQUIRED';";

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            res.send(result.rows[0]);
            console.log(result);
            done();
        });


    });
});

module.exports = router;