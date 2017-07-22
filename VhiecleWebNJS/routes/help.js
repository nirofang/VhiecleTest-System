var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('help', { title: '帮组文档' });
});


module.exports = router;