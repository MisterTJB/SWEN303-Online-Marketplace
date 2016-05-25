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
        done();
    });
});

router.get('/votes-required', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "SELECT value FROM site_parameters WHERE parameter='VOTES_REQUIRED';";

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            done();
            if (error){
                console.log(error);
            }
            res.send(result.rows[0]);
            console.log(result);

        });
        done();


    });
});

router.get('/queue-length', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "SELECT value FROM site_parameters WHERE parameter='PRODUCTS_IN_QUEUE';";

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

router.post('/valuations-required/:newValue', function(req, res, next) {

    var newValuationsRequired = parseInt(req.params.newValue);

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "UPDATE site_parameters SET value=%NEW% WHERE parameter='VALUATIONS_REQUIRED';".replace("%NEW%", newValuationsRequired);

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            done();
        });


    });
});

router.post('/votes-required/:newValue', function(req, res, next) {

    var newVotesRequired = parseInt(req.params.newValue);

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "UPDATE site_parameters SET value=%NEW% WHERE parameter='VOTES_REQUIRED';".replace("%NEW%", newVotesRequired);

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            done();
        });


    });
});

router.post('/queue-length/:newValue', function(req, res, next) {

    var newProductQueueLength = parseInt(req.params.newValue);
    console.log("ATTEMPTING TO ALTER NEW QUEUE LENGTH");


    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "UPDATE site_parameters SET value=%NEW% WHERE parameter='PRODUCTS_IN_QUEUE'".replace("%NEW%", newProductQueueLength);

        console.log(QUERY);
        client.query(QUERY, function(error, result) {
            done();
            if (error) {
                console.log(error);
            }

            var QUERY = "SELECT sid FROM stock WHERE status='pending' ORDER BY sid ASC;";

            console.log(QUERY);
            client.query(QUERY, function (error, result) {
                done();
                if (error) {
                    console.log(error);
                }
                console.log("The rows to remove: " + result.rowCount);
                if (result.rowCount > newProductQueueLength) {
                    var toRemove = result.rows.slice(0, result.rowCount - newProductQueueLength);
                    toRemove = toRemove.map(function(el){return el.sid});
                    var QUERY = "UPDATE stock SET status='unsuccessful' WHERE sid IN (%TO_REMOVE%);".replace("%TO_REMOVE%", toRemove);
                    console.log(QUERY);
                    client.query(QUERY, function (error, result) {
                        done();
                        if (error) {
                            console.log(error);
                        }
                    });
                }

            });
        });
    });


});

module.exports = router;