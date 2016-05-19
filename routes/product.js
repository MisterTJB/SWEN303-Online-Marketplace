var express = require('express');
var router = express.Router();
var pg = require('pg').native;

/* GET home page. */
router.get('/:productid', function(req, res, next) {

  var prodID = req.params.productid;
  res.render("product", {title: "Test", desc: "Description", price: 100, stock: 10, categories: []});
 
});

function getProduct(prodID, res){
	        // Connect to the database
        pg.connect(global.databaseURI, function(err, client, done) {

        // Prepare the SQL query using string interpolation to populate label
        var QUERYSTRING = "SELECT * FROM Stock WHERE sid="+prodID+";";
        done();
        // Check whether the connection to the database was successful
        if(err){
            console.error('Could not connect to the database');
            console.error(err);
            return;
        }

        console.log('Connected to database');

        // Execute the query -- an empty result indicates that the username:password pair does
        // not exist in the database
        client.query(QUERYSTRING, function(error, result){
            done();
            console.log(result);
            if(error) {
                console.error('Failed to execute query');
                console.error(error);
                return;
            }
             else {
             	  	var inStock = "Not in stock";
  			if(result.rows[0].quantity > 0 ){
  				inStock = "In stock : " + result.rows[0].quantity;
  			}

             	  res.render('product', { title: result.rows[0].label,
  					      desc: result.rows[0].description,
  					      price: result.rows[0].price,
  					      stock: inStock,
                                        categories: "<option value='temp'>temp</option>"// Temporary, need to have a common method to get the categories from the database
  					    });
            }
        })
    });
}

module.exports = router;
