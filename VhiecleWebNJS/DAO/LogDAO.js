require('../model/Log.js');
var mongoose = require('mongoose');

var LogInfo=mongoose.model('LogInfo');

var LogInfoDAO={};

LogInfoDAO.save=function(c,callback){
	var logInfo=new LogInfo({
		CustomerName:c.CustomerName||'临时用户',
		MachineCode:c.MachineCode||'123456',
		OperationDate:c.OperationDate||Date.now(),
		Operation:c.Operation||'延期'
	});
	logInfo.save(function(err,result){
		callback(err,result);
	});
};
LogInfoDAO.find=function(condition,callback){
	LogInfo.find(condition,function(err,result){
		callback(err,result);
	});
};
module.exports=LogInfoDAO;