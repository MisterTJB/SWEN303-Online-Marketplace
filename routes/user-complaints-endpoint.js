var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/', function(req, res, next){
    var QUERY = "SELECT * FROM user_complaints WHERE reviewed=false ORDER BY cid DESC;";
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


router.post('/', function(req, res, next) {

    var id = req.body.productid;
    var complainant = req.body.complainant;
    var complaint = req.body.complaint;
    var user = req.body.username;

    console.log(req.body);


    pg.connect(global.databaseURI, function(err, client, done) {
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        var QUERY = "INSERT INTO user_complaints(complainant, username, complaint) VALUES ('%USER%', '%ABOUT_USER%', '%COMPLAINT%');";
        QUERY = QUERY.replace("%PID%", id);
        QUERY = QUERY.replace("%USER%", complainant);
        QUERY = QUERY.replace("%ABOUT_USER%", user);
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

        var QUERY = "UPDATE user_complaints SET reviewed=true WHERE cid=%CID%;".replace("%CID%", req.params.complaintid);

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