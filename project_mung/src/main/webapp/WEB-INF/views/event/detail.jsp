<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/header.jsp"%>
<style>
.content img{
	max-width : 100%;
}
</style>
<div class="container">
	<div class="card shadow mb-4" style="float: center;">
		<div class="card-body">
			<div class="form-group">
				제목<input class="form-control" name="title" value="${event.title}"
					readonly="readonly" style="width: 100%;">
			</div>
			<div class="form-group" style="display:inline-block;">
				<table>
					<tr>
						이벤트 기간
					</tr>
					<tr>
						<td>
							<input class="form-control" name="updateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${event.updateDate }" />">
						</td>
						<td>
							~
						</td>
						<td>
							<input class="form-control" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${event.endDate }" />">
						</td>
					</tr>
				</table>
			</div>
			<div class="form-group">
				<div class="content">
					${event.content}
				</div>
			</div>
			<div>
				<button data-oper="list" class="btn btn-info">
					<!-- <a href="/board/list">  -->
					목록
					<!-- </a> -->
				</button>
				
				<sec:authentication 
					property="principal"
					var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<!-- 인증된 사용자만 허가 -->
					<!-- 인증되었으면서 작성자가 본인 일때 수정 버튼 표시 -->
					<c:if test="${pinfo.username eq event.userid }">
						<button class="btn btn-primary" data-oper="modify"> 
							<i aria-hidden="true"></i>수정
						</button>
						<button class="btn btn-warning" data-oper="remove"> 
							<i aria-hidden="true"></i>삭제
						</button>
					</c:if>
		        </sec:authorize>
			</div>
			<form id="operForm" action="/event/modify" method="get">
				<input type="hidden" id="bno" name="bno" value="${event.bno}" /> 
				<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
				<input type="hidden" name="amount" value="${cri.amount}" /> 
				<input type="hidden" name="type" value="${cri.type}"> 
				<input type="hidden" name="keyword" value="${cri.keyword}">
			</form>
		</div>
	</div>
</div>
<script>
	/* $(document).ready(function() {
		console.log("history.state : " + history.state);
	}); */
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/event/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/event/event");
			operForm.submit();
		});
		$("button[data-oper='remove']").on("click", function(e) {
			var check = confirm("게시물을 삭제하시겠습니까?");
			if(check){
				operForm.append("<input type='text' name='userid' value='${event.userid}'>");
				operForm.append("<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token}'/>");
				operForm.attr("action","/event/remove"); 
				operForm.attr("method","post");
				operForm.submit();
			}
		});
		/* 폼에서 어떤 버튼이 눌렸는지 확인하여,
		액션을 변경하거나, 일부 값을 삭제하여 전송.*/
		
		
	});
</script>
<%@ include file="../includes/footer.jsp"%>