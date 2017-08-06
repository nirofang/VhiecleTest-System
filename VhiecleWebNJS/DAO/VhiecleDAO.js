require('../model/Vhiecle.js');
var mongoose = require('mongoose');

var Vhiecle=mongoose.model('Vhiecle');


var VhiecleDAO={};

VhiecleDAO.save=function(c,callback){
	var vhiecle=new Vhiecle({
		CustomerName:c.CustomerName,
		MachineCode:c.MachineCode,
		VhiecleId:c.VhiecleId,
		RegNo:c.RegNo,
		MakeType:c.MakeType,
		Milage:c.Milage,
		Date:c.Date,
		Sign:c.Sign,
		CustomerData:c.CustomerData,
		InfoPage:c.InfoPage,
		SteerboxB:c.SteerboxB,
		SteerboxA:c.SteerboxA,
		a:c.a,
		Done:c.Done,
		Side:c.Side,
		CenterLine:c.CenterLine,
		RefAxle:c.RefAxle,
		RefType:c.RefType,
		CL_F:c.CL_F,
		CL_R:c.CL_R,
		Offset_F0:c.Offset_F0,
		Offset_R0:c.Offset_R0,
		Type:c.Type,
		FloorscalesUsed:c.FloorscalesUsed,
		Model:c.Model,
		RadarType:c.RadarType,
		RadarHorizontalB:c.RadarHorizontalB,
		RadarHorizontalA:c.RadarHorizontalA,
		RadarVerticalB:c.RadarVerticalB,
		RadarVerticalA:c.RadarVerticalA,
		RadarAZOF:c.RadarAZOF,
		RadarELOF:c.RadarELOF,
		FrameFrontWidth:c.FrameFrontWidth,
		FrameRearWidth:c.FrameRearWidth,
		FrameGauge:c.FrameGauge,
		WACreated:c.WACreated,
		FMCreated:c.FMCreated
	});
	vhiecle.save(function(err,result){
		callback(err,result);
	});
};
VhiecleDAO.find=function(condition,callback){
	Vhiecle.find(condition,function(err,result){
		callback(err,result);
	});
};
// CustomerDAO.update=function(condition,newValues,callback){
	// Customer.update(condition,{$set:newValues},{upsert : true},function(err,result){
		// callback(err,result);
	// });
// };


module.exports=VhiecleDAO;

