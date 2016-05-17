var express = require('express');
var router = express.Router();
var pg = require('pg').native;

router.get('/searching', function(req, res){

    // Check if it should be an advanced search
    if(req.query.adv == 'true'){
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
            searchDatabase(createQueryNormal(req.query.search),res);
    }
});


function createQueryNormal(search){
    return "SELECT * FROM Stock WHERE label LIKE '%"+ search+"%';";
}

function createQueryAdvanced(search, catagory, sort, min, max, stock ){
    console.log(stock);
var queryString = "SELECT * FROM Stock WHERE label LIKE '%"+ search + "%' ";

// Check if not the default value
if(catagory != "Catagory"){
    queryString += "AND category='"+catagory+"'";
}

if(min != "" && max != ""){
  queryString += "AND price BETWEEN "+min+" AND "+max;      
}
else if(min !=""){// Max must be empty 
    queryString += "AND price > "+min+" ";      
}
else if(max !=""){// Min must be empty so assume 0
    queryString += "AND price BETWEEN 0 AND "+max;      
}

// Only find products in stock
if(stock == 'true'){
  queryString += " AND quantity > 0 ";        
}

if(sort != "Sort by"){
    queryString += "ORDER BY "+sort;  
}


return queryString +=";";
}

function searchDatabase(queryString,res){

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
                res.send(result.rows); // Send the search results
                return;
            }
        })
    });
}
module.exports = router;
