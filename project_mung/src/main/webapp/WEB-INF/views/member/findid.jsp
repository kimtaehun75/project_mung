<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div style="margin:auto;">
			<h1>아이디 찾기</h1>
			<br>
			<form action="/member/findUserId">
				<div class="form-group" style="float:right;">
				이름 &nbsp;<input type="text" name="userName" class="form-control">
				</div>   
				<div class="form-group">
				이메일&nbsp;<input type="email" name="email" class="form-control">
				</div>
				<div class="form-group">			
					<button class="btn btn-primary px-3" type="submit" value="login">
		                     <i class="fa fa-heart pr-2" aria-hidden="true"></i>아이디 찾기
		            </button>
	            </div>
			</form>
	</div>
</div>


<%@ include file="../includes/footer.jsp"%>