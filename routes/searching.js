var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/searching', function(req, res){

    // input value from search
    var val = req.query.search;
    console.log("Test");
    console.log(req.query.adv);

    // Check if it should be an advanced search
    if(req.query.adv == 'true'){
            console.log("Doing advanced");
            searchDatabase(createQueryAdvanced( 
                req.query.search,
                req.query.catagory,
                req.query.sortBy,
                req.query.minPrice,
                req.query.maxPrice,
                req.query.inStockOnly
                ),res);
    }
    else {
        console.log("Not Doing advanced");
            searchDatabase(createQueryNormal(req.query.search),res);
    }

    // response = searchDatabase(val,res);

});

function searchDataBase(query, res){

}

function createQueryNormal(search){
    return "SELECT * FROM Stock WHERE label LIKE '%"+ search+"%';";
}

function createQueryAdvanced(search, catagory, sort, min, max, stock ){
var queryString = "SELECT * FROM Stock WHERE label LIKE '%"+ search + "%' ";


// Check if not the default value
if(catagory != "Catagory"){
    queryString += "AND category='"+catagory+"'";
}

if(min != "" && max != ""){
  queryString += "AND price BETWEEN "+min+" AND "+max;      
}

// Only find products in stock
if(stock){
  queryString += " AND quantity > 0 ";        
}

if(sort != "Sort by"){
    queryString += "ORDER BY "+sort;  
}

console.log(queryString);
return queryString +=";";

}

function searchDatabase(queryString,res){

        // Connect to the database
        pg.connect(global.databaseURI, function(err, client, done) {

        // Prepare the SQL query using string interpolation to populate label
        // var QUERYSTRING = "SELECT * FROM Stock WHERE label LIKE '%LABEL%';".replace("%LABEL%", "%"+val+"%");

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

            console.log(result);
            if(error) {
                console.error('Failed to execute query');
                console.error(error);
                return;
            }
             else {
                res.send(result.rows); // Send the search results
                return;
            }
        })
    });
}
module.exports = router;
