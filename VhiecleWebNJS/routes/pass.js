var express = require('express');
var router = express.Router();

var UserDAO=require('../DAO/UserDAO');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('pass', { title: '修改密码' });
});

// http://sqlvm-194:3000/pass/SaveNewUser?name=abcd&pwd=12345
router.get('/SaveNewUser', function(req, res, next) {
	if(req.query.name == '')
	{
		res.send("用户名不能为空");
		return;
	}
	if(req.query.pwd == '')
	{
		res.send("密码不能为空");
		return;
	}
	UserDAO.find({
		name:req.query.name
	},function(err,result){
		if(err)
		{
			res.send("查询用户名失败");

		}
		else
		{
			//console.log(result);
			if (result != "")
			{
				res.send("用户名重复");
				return;
			}
			UserDAO.save({
				name:req.query.name,
				passwd:req.query.pwd,
			},function(err,result){
				if(err)
				{
					console.log(err);
					res.send("建立用户失败");
				}
				else
				{
					//console.log(result);
					//res.send({ result:result});
					res.send('ok');
				}
			});

		}
	});
});


module.exports = router;