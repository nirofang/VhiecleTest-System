//require('./User.js');
//var mongoose = require('mongoose');

var CustomerDAO=require('../DAO/CustomerDAO');

var d1=Date.now;
for(j=10;j>=0;j--)
{
CustomerDAO.save({},function(err,result){
	//console.log(err);
	//console.log(result);
});
}
var d2=Date.now;
CustomerDAO.find({"CustomerId":1},function(err,result){
	if(err)
	{
		console.log(err);
		return;
	}
	for(var index in result){
		console.log(result[index].Key);
	}

});
CustomerDAO.update({"CustomerId":1},{"CustomerId":12},function(err,result){
	if(err)
	{
		console.log(err);
		return;
	}
	console.log(result);

});
//console.log(d2.getTime()-d1.getTime());