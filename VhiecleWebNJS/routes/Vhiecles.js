var express = require('express');
var router = express.Router();

var VhiecleDAO=require('../DAO/VhiecleDAO');


/* 读取车辆信息 */
router.get('/', function(req, res, next) {
	if(req.session.name)
	{
		VhiecleDAO.find(true,function(err,result){
			//console.log(err);
			console.log(result);
			
			if(err)
			{
				res.render('error', { title: 'error' });
			}
			else
			{
				res.render('vhiecles', 
				{ title: '车辆维修订单' 
				, vhiecles: result
				});
			}
		});
	}else{
	　　req.session.error = "请先登录"
　　　　res.redirect('/');
	}
});


module.exports = router;
