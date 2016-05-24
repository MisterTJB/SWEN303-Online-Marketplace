/**
 * Provides functions for interacting with the category structure that underlies all of the listings in the
 * database
 */

var express = require('express');
var router = express.Router();
var pg = require('pg').native;


/**
 * Returns a set of all unique permitted category paths
 */
router.get('/permitted', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done){
        client.query("SELECT category FROM permitted_categories;", function(error, result){
            var resultSet = new Set();
            for (categoryDictionary in result.rows){
                var path = result.rows[categoryDictionary]['category'];
                resultSet.add(path);
            }
            res.send(Array.from(resultSet).sort());
        });
        done();
    });

});

/**
 * Removes a permitted category from permitted_categories (i.e. soft-delete)
 */
router.post('/permitted/remove', function(req, res, next) {

    console.log("DELETE FROM permitted_categories WHERE category <@ '%CATEGORY%';".replace("%CATEGORY%", req.body.category));
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("DELETE FROM permitted_categories WHERE category <@ '%CATEGORY%';".replace("%CATEGORY%", req.body.category), function(error, result){
            console.log("Tried to soft-delete " + req.body.category);
        });
        res.send();
        done();
    });


});

/**
 * Removes a permitted category from permitted_categories (i.e. soft-delete)
 */
router.post('/permitted/add', function(req, res, next) {

    console.log("INSERT INTO permitted_categories(category) VALUES ('%CATEGORY%');".replace("%CATEGORY%", req.body.category));
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("INSERT INTO permitted_categories(category) VALUES ('%CATEGORY%');".replace("%CATEGORY%", req.body.category), function(error, result){
            console.log("Tried to insert " + req.body.category);
        });
        res.send();
        done();
    });
});


/**
 * Removes a permitted category from permitted_categories and drops stock in that category
 */
router.post('/delete', function(req, res, next) {
    console.log("DELETE FROM permitted_categories WHERE category <@ '%CATEGORY%';".replace(req.body.category));
    console.log("UPDATE stock SET status='deleted' WHERE category <@ '%CATEGORY'%;".replace(req.body.category));
    pg.connect(global.databaseURI, function(err, client, done){
        client.query("DELETE FROM permitted_categories WHERE category <@ '%CATEGORY%';".replace(req.body.category), function(error, result){
            console.log("Tried to hard-delete from permitted " + req.body.category);
        });

        client.query("UPDATE stock SET status='deleted' WHERE category <@ '%CATEGORY%';".replace(req.body.category), function(error, result){
            console.log("Tried to hard-delete from stock " + req.body.category);
        });
         res.send();
        done();
    });

});


/**
 * Returns a set of all unique, permitted categories
 */
router.get('/', function(req, res, next) {

    pg.connect(global.databaseURI, function(err, client, done){
        client.query("SELECT category FROM stock", function(error, result){
            var resultSet = new Set();
            for (categoryDictionary in result.rows){
                var path = result.rows[categoryDictionary]['category'];
                resultSet.add(path);
            }
            res.send(Array.from(resultSet).sort());
        });
        done();
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