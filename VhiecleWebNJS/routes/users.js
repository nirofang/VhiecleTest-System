var express = require('express');
var router = express.Router();

// /* GET users listing. */
// router.get('/', function(req, res, next) {
  // res.send('respond with a resource');
// });

var UserInfoDAO=require('../DAO/UserDAO');


/* GET user page. */
router.get('/', function(req, res, next) {
	//res.render('logs', { title: '日志' });
	if(req.session.name){
		UserInfoDAO.find({},function(err,result){
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

router.get('/DelSelUser', function(req, res, next) {
	
	for(var vi in req.query.users){
		
		var username = req.query.users[vi];
		console.log(req.query.users[vi]);
		if (username == "admin")
		{
			console.log("不能删除admin");
			//res.render('error', { title: 'error' });
		}
		else
		{
			UserInfoDAO.remove(
			{name : username}
			,function(err,result){
			if(err)
			{
				// res.render('error', { title: 'error' });
				console.log("删除" + username + "失败");
			}});
		}
	}
	
	res.send("ok");
	
});


module.exports = router;
