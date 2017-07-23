var config=require('../config/MongoDBConfig');
var mongoose=require('mongoose');

mongoose.connect(config.uri);

//在Schma里定义数据类型
var CustomerSchma = new mongoose.Schema({ //定义一个Schema
    CustomerId:Number,//客户编号
    CustomerName: {type:String,default:"xxxxxxxxxxxx"},//客户名称
    MachineKey: {type:String,default:"xxxxxxxxxxxxx"},//机器吗
    Key:{type:String,default:"xxxxxxxxxxxx"},//序列号
    CreateTime:{ type:Date,default:Date.now},//创建时间
    lastLogTime:{ type:Date,default:Date.now},//上次心跳时间
    Stutas:{type:String,default:"使用中"},//状态
    ValidTime:{type:Date,default:Date.now},//有效截止时间
    Desp:{type:String,default:"xxxxxxxxxxxx"},//描述
    target:{type:String,default:"xxxxxxxxxxxx"}//拓展字段 
});

mongoose.model('Customer',CustomerSchma);//将该Schema发布为Model