var express = require('express');
var router = express.Router();

var LogInfoDAO=require('../DAO/LogDAO');


/* GET home page. */
router.get('/', function(req, res, next) {
	if(req.session.name)
	{
		LogInfoDAO.find({},function(err,result){
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
	}else{
	　　req.session.error = "请先登录"
　　　　res.redirect('/');
	}
});


module.exports = router;