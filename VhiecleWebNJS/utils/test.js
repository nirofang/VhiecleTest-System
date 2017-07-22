var mongoose = require('mongoose');
require('./mgose.js');
var Book = mongoose.model('Book');//Book为model name

var book = new Book({
    name: 'MEAN Web Development',
    author: 'trigkit4',
    publishTime: new Date()
});

// book.save(function (err) {
//     console.log('save status:',err ? 'failed' : 'success');
// });



var condition ={
    $or: [
        {author: 'trigkit4'},
        {author: 'Mike'}
    ]
};
Book.find(condition, function (err, results) {
    if(err){
        console.log('condition error'+err);
        return;
    }
    console.log('condition',condition,'results',results);

    for(var i in results){
    	// var newbook=new Book({
    	// 	_id:results[i]._id,
    	// 	name:"新数据"+i
    	// });
    	Book.update({_id:results[i]._id},{$set:{name:"新数据"+i}},function(err){
    		if(err){
    			console.log(err);
    		}else{
                console.log(results[i]);
    			console.log("OK");
    		}
    	});
    }
});

Book.find({author: 'trigkit4'}, function (err,results) {
        console.log("1result:")
        if(err){
            console.log("error:"+err);
            return;
        }
        console.log("temp  result")
        console.log('results'+results);
        console.log("temp  result2")
    });