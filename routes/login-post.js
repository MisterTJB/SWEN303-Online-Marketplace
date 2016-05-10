/**
 * Created by Tim on 10/05/16.
 */

var express = require('express');
var router = express.Router();

/* Endpoint for logging a user in */
router.post('/', function(req, res, next) {
    console.log("Trying to log in");

    // TODO Implement credential checking against the database
    if (req.body.email === "test"){
        res.send(true);
    } else {
        res.send(false);
    }

});

module.exports = router;
