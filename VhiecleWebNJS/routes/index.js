var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/login',function(req,res,next){
	var name=req.query.name;
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
