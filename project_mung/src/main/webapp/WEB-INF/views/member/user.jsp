<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<script
	src="https://code.jquery.com/jquery-3.4.1.min.js">
</script>
<script 
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js">
</script>
</head>
<body>
	<form method="POST" action="/member/modify">
		<input type="hidden"
				name="${_csrf.parameterName}"
				value="${_csrf.token}">
		<input type="hidden" name="userno" value="${member.userno}">
		<!-- 아이디 -->
		<div class="form-group">
			<label for="userid">아이디</label> 
			<input type="hidden" id="userid" name="userid" value="${member.userid }">
			${member.userid}
		</div>
		<!-- 비밀번호 -->
		<div class="form-group">
			<label for="userpw">비밀번호</label> 
			<a href="/member/findpw">변경하기</a>
		</div>
		<!-- 이름 -->
		<div class="form-group">
			<label for="username">이름</label> 
			<input type="hidden" name="userName" id="username" value="${member.userName}">
			${member.userName}
		</div>
		<!-- 생년월일 -->
		<div class="form-group required">
			<label for="birth">생년월일</label> 
			<input type="text"
				class="form-control" id="birth" name="birth" value="${member.birth }"
				placeholder="ex) 19990415" required>
			<div class="check_font" id="birth_check"></div>
		</div>
		<!-- 본인확인 이메일 -->
		<div class="form-group">
			<label for="email">이메일</label> 
			<input type="text"
				class="form-control" name="email" id="useremail" placeholder="E-mail" value="${member.email }"
				required>
			<!-- <input type="text" style="margin-top: 5px;"class="email_form" name="email_confirm" id="email_confirm" placeholder="인증번호를 입력해주세요!" required>
						<button type="button" class="btn btn-outline-danger btn-sm px-3" onclick="confirm_email()">
							<i class="fa fa-envelope"></i>&nbsp;인증
						</button>&nbsp;
						<button type="button" class="btn btn-outline-info btn-sm px-3">
							<i class="fa fa-envelope"></i>&nbsp;확인
						</button>&nbsp; -->
			<div class="check_font" id="email_check"></div>
		</div>
		<!-- 휴대전화 -->
		<div class="form-group">
			<label for="phone">휴대전화 ('-' 없이 번호만 입력해주세요)</label> 
			<input
				type="text" class="form-control" id="userphone" name="phone"
				value="${member.phone}" placeholder="Phone Number" required>
			<div class="check_font" id="phone_check"></div>
		</div>
		<div class="form-group">                   
				<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="addr_1" id="addr1" type="text" value="${member.addr_1 }" readonly="readonly" >
				<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
			</div>
			<div class="form-group">
				   <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr_2" id="addr2" type="text" value="${member.addr_2 }" readonly="readonly" />
			</div>
			<div class="form-group">
				   <input class="form-control" placeholder="상세주소" name="addr_3" id="addr3" type="text" value="${member.addr_3}" />
		</div>
		<div class="reg_button">
			<a class="btn btn-danger px-3"
				href="/"> <i
				class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
			</a>&emsp;&emsp;
			<button class="btn btn-primary px-3" id="reg_submit">
				<i class="fa fa-heart pr-2" aria-hidden="true"></i>수정하기
			</button>
		</div>
	</form>
	<!-- ==============================SCRIPT======================================= -->

	<script>
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		//아이디 정규식
		var nameJ = /^[가-힣]{2,6}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
						// 휴대전화
						$('#userphone').blur(function(){
							if(phoneJ.test($(this).val())){
								$("#phone_check").text('');
							} else {
								$('#phone_check').text('휴대폰번호를 확인해주세요 :)');
								$('#phone_check').css('color', 'red');
							}
						});
						
						// 생일 유효성 검사
						var birthJ = false;
						// 생년월일	birthJ 유효성 검사
						$('#birth').blur(function(){
							var dateStr = $(this).val();		
						    var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
						    var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
						    var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
						    var today = new Date(); // 날짜 변수 선언
						    var yearNow = today.getFullYear(); // 올해 연도 가져옴
							
						    if (dateStr.length <=8) {
								// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
							    if (1900 > year || year > yearNow){
							    	
							    	$('#birth_check').text('생년월일을 확인해주세요 :)');
									$('#birth_check').css('color', 'red');
							    	
							    }else if (month < 1 || month > 12) {
							    		
							    	$('#birth_check').text('생년월일을 확인해주세요 :)');
									$('#birth_check').css('color', 'red'); 
							    
							    }else if (day < 1 || day > 31) {
							    	
							    	$('#birth_check').text('생년월일을 확인해주세요 :)');
									$('#birth_check').css('color', 'red'); 
							    	
							    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
							    	 
							    	$('#birth_check').text('생년월일을 확인해주세요 :)');
									$('#birth_check').css('color', 'red'); 
							    	 
							    }else if (month == 2) {
							    	 
							       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
							       	
							     	if (day>29 || (day==29 && !isleap)) {
							     		
							     		$('#birth_check').text('생년월일을 확인해주세요 :)');
										$('#birth_check').css('color', 'red'); 
							    	
									}else{
										$('#birth_check').text('');
										birthJ = true;
									}//end of if (day>29 || (day==29 && !isleap))
							     	
							    }else{
							    	
							    	$('#birth_check').text(''); 
									birthJ = true;
								}//end of if
								
								}else{
									//1.입력된 생년월일이 8자 초과할때 :  auth:false
									$('#birth_check').text('생년월일을 확인해주세요 :)');
									$('#birth_check').css('color', 'red');  
								}
							}); //End of method /*
						
						
							// 가입하기 실행 버튼 유효성 검사!
							var inval_Arr = new Array(3).fill(false);
							$('#reg_submit').click(function(){
								// 이메일 정규식
								if (mailJ.test($('#useremail').val())){
									console.log(mailJ.test($('#useremail').val()));
									inval_Arr[0] = true;
								} else {
									inval_Arr[0] = false;
								}
								// 휴대폰번호 정규식
								if (phoneJ.test($('#userphone').val())) {
									console.log(phoneJ.test($('#userphone').val()));
									inval_Arr[1] = true;
								} else {
									inval_Arr[1] = false;
								}
								// 생년월일 정규식
								$("#birth").focus();
								$("#birth").blur();
								if (birthJ) {
									console.log(birthJ);
									inval_Arr[2] = true;
								} else {
									inval_Arr[2] = false;
								}
								
								var validAll = true;
								for(var i = 0; i < inval_Arr.length; i++){
									
									if(inval_Arr[i] == false){
										validAll = false;
									}
								}
								
								var id = $('#username').val();
								
								if(validAll == false){ // 유효성 모두 통과
									alert('입력한 정보들을 다시 한번 확인해주세요 :)')
									return false;
								}
							});							
		
		</script>
		<script>
		function execPostCode() {
		         new daum.Postcode({
		             oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		 
		                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
		 
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }
		                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
		                if(fullRoadAddr !== ''){
		                    fullRoadAddr += extraRoadAddr;
		                }
		 
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                console.log(data.zonecode);
		                console.log(fullRoadAddr);
		                
		                
		                $("[name=addr_1]").val(data.zonecode);
		                $("[name=addr_2]").val(fullRoadAddr);
		                
		                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
		                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
		            }
		         }).open();
		     }
	</script>

</body>
</html>