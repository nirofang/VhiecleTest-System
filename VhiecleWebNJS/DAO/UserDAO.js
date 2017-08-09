require('../model/User.js');
var mongoose = require('mongoose');

var User=mongoose.model('User');

var UserDAO={};

UserDAO.save=function(user,callback){
	var user=new User({
		name:user.name||'临时用户',
		passwd:user.passwd||'123456'
	});
	user.save(function(err,result){
		callback(err,result);
	});
};

UserDAO.find=function(condition,callback){
	User.find(condition,function(err,result){
		callback(err,result);
	});
};


module.exports=UserDAO;

