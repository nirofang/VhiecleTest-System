var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('home', { title: '首页' });
  console.log(req.session.name);
});

router.get('/addUser',function(req,res,next){
	var name=req.query.name;
	var pwd=req.query.pwd;

});
module.exports = router;
