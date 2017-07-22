var MongoClient = require('mongodb').MongoClient;
var DB_CONN_STR = 'mongodb://localhost:27017/fzol'; 
var mgdb={};   

var insertData = function(db, callback) {  
    //连接到表  
    var collection = db.collection('tb2');
    //插入数据
    var data = [{"name":'wilson001',"age":21},{"name":'wilson002',"age":22}];
    collection.insert(data, function(err, result) { 
        if(err)
        {
            console.log('Error:'+ err);
            return;
        }     
        callback(result);
    });
}

// MongoClient.connect(DB_CONN_STR, function(err, db) {
//     console.log("连接成功！");
//     insertData(db, function(result) {
//         console.log(result);
//         db.close();
//     });
// });

mgdb.insert=function(data,table,callback){

    MongoClient.connect(DB_CONN_STR, function(err, db) {
    if(err){
        throw err;
    }
    var collection=db.collection(table);
    collection.insert(data,function(err,result){
        if(err){
            db.close();
            throw err;
        }
        db.close();
        callback(result);
    });
});

};
mgdb.find=function (data,table,callback){
    MongoClient.connect(DB_CONN_STR, function(err, db) {
    if(err){
        throw err;
    }
    var collection=db.collection(table);
    collection.find(data,function(err,result){
        if(err){
            db.close();
            throw err;
        }
        db.close();
        callback(result);
    });
});
};

mgdb.find({"name":"tom","pwd":"jack"},"users",function(result){
    console.log(result);
});