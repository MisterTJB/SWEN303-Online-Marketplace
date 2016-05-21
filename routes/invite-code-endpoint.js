/**
 * Provides functions for interacting with the invite table
 */

var express = require('express');
var router = express.Router();
var pg = require('pg').native;


/**
 * Creates a new invite code in the invite_codes table and returns that value to the caller
 */
router.post('/', function(req, res, next) {
    var userid = req.body.userid;
    console.log("%USER% is trying to create code".replace("%USER%", userid));
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("INSERT INTO invite_codes VALUES (uuid_generate_v4(), '%USERID%', false) RETURNING code".replace("%USERID%", userid), function(error, result){

            res.send(result);
        });
    });
});

/**
 * Checks to see if an invite code exists
 */
router.get('/:uuid', function(req, res, next) {
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("SELECT * FROM invite_codes WHERE code='%UUID%'".replace("%UUID%", req.params.uuid), function(error, result){
            if (result.rowCount === 1){
                res.send({validCode: true, used: result.rows[0].used});
            } else {
                res.send({validCode: false});
            }
        });
    });
});

/**
 * Updates a code when it has been used
 */
router.put('/:uuid', function(req, res, next) {
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("UPDATE invite_codes SET used='true' WHERE code='%UUID%'".replace("%UUID%", req.params.uuid), function(error, result){

        });
    });
});

module.exports = router;