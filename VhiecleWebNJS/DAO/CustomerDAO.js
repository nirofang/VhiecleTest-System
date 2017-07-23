require('../model/Customer.js');
var mongoose = require('mongoose');

var Customer=mongoose.model('Customer');



var CustomerDAO={};

CustomerDAO.save=function(c,callback){
	var customer=new Customer({
		CustomerId:c.CustomerId||1,
		CustomerName:c.CustomerName||'临时用户',
		MachineKey:c.MachineKey||'123456'
	});
	customer.save(function(err,result){
		callback(err,result);
	});
};
CustomerDAO.find=function(condition,callback){
	Customer.find(condition,function(err,result){
		callback(err,result);
	});
};
CustomerDAO.update=function(condition,newValues,callback){
	Customer.update(condition,{$set:newValues},{upsert : true},function(err,result){
		callback(err,result);
	});
};

module.exports=CustomerDAO;

