var express = require('express');
var router = express.Router();

var LogInfoDAO=require('../DAO/LogDAO');


/* GET home page. */
router.get('/', function(req, res, next) {
	//res.render('logs', { title: '日志' });
	
  	LogInfoDAO.find(true,function(err,result){
		//console.log(err);
		console.log(result);
		
		if(err)
		{
			res.render('error', { title: 'error' });
		}
		else
		{
			res.render('logs', 
			{ title: '日志' 
			, loginfos: result
			});
		}
	});
  
});


module.exports = router;