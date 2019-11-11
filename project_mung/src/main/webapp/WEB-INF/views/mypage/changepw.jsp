<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mypagesidebar.jsp"%>
<div class="container">
   <div class="card shadow mb-4" style="float: center;">
      <div class="card-body">
         <h2>비밀번호 변경</h2>
         <form method="POST" action="">
            <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}">
            <!-- 비밀번호 -->            
            <div class="form-group" style="width:50%;">
               <label for="">현재 비밀번호</label> <input type="password"
                  class="form-control" id="old" name="old"
                  placeholder="현재 비밀번호" required>
            </div>
            <!-- 비밀번호 -->
            <div class="form-group" style="width:50%;">
               <label for="userpw">변경할 비밀번호</label> 
               <input type="password"
                  class="form-control" id="userpw" name="userpw"
                  placeholder="변경할 비밀번호" required>
               <div class="check_font" id="pw_check"></div>
               <p>최소 8자리 숫자,문자,특수문자 1개 이상 이용해주세요 '-'</p>
            </div>
            <div class="form-group" style="width:50%;">
               <label for="userpw">비밀번호 재확인</label> <input type="password"
                  class="form-control" id="userpw2" name="userpw2"
                  placeholder="변경할 비밀번호" required>
               <div class="check_font" id="pw2_check"></div>
            </div>   
               <button class="btn btn-primary px-3" id="reg_submit">
                  <i class="fa fa-heart pr-2" aria-hidden="true"></i>변경하기
               </button>
         </form>
      </div>
   </div>
</div>
<%@ include file="../includes/footer.jsp"%>
<!-- ==============================SCRIPT======================================= -->
<script>
//모든 공백 체크 정규식
      var empJ = /\s/g;
// 비밀번호 정규식
      var pwJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;
      // 비밀번호 유효성 검사
      $("#userpw").blur(function(){
         if(pwJ.test($("#userpw").val())){
            console.log("true");
            $("#pw_check").text('');
         }else{
            console.log("false");
            $("#pw_check").text("앗! 아직 조건에 일치하지 않아요!");
            $("#pw_check").css("color","red");
         }
      });
      // 패스워드 일치 확인
      $("#userpw2").blur(function(){
         if($("#userpw").val() != $(this).val()){
            $("#pw2_check").text("비밀번호가 일치하지 않습니다 :(");
            $("#pw2_check").css("color","red");
         }else{
            $("#pw2_check").text("");
         }
      });
            
      var inval_Arr = new Array(0).fill(false);
      $('#reg_submit').click(function(){
    	  if (($('#userpw').val() == ($('#userpw2').val()))
					&& pwJ.test($('#userpw').val())) {
				inval_Arr[0] = true;
			} else {
				inval_Arr[0] = false;
			}
    	  
    	  var validAll = true;
			for(var i = 0; i < inval_Arr.length; i++){
				
				if(inval_Arr[i] == false){
					validAll = false;
				}
			}
			
			if(validAll){ // 유효성 모두 통과
				$("#userpw2").remove();
			} else{
				alert('입력한 정보들을 다시 한번 확인해주세요 :)')
				return;
			}
      });
      
      
</script>