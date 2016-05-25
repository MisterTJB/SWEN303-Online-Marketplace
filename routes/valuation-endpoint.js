var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.post('/:productid', function(req, res, next) {

    var productID = req.params.productid;
    var valuation = req.body.valuation;
    var user = req.body.user;

    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "UPDATE stock SET valuations=array_append(valuations, cast(%VALUE% AS numeric(10,2))), valuers=array_append(valuers, '%VALUER%') WHERE sid=%STOCKID%;";
        QUERY = QUERY.replace("%VALUE%", valuation);
        QUERY = QUERY.replace("%VALUER%", user);
        QUERY = QUERY.replace("%STOCKID%", productID);

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            done();
            if (error){
                console.log(error);
            }
            console.log(result);
        });
        res.send();

    });
});


module.exports = router;
