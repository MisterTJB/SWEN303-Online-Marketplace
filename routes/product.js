var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/:productid', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var votes_required;
        client.query("SELECT value FROM site_parameters WHERE parameter='VOTES_REQUIRED'", function(error, result){
            votes_required = result.rows[0].value;
        });

        console.log("SELECT * FROM (stock JOIN users ON stock.uid=users.uid) WHERE sid=%PRODUCTID%;".replace("%PRODUCTID%", req.params.productid));
        client.query("SELECT * FROM (stock JOIN users ON stock.uid=users.uid) WHERE sid=%PRODUCTID%;".replace("%PRODUCTID%", req.params.productid), function(error, result){
            product = result.rows[0];
            res.render("product", {
                title: product.label,
                desc: product.description,
                listed_by: product.username,
                voters: product.voters.slice(1),
                votes: product.votes,
                votesRequired: votes_required,
                price: product.price,
                status: product.status,
                stock: product.quantity,
                meanValuation: mean(product.valuations),
                valuersCount: product.valuers.length,
                valuersList: product.valuers,
                sellingAtList: product.selling_at_list,
                categories: []});

        });
        done();

    });
});

router.get('/:productid/valued-by/:userid', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }


        console.log("SELECT valuers FROM stock WHERE sid=%PRODUCTID%;".replace("%PRODUCTID%", req.params.productid));
        client.query("SELECT valuers FROM stock WHERE sid=%PRODUCTID%;".replace("%PRODUCTID%", req.params.productid), function(error, result){
            done();
            var valuers = result.rows[0].valuers;
            if (valuers.indexOf(req.params.userid) === -1){
                res.send(false);
            } else {
                res.send(true);
            }

        });
        done();

    });
});

router.get('/:productid/raw', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var votes_required;
        client.query("SELECT value FROM site_parameters WHERE parameter='VOTES_REQUIRED'", function(error, result){
            done();
            votes_required = result.rows[0].value;
        });

        client.query("SELECT * FROM stock where sid='%PRODUCTID%';".replace("%PRODUCTID%", req.params.productid), function(error, result){
            done();
            product = result.rows[0];
            res.send({
                title: product.label,
                desc: product.description,
                listed_by: product.voters[0],
                voters: product.voters.slice(1),
                votes: product.votes,
                votesRequired: votes_required,
                price: product.price,
                stock: product.quantity,
                meanValuation: mean(product.valuations),
                valuersCount: product.valuers.length,
                valuersList: product.valuers,
                categories: []});
        });
        done();

    });
});

function mean(list){
    if (list.length > 0) {
        var sum = list.reduce(function (a, b) {
            return a + b;
        });
        return sum / list.length;
    }
}

router.post('/:productid', function(req, res, next) {

    var productID = req.params.productid;
    var voteup = req.body.voteUp;
    var user = req.body.user;

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var votes_required;
        client.query("SELECT value FROM site_parameters WHERE parameter='VOTES_REQUIRED'", function(error, result){
            done();
            console.log(result);
            votes_required = result.rows[0].value;

            var QUERY = "UPDATE stock SET votes=votes%VOTE_OPERATOR%, voters=array_append(voters, '%USERID%') WHERE sid=%STOCKID% RETURNING votes;"
            QUERY = QUERY.replace("%USERID%", user);
            QUERY = QUERY.replace("%STOCKID%", productID);
            if (voteup){
                QUERY = QUERY.replace("%VOTE_OPERATOR%", "+1");
            } else {
                QUERY = QUERY.replace("%VOTE_OPERATOR%", "-1");
            }

            var votes_received;
            client.query(QUERY, function(err, result){
                done();
                console.log(result);
                votes_received = result.rows[0].votes;


                if (votes_required === votes_received){
                    console.log("votes_required: " + votes_required + "\nvotes_received: " + votes_received);
                    QUERY = "UPDATE stock SET status='listed' WHERE sid=%STOCKID%;".replace("%STOCKID%", productID);
                    client.query(QUERY, function(err, result){
                        done();
                        console.log(QUERY);
                    });
                }
            });
        });

        res.send();

    });
});

router.post('/:productid/sold', function(req, res, next) {

    console.log("POST to transactions/productid/sold");

    var productID = req.params.productid;

    console.log("Setting product with id " + productID + "to 'sold'");
    var QUERY = "UPDATE stock SET status='sold' WHERE sid=%STOCKID%;".replace("%STOCKID%", productID);
    console.log(QUERY);

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        client.query(QUERY, function(error, result){
            done();
            console.log(result);
        });

    });
});

router.post('/:productid/setvaluation', function(req, res, next) {

    console.log("POST to products/productid/setvaluation");

    var productID = req.params.productid;

    console.log("Setting product with id " + productID + "to 'sold'");
    var QUERY = "UPDATE stock SET selling_at_list=false WHERE sid=%STOCKID%;".replace("%STOCKID%", productID);
    console.log(QUERY);

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        client.query(QUERY, function(error, result){
            console.log(result);
            res.send();
            done();
        });
        done();

    });
});

router.post('/:productid/delete', function(req, res, next) {

    console.log("POST to products/productid/delete");

    var productID = req.params.productid;

    var QUERY = "UPDATE stock SET status='deleted' WHERE sid=%STOCKID%;".replace("%STOCKID%", productID);
    console.log(QUERY);

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        client.query(QUERY, function(error, result){
            console.log(result);
            done();
        });

    });
});



module.exports = router;
