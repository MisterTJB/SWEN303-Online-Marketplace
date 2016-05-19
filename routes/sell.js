var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('sell', {categories: "<option value='temp'>temp</option>"}); // Temporary, need to have a common method to get the categories from the database
});

module.exports = router;
