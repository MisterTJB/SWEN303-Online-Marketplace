var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/', function(req, res, next){
    var QUERY = "SELECT cid, pid, username, complaint, label FROM (product_complaints JOIN stock ON pid=sid) WHERE reviewed=false ORDER BY cid DESC;";
    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            res.send(result.rows);
            done();
        });


    });
});


router.post('/:productid', function(req, res, next) {

    var id = req.params.productid;
    var username = req.body.username;
    var complaint = req.body.complaint;

    console.log(req.body);


    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "INSERT INTO product_complaints(pid, username, complaint) VALUES (%PID%, '%USER%', '%COMPLAINT%');";
        QUERY = QUERY.replace("%PID%", id);
        QUERY = QUERY.replace("%USER%", username);
        QUERY = QUERY.replace("%COMPLAINT%", complaint.replace(/'/g, "''"));

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            res.send();
            done();
        });


    });
});

router.post('/complaint/:complaintid', function(req, res, next) {



    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "UPDATE product_complaints SET reviewed=true WHERE cid=%CID%;".replace("%CID%", req.params.complaintid);

        console.log(QUERY);
        client.query(QUERY, function(error, result){
            if (error){
                console.log(error);
            }
            res.send();
            done();
        });


    });
});

module.exports = router;