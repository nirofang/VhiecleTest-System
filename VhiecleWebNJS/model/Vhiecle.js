var config=require('../config/MongoDBConfig');
var mongoose=require('mongoose');

mongoose.connect(config.uri);

//在Schma里定义数据类型
var VhiecleSchema = new mongoose.Schema({ //定义一个Schema
	CustomerName: {type:String,default:"xxxxxxxxxxxxx"},
	MachineCode: {type:String,default:"xxxxxxxxxxxxx"},
    VhiecleId:Number,//订单编号
	RegNo: {type:String,default:"xxxxxxxxxxxxx"},
	MakeType: {type:String,default:"xxxxxxxxxxxxx"},
	Milage: {type:String,default:"xxxxxxxxxxxxx"},
	Date: {type:String,default:"xxxxxxxxxxxxx"},
	Sign: {type:String,default:"xxxxxxxxxxxxx"},
	CustomerData: {type:String,default:"xxxxxxxxxxxxx"},
	InfoPage: {type:String,default:"xxxxxxxxxxxxx"},
	SteerboxB: {type:String,default:"xxxxxxxxxxxxx"},
	SteerboxA: {type:String,default:"xxxxxxxxxxxxx"},
	a: {type:String,default:"xxxxxxxxxxxxx"},
	Done: {type:String,default:"xxxxxxxxxxxxx"},
	Side: {type:String,default:"xxxxxxxxxxxxx"},
	CenterLine: {type:String,default:"xxxxxxxxxxxxx"},
	RefAxle: {type:String,default:"xxxxxxxxxxxxx"},
	RefType: {type:String,default:"xxxxxxxxxxxxx"},
	CL_F: {type:String,default:"xxxxxxxxxxxxx"},
	CL_R: {type:String,default:"xxxxxxxxxxxxx"},
	Offset_F0: {type:String,default:"xxxxxxxxxxxxx"},
	Offset_R0: {type:String,default:"xxxxxxxxxxxxx"},
	Type: {type:String,default:"xxxxxxxxxxxxx"},
	FloorscalesUsed: {type:String,default:"xxxxxxxxxxxxx"},
	Model: {type:String,default:"xxxxxxxxxxxxx"},
	RadarType: {type:String,default:"xxxxxxxxxxxxx"},
	RadarHorizontalB: {type:String,default:"xxxxxxxxxxxxx"},
	RadarHorizontalA: {type:String,default:"xxxxxxxxxxxxx"},
	RadarVerticalB: {type:String,default:"xxxxxxxxxxxxx"},
	RadarVerticalA: {type:String,default:"xxxxxxxxxxxxx"},
	RadarAZOF: {type:String,default:"xxxxxxxxxxxxx"},
	RadarELOF: {type:String,default:"xxxxxxxxxxxxx"},
	FrameFrontWidth: {type:String,default:"xxxxxxxxxxxxx"},
	FrameRearWidth: {type:String,default:"xxxxxxxxxxxxx"},
	FrameGauge: {type:String,default:"xxxxxxxxxxxxx"},
	WACreated: {type:String,default:"xxxxxxxxxxxxx"},
	FMCreated: {type:String,default:"xxxxxxxxxxxxx"}
});

mongoose.model('Vhiecle',VhiecleSchema);//将该Schema发布为Model