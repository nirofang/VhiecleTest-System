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

router.get('/DelSelUser', function(req, res, next) {
	
	for(var vi in req.query.users){
		console.log(req.query.users[vi]);
	}
	
	res.send("ok");
	
	// if(req.query.name == '')
	// {
		// res.send("用户名不能为空");
		// return;
	// }
	// if(req.query.pwd == '')
	// {
		// res.send("密码不能为空");
		// return;
	// }
	// UserDAO.find({
		// name:req.query.name
	// },function(err,result){
		// if(err)
		// {
			// res.send("查询用户名失败");

		// }
		// else
		// {
			// console.log(result);
			// if (result != "")
			// {
				// res.send("用户名重复");
				// return;
			// }
			// UserDAO.save({
				// name:req.query.name,
				// passwd:req.query.pwd,
			// },function(err,result){
				// if(err)
				// {
					// console.log(err);
					// res.send("建立用户失败");
				// }
				// else
				// {
					// console.log(result);
					// //res.send({ result:result});
					// res.send('ok');
				// }
			// });

		// }
	// });
});


module.exports = router;
