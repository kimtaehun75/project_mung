console.log("cart Service...");

var cartService = (function(){
	function insertMainCart(cart,callback,error){
		console.log("insertMainCart : "+cart);
		
		$.ajax({
			url:'/cart/insertMainCart',
			data:JSON.stringify(cart),
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
	
	function cartCount(callback,error){
		console.log("cartcount");
		
		$.getJSON("/cart/getCartCount",
		function(data){
			if(callback){
				callback(data);
				console.log(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
	}
	
	function getCartList(param,callback,error){
		var userid = param.userid;
		console.log("getCartList..");
		
		$.getJSON("/cart/getCartList/"+userid,
				function(list){
					if(callback){
						callback(list);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
	}
	
	function checkCart(param,callback,error){
		var saleno = param.saleno;
		console.log("getCartList..");
		
		$.getJSON("/cart/checkCartCount/"+saleno,
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
	
	function getCartCost(param,callback,error){
		var userid = param.userid;
		console.log("getCartCost..");
		
		$.getJSON("/cart/getCartCost/"+userid,
				function(data){
					if(callback){
						callback(data);
						console.log(data);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
	}
	
	
	function removeCart(saleno,userid,callback,error){
		
		$.ajax({
			type:'delete',
			url:'/cart/',
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
	
	function getCouponList(param,callback,error){
		var userid = param.userid;
		console.log("getCouponList..");
		
		$.getJSON("/cart/getCouponList/"+userid,
				function(data){
					if(callback){
						callback(data);
						console.log(data);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
		
		
	}
	
	function getSaleCost(param,callback,error){
		var userid = param.userid;
		var cpnum = param.cpnum;
		console.log("getSaleCost...");
		
		$.getJSON("/cart/getSaleCost/"+userid+"/"+cpnum,
				function(data){
					if(callback){
						callback(data);
						console.log(data);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
		});
	}
	
	
	return {
		cartCount:cartCount,
		insertMainCart:insertMainCart,
		getCartList:getCartList,
		removeCart:removeCart,
		getCartCost:getCartCost,
		checkCart:checkCart,
		getCouponList:getCouponList,
		getSaleCost:getSaleCost
	};
})();