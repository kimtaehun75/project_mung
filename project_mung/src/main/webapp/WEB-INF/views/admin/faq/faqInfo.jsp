<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="card shadow mb-4" style="float: center;">
		<div class="card-body">

			<div class="form-group">
				질문<input class="form-control" name="title" value="${faq.title}"
					readonly="readonly" style="width: 100%; text-align:center;" >
			</div>
			<div class="form-group" align="center">답변
				<div class="content">${faq.content}</div>
			</div>
			<div>
				<button id="list" class="btn btn-info">목록 으로</button>
				<button id="remove" class="btn btn-info">삭제 하기</button>
			</div>
			<form id="operForm" action="/admin/faq/faq" method="get">
				<input type="hidden" id="bno" name="bno" value="${faq.bno}" /> 
				<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
				<input type="hidden" name="amount" value="${cri.amount}" /> 
				<input type="hidden" name="type" value="${cri.type}"/> 
				<input type="hidden" name="keyword" value="${cri.keyword}"/>
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
		$("button[id='remove']").on("click", function(e) {
			var check = confirm("게시물을 삭제하시겠습니까?");
			if(check){
				operForm.attr("action","/admin/faq/remove"); 
				operForm.attr("method","post");
				operForm.append("<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token}'/>");
				operForm.submit();
			};
		});
		$("button[id='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/admin/faq/faq");
			operForm.submit();
		});
		/* 폼에서 어떤 버튼이 눌렸는지 확인하여,
		액션을 변경하거나, 일부 값을 삭제하여 전송.*/
	});
</script>
<%@ include file="../includes/footer.jsp"%>