var mongoose=require('mongoose');
var uri = 'mongodb://sa:123456@hostname:27017/fzol';
 uri = 'mongodb://localhost/fzol';

mongoose.connect(uri);

//在Schma里定义数据类型
var BookSchma = new mongoose.Schema({ //定义一个Schema
    name: String,
    author: String,
    publishTime:Date
});

mongoose.model('Book',BookSchma);//将该Schema发布为Model