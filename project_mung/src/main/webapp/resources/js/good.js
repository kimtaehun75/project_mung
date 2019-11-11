console.log("good Service...");

var goodService = (function(){
	
	function removeGood(saleno,userid,callback,error){
		$.ajax({
			type:'delete',
			url:'/good/',
			data:JSON.stringify({saleno:saleno,userid:userid}),
			contentType:'application/json; charset=utf-8',
			success: function(deleteResult,status,xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function checkGood(param,callback,error){
		var saleno = param.saleno;
		console.log("getCartList..");
		
		$.getJSON("/good/checkGoodCount/"+saleno,
				function(count){
					if(callback){
						callback(count);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
	}
	
	function insertGood(good,callback,error){
		console.log("insertGood : "+good);
		
		$.ajax({
			url:'/good/insert',
			data:JSON.stringify(good),
			dataType : 'text',
			contentType:'application/json; charset=utf-8',
			type:'POST',
			success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return {
		removeGood:removeGood,
		checkGood:checkGood,
		insertGood:insertGood
	};
})();
