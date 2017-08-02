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
	switch(extendSel)
	{
		case -1:
			valid = Date.now();
			break;
	    case 0:
			valid = Date.parse("2222-2-2");
			break;
	    case 1:
			valid = (new Date(Date.parse(req.body.valid))).addMonths(1);
			break;
	    case 3:
			valid = (new Date(Date.parse(req.body.valid))).addMonths(3);
			break;
	    case 6:
			valid =  (new Date(Date.parse(req.body.valid))).addMonths(6);
			break;
	    case 12:
			valid =  (new Date(Date.parse(req.body.valid))).addYears(1);
			break;
	    case 24:
			valid =  (new Date(Date.parse(req.body.valid))).addYears(2);
			break;	
		default:
		break;
	}
	CustomerDAO.update({
		MachineCode:req.body.id
	},{ValidDate:valid},
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
