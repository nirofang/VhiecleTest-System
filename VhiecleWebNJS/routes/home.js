var express = require('express');
var router = express.Router();
var CustomerDAO=require('../DAO/CustomerDAO');



/* GET home page. */
router.get('/', function(req, res, next) {
	CustomerDAO.find(true,function(err,result){
		//console.log(err);
		console.log(result);
		
		if(err)
		{
			res.render('error', { title: 'error' });
		}
		else
		{
			res.render('home', 
			{ title: 'HomePage' 
			, customers: result
			});
		}
	});
  // res.render('home', { title: '首页' });
  // console.log(req.session.name);
});

router.get('/addUser',function(req,res,next){
	var name=req.query.name;
	var pwd=req.query.pwd;

});

router.get('/ChangeValidDate',function(req,res,next){
  res.send('ok');
  console.log(req.query.operation);
});

module.exports = router;
