<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mypagesidebar.jsp"%>
<body>		
		<!-- 보낸사람 -->
		<div class="form-group">
			보낸사람
			<input class="form-control" name="sentid" value="${recv.sentid}" readonly="readonly" style="width:60%;">
		</div>
		
		<div class="form-group">
			제목
			<input class="form-control" name="title" value="${recv.title}" readonly="readonly" style="width:60%;">
		</div>
		
		<div class="form-group">
			<textarea cols="40" rows="10" name="content" readonly="readonly" style="width:60%;">${recv.content}</textarea>
		</div>
		
		<div class="form-group">
			보낸날짜
			<input class="form-control" name="sentDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${recv.sentDate}" />" readonly="readonly" style="width:60%;">
		</div>
		
		
<!--=====================버튼=======================-->
		<div class="reg_button">
			<a class="btn btn-primary px-3"
						href="/mypage/getRecvMail"> <i
						class="fa fa-rotate-right pr-2" aria-hidden="true"></i>목록으로
					</a>&emsp;&emsp;	
		</div>
</body>
<%@ include file="../includes/footer.jsp"%>