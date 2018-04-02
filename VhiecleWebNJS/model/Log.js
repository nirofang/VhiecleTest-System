var config=require('../config/MongoDBConfig');
var mongoose=require('mongoose');

mongoose.connect(config.uri);

//在Schma里定义数据类型
var LogInfoSchema = new mongoose.Schema({ //定义一个Schema
    CustomerName:String,
    MachineCode: String,
    Operation: String,
    Operator: String,
    OperationDate:{ type:Date,default:Date.now},
});

mongoose.model('LogInfo',LogInfoSchema);//将该Schema发布为Model