/**
 * Provides functions for interacting with the category structure that underlies all of the listings in the
 * database
 */

var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/**
 * Returns a set of the top level categories. Results are always expressed with underscores taking the
 * place of spaces.
 */
router.get('/', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done){
        client.query("SELECT category FROM stock", function(error, result){
            var resultSet = new Set();
            for (categoryDictionary in result.rows){
                var path = result.rows[categoryDictionary]['category'];
                var top = path.split(".")[0];
                resultSet.add(top);
            }
            res.send(resultSet);
        });
    });

});

/**
 * Returns a set of direct descendents of the specified category. Results are always expressed with underscores taking the
 * place of spaces.
 */
router.get('/:category', function(req, res, next) {
    var category = req.params.category;
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("SELECT category FROM stock WHERE category ~'*.%CAT%.*'".replace("%CAT%", category), function(error, result){
            var resultSet = new Set();
            for (categoryDictionary in result.rows){
                var path = result.rows[categoryDictionary]['category'];

                // Add the paths of all descendents of this category
                resultSet.add(path.slice(path.indexOf(category)).split(".").slice(1).join("."));

            }
            console.log(resultSet);
            res.send(resultSet);
        });
    });
});

module.exports = router;