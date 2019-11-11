console.log("mail Service...");

var mailService = (function(){
	function mailCount(callback,error){
		console.log("mailcount");
		
		$.getJSON("/mail/getMailCount",
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
		mailCount:mailCount
	};
})();