var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/', function(req, res){

    console.log("GOT TO SEARCH");


    // Check if it should be an advanced search
    if(req.query.adv == 'true'){
        console.log("searching advanced");
            searchDatabase(createQueryAdvanced(
                req.query.q,
                req.query.category,
                req.query.minPrice,
                req.query.maxPrice,
                req.query.valued
                ),res);
    }
    else {
            console.log("searching normal");
            searchDatabase(createQueryNormal(req.query.q),res);
    }
});


function createQueryNormal(q){

    if(q){
        var QUERY = "SELECT * FROM stock WHERE lower(label) LIKE '%_SEARCH_%' AND status='listed';".replace("_SEARCH_", search);
    } else {
        var QUERY = "SELECT * FROM stock WHERE status='listed';"
    }
    return QUERY;
}

function createQueryAdvanced(q, category, min, max, valued ){



    var QUERY = "SELECT * FROM stock";

    if(q){
        QUERY = QUERY + " WHERE lower(label) LIKE '%_SEARCH_%'".replace("_SEARCH_", search);
    }

    if (category){
        QUERY = QUERY + " AND category <@ '%CATEGORY%'".replace("%CATEGORY%", category);
    }
    if (min){
        QUERY = QUERY + " AND price > %MIN%".replace("%MIN%", min);
    }
    if (max){
        QUERY = QUERY + " AND price < %MAX%".replace("%MAX%", max);
    }
    if (valued === true){
        QUERY = QUERY + " AND selling_at_list=false";
    }

    QUERY = QUERY + " AND status='listed';";

    if(QUERY.indexOf("WHERE") === -1){
        QUERY = QUERY.replace("AND", "WHERE");
    }

    return QUERY;

}

function searchDatabase(queryString,res){

    console.log(queryString);

        // Connect to the database
        pg.connect(global.databaseURI, function(err, client, done) {

        // Check whether the connection to the database was successful
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        console.log('Connected to database');

        // Execute the query -- an empty result indicates that the username:password pair does
        // not exist in the database
        client.query(queryString, function(error, result){
        done();
            console.log(result);
            if(error) {
                console.error('Failed to execute query');
                console.error(error);
                return;
            }
             else {
                for (row in result.rows){
                    result.rows[row].valued_at = mean(result.rows[row].valuations);
                }
                res.render('search', {rows: result.rows}); // Send the search results
                return;
            }
        })
    });
}

function mean(list){
    if (list.length > 0){
        sum = list.reduce(function(a, b){return a + b;});
        return sum/list.length;
    }
}

module.exports = router;
