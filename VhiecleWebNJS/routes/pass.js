var express = require('express');
var router = express.Router();

var UserDAO=require('../DAO/UserDAO');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('pass', { title: '修改密码' });
});

// http://sqlvm-194:3000/pass/SaveNewUser?name=abcd&pwd=12345
router.get('/SaveNewUser', function(req, res, next) {
	UserDAO.save({
		name:req.query.name,
		passwd:req.query.pwd,
	},function(err,result){
		//console.log(err);
		console.log(result);
		if(err)
		{
			res.send({ err:err});
		}
		else
		{
			//res.send({ result:result});
			res.redirect('/');
		}
	});
});


module.exports = router;