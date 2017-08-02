require('../model/Customer.js');
var mongoose = require('mongoose');

var Customer=mongoose.model('Customer');



var CustomerDAO={};

CustomerDAO.save=function(c,callback){
	var customer=new Customer({
		CustomerId:c.CustomerId||1,
		CustomerName:c.CustomerName||'临时用户',
		MachineStatus:c.MachineStatus||'已停用',
		MachineCode:c.MachineCode||'123456',
		CDKey:c.CDKey||'xxxxx-xxxxx-xxxxx-xxxxx',
		CreationDate:c.CreationDate||'2017-06-06',
		ValidDate:c.ValidDate||'2017-07-06',
		LastLogTime:c.LastLogTime||Date.now()
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

