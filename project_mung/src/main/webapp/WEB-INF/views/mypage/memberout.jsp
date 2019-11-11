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
         <h2>회원탈퇴</h2>
         <form method="POST" action="./memberout" role="form">
            <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}">
            <!-- 비밀번호 -->            
            <div class="form-group" style="width:50%;">
               <label for="userpw">비밀번호</label> 
               <input type="password"
                  class="form-control" id="userpw" name="userpw"
                  placeholder="비밀번호를 입력해 주세요." required>
               <p>회원탈퇴 버튼을 누를시 회원탈퇴가 완료됩니다.</p>
            </div>
               <button class="btn btn-primary px-3" id="reg_submit">
                  <i class="fa fa-heart pr-2" aria-hidden="true"></i>탈퇴하기
               </button>
         </form>
      </div>
   </div>
</div>

<script>
	var form = $("form[role='form']");
	
	$("#reg_submit").on("click",function(e){
		e.preventDefault();
		
		var check = confirm("정말로 탈퇴하시겠습니까? 주문 내역이 있다면 배송이 안될 수 있습니다.");
		
		if(check){
			form.submit();
		}else{
			return;
		}
	});
</script>
<%@ include file="../includes/footer.jsp"%>