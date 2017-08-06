require('../model/User.js');
var mongoose = require('mongoose');

var UserInfo=mongoose.model('UserInfo');

var UserDAO={};

UserDAO.save=function(user,callback){
	var userInfo=new UserInfo({
		UserId:user.id||1,
		name:user.name||'临时用户',
		passwd:user.passwd||'123456'
	});
	userInfo.save(function(err,result){
		callback(err,result);
	});
};

UserDAO.find=function(condition,callback){
	UserInfo.find(condition,function(err,result){
		callback(err,result);
	});
};


module.exports=UserDAO;

