<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mypagesidebar.jsp"%>
<body>		
	<form action="/mail/writemail" method="post" role="form">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<!-- 받는사람 -->
			<div class="form-group">
				받는사람
				<input class="form-control" id="" name="recvid" style="width:60%;">
			</div>	
	
			<div class="form-group">
				제목
				<input class="form-control" name="title" id="" style="width:60%;">
			</div>		
		
			<div class="form-group">
				<textarea cols="40" rows="10" name="content" id="" style="width:60%;"></textarea>
			</div>
				
<!--=====================버튼=======================-->
		<div class="reg_button">
			<a class="btn btn-danger px-3"
						href="/mypage/getInfo"> <i
						class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소
					</a>&emsp;&emsp;			
			<button type="submit" class="btn btn-primary px-3" id="reg_submit">
				<i class="fa fa-heart pr-2" aria-hidden="true"></i>전송
			</button>
		</div>
	</form>
</body>
<script>
$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
</script>
<%@ include file="../includes/footer.jsp"%>