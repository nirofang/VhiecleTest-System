var config=require('../config/MongoDBConfig');
var mongoose=require('mongoose');

mongoose.connect(config.uri);

//在Schma里定义数据类型
var CustomerSchma = new mongoose.Schema({ //定义一个Schema
    CustomerId:Number,//客户编号
    CustomerName: {type:String,default:"xxxxxxxxxxxx"},//客户名称
    MachineCode: {type:String,default:"xxxxxxxxxxxxx"},//机器吗
    CDKey:{type:String,default:"xxxxxxxxxxxx"},//序列号
    CreationDate:{ type:Date,default:Date.now},//创建时间
    LastLogTime:{ type:Date,default:Date.now},//上次心跳时间
    MachineStatus:{type:String,default:"使用中"},//状态
    ValidDate:{type:Date,default:Date.now},//有效截止时间
    Desp:{type:String,default:"xxxxxxxxxxxx"},//描述
    Target:{type:String,default:"xxxxxxxxxxxx"}//拓展字段 
});

mongoose.model('Customer',CustomerSchma);//将该Schema发布为Model