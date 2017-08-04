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


router.get('/testFind', function(req, res, next) {
	var id = req.query.id;
	CustomerDAO.find({
		CustomerId:id,
	},function(err,result){
		//console.log(err);
		console.log(result);
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

router.get('/UploadCustomerInfo', function(req, res, next) {
	CustomerDAO.save({
		MachineCode:req.query.MachineCode,
		MachineStatus:req.query.MachineStatus,
		CDKey:req.query.CDKey,
		CreationDate:req.query.CreationDate,
		ValidDate:req.query.ValidDate,
	},function(err,result){
		//console.log(err);
		console.log(result);
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



router.get('/UpdateLastLogTime', function(req, res, next) {
	CustomerDAO.update({
		MachineCode:req.query.MachineCode
	},{LastLogTime:Date.now()},
	function(err,result){
		//console.log(err);
		console.log(result);
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

router.get('/UpdateCDKey', function(req, res, next) {
	CustomerDAO.update({
		MachineCode:req.query.MachineCode
	},{
		CDKey:req.query.CDKey,
		MachineStatus:req.query.MachineStatus,
		WebCommand:''
		},
	function(err,result){
		//console.log(err);
		console.log(result);
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

router.get('/UpdateCustomer', function(req, res, next) {
	CustomerDAO.update({
		MachineCode:req.query.MachineCode
	},{
		MachineStatus:req.query.MachineStatus,
		CDKey:req.query.CDKey,
		CreationDate:req.query.CreationDate,
		ValidDate:req.query.ValidDate,
		CustomerName:req.query.CustomerName,
		},
	function(err,result){
		//console.log(err);
		console.log(result);
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

router.get('/GetCustomerInfo', function(req, res, next) {
	CustomerDAO.find({
		MachineCode:req.query.MachineCode,
	},function(err,result){
		//console.log(err);
		console.log(result);
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


router.get('/GetCustomerAll', function(req, res, next) {
	CustomerDAO.find(true,function(err,result){
		//console.log(err);
		console.log(result);
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
