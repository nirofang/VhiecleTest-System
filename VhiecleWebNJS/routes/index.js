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

/* Test API */
var CustomerDAO=require('../DAO/CustomerDAO');


router.get('/testapi', function(req, res, next) {
	var a = req.query.a;
	var b = req.query.b;
	CustomerDAO.save({
		CustomerName:a,
		Status:b
	},function(err,result){
	//console.log(err);
	//console.log(result);
	if(err)
	{
		res.send({ err:err});
	}
	else
	{
		res.send({ result:result});
	}
	
	//res.send({ title: 'Express' , a:err, b:result});
});

});


// router.post('/testapi_po', function(req, res, next) {
	 // var a = req.body.a;
	 // var b = req.body.b;
	 
	 // CustomerDAO.save({},function(err,result){
	// console.log(err);
	// console.log(result);
	 // });
// });
	 
	// // console.log(req);
  // res.send({ title: 'Express' , a:a, b:b});
// });



module.exports = router;
