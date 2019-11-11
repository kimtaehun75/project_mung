<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div style="margin:auto;">
		<h1>비밀번호 변경</h1>
		<form action="/member/changeUserPw">
				<div class="form-group">
						아이디&nbsp;
					<input type="text" name="userid" class="form-control">
				</div>
					<br>
				<div class="form-group">
						이름&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="userName" class="form-control">
				</div>
					<br>
				<div class="form-group">
						이메일&nbsp;
					<input type="email" name="email" class="form-control">
				</div>
				<p style="font-size: 13px">
				이메일로 변경된 임시비밀번호가 전송됩니다.
				</p>
					<br>
				<button class="btn btn-primary px-3" type="submit" value="login">
		        	<i class="fa fa-heart pr-2" aria-hidden="true"></i>비밀번호 변경
		        </button>
		</form>
	</div>
</div>
	<!-- Footer -->
	<%@ include file="../includes/footer.jsp"%>