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

        client.query("SELECT * FROM stock where sid='%PRODUCTID%';".replace("%PRODUCTID%", req.params.productid), function(error, result){
            product = result.rows[0];
            res.render("product", {
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
            console.log(result);
            votes_required = result.rows[0].value;
        });

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
            console.log(result);
            votes_received = result.rows[0].votes;
        });

        if (votes_required === votes_received){
            QUERY = "UPDATE stock SET status='listed' WHERE sid=%STOCKID%;".replace("%STOCKID%", productID);
            client.query(QUERY, function(err, result){
                console.log(QUERY);
            });
        }
        res.send();

    });
});


module.exports = router;
