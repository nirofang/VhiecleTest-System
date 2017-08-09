var config=require('../config/MongoDBConfig');
var mongoose=require('mongoose');

mongoose.connect(config.uri);

//在Schma里定义数据类型
var UserSchema = new mongoose.Schema({ //定义一个Schema
    //UserId:Number,
    name: String,
    passwd: String,
    CreateTime:{ type:Date,default:Date.now},
    //lastLogTime:{ type:Date,default:Date.now},
    //UserType:{type:String,default:1},
});

mongoose.model('User',UserSchema);//将该Schema发布为Model