var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {
  res.render('cart',{ categories: "<option value='temp'>temp</option>" });
});

module.exports = router;
