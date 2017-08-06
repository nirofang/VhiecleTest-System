var express = require('express');
var router = express.Router();

// /* GET users listing. */
// router.get('/', function(req, res, next) {
  // res.send('respond with a resource');
// });

var UserInfoDAO=require('../DAO/UserDAO');


/* GET home page. */
router.get('/', function(req, res, next) {
	//res.render('logs', { title: '日志' });
	if(req.session.name){
		UserInfoDAO.find(true,function(err,result){
			//console.log(err);
			console.log(result);
			
			if(err)
			{
				res.render('error', { title: 'error' });
			}
			else
			{
				res.render('users', 
				{ title: '用户' 
				, userinfos: result
				});
			}
		});
	}else{
	　　req.session.error = "请先登录"
　　　　res.redirect('/');
	}
	
});


module.exports = router;
