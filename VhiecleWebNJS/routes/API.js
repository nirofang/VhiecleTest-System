var express = require('express');
var router = express.Router();

/* GET home page. */
// router.get('/', function(req, res, next) {
//   res.render('index', { title: 'Express' });
// });

//心跳程序
router.get('/heartbeat／{id}',function(req,res,next){
	var id=req.query.id;
	var pwd=req.query.pwd;
	console.log(name+"---"+pwd);
	if(name=='abc'&&pwd=='123456'){
		res.send('ok');
		req.session.name=name;
	}else{
	res.send('error');
}
});
module.exports = router;