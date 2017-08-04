var express = require('express');
var router = express.Router();
var CustomerDAO=require('../DAO/CustomerDAO');

require('date-utils');


/* GET home page. */
router.get('/', function(req, res, next) {
	CustomerDAO.find(true,function(err,result){
		//console.log(err);
		console.log(result);
		
		if(err)
		{
			res.render('error', { title: 'error' });
		}
		else
		{
			res.render('home', 
			{ title: 'HomePage' 
			, customers: result
			});
		}
	});
  // res.render('home', { title: '首页' });
  // console.log(req.session.name);
});

router.get('/addUser',function(req,res,next){
	var name=req.query.name;
	var pwd=req.query.pwd;

});

router.post('/ChangeValidDate',function(req,res,next){
	var extendSel = parseInt(req.body.extendSel);
	var valid;
	var creation;
	
	
	if (req.body.valid == "N/A"){
		valid = Date.now();
	}
	else
	{
		valid = Date.parse(req.body.valid)
	}
	if (req.body.creation == "N/A"){
		creation = Date.now();
	}
	else
	{
		creation = Date.parse(req.body.creation)
	}
	console.log("valid:" + valid)
	console.log("creation: " + creation)
	console.log("extendSel: " + req.body.extendSel)
	
	switch(extendSel)
	{
		case -1:
			valid = Date.yesterday();
			creation = Date.yesterday();
			break;
	    case 0:
			valid = Date.parse("2000-1-1");
			break;
	    case 1:
			valid = (new Date(valid)).addMonths(1);
			break;
	    case 3:
			valid = (new Date(valid)).addMonths(3);
			break;
	    case 6:
			valid = (new Date(valid)).addMonths(6);
			break;
	    case 12:
			valid = (new Date(valid)).addYears(1);
			break;
	    case 24:
			valid = (new Date(valid)).addYears(2);
			break;	
		default:
		break;
	}

	
	CustomerDAO.update({
		MachineCode:req.body.id
	},{
		ValidDate:valid,
		CreationDate:creation
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
			res.send('ok');
			//res.send({ result:result});
			
		}
		//res.send({ title: 'Express' , a:err, b:result});
	});	

});

module.exports = router;
