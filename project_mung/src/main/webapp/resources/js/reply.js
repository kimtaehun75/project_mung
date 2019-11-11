
console.log("Reply module.....");
/*var replyService = (function(){
	function add(reply,callback){
		console.log("reply.........")
	}
	
	return {add:add};
})();*/
// 즉시 실행함수, 예) var a = new A();
// 실체는 클래스 선언 없이 만들고, 객체화 처리.

var replyService = (function(){
	function add(reply,callback,error){
	console.log("add reply.......");
	
	$.ajax({
		type:'post',
		url:'/replies/new',
		data:JSON.stringify(reply),
		contentType:"application/json; charset=utf-8",
		// 설정
		success: function(result,status,xhr){
			if(callback){
				callback(result);
			}
		},
		//성공
		error: function(xhr,status,er){
			if(error){
				error(er);
			}
		}
		//실패
	})
	}
	
	function getList(param,callback,error){
		var bno = param.bno;
		var page = param.page || 1;
		// 파라미터로 page를 받았다면 그 값을 page에 넣고, 그게 아니라면 1를 전달
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
				function(data){
					if(callback){
						/*callback(data);*/
						callback(data.replyCnt,
								data.list);
					}
		}).fail(function(xhr,status,err){
			// xhr : xml http request 약자
			// 현재는 사용되지 않고, 형식만 맞춰줌
			if(error){
				error(er);
			}
		});
	}
	
	function remove(rno,userid,callback,error){
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,
			data:JSON.stringify({rno:rno,userid:userid}),
			contentType:"application/json; charset=utf-8",
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
	
	function update(reply,callback,error){
		console.log("rno :"+reply.rno);
		
		$.ajax({
			type:'put',
			url:'/replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:'application/json; charset=utf-8',
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
	
	function get(rno,callback,error){
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,er){
			if(error){
				error(er);
			}
		});
	}
	
	function displayTime(timeValue){
		var today = new Date(); // 현재 시간
		var gap = today.getTime() - timeValue; // 시간차이 연산
		var dateObj = new Date(timeValue); // 댓글이 등록된 시간을 변수에 할당함
		var str = "";
		
		if(gap<(1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return  [ (hh>9?'':'0')+hh, ':',(mi>9?'':'0')+mi, ':',(ss>9?'':'0')+ss].join('');	
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth()+1;
			var dd = dateObj.getDate();
			
			return [ yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd ].join(''); // 배열값들을 문자열로 변환함
		}	
		
	}
	
	/*function count(bno,callback,error){
		// 파라미터로 page를 받았다면 그 값을 page에 넣고, 그게 아니라면 1를 전달
		$.getJSON("/replies/pages/count/"+bno+".json",
				function(data){
					if(callback){
						callback(data);
					}
		}).fail(function(xhr,status,err){
			// xhr : xml http request 약자
			// 현재는 사용되지 않고, 형식만 맞춰줌
			if(error){
				error(er);
			}
		});
	}*/
	// 해당 게시물의 댓글갯수
	
	return {
		add:add,
		// add 메소드를 add라는 이름으로 사용
		// 앞에는 사용할 때이름, 뒤에는 사용하고자하는 함수
		getList:getList,
		// 호출하는 함수명 : 함수
		remove:remove,
		update:update,
		get:get,
		displayTime : displayTime
	};
})();