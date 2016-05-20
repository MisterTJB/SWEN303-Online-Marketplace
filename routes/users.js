var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/:username', function(req, res, next) {
  res.render("user-dashboard");
});

module.exports = router;
