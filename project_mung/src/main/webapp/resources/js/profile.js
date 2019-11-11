console.log("profile Service...");

var profileService = (function(){
	
	function getProfile(callback,error){
		console.log("getProfile..");
		
		$.getJSON("/member/getProfile/",
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
		getProfile:getProfile
	};
})();