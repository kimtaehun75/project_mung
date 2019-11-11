<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>
		
		<div class="row">
			<div style="margin:auto;">
				<div class="panel panel-default">
				<h1>로그인</h1>
				<h2 style="font-size: 11px;">${errorMsg}</h2>
				
				<form method="post" action="/login">
					<div class="form-group" >
						<input type="text" name="loginId" class="form-control" placeholder="아이디" value="${loginId}">
					</div>
					<div class="form-group">
						<input type="password" name="loginPw" class="form-control" placeholder="비밀번호" value="${loginPw}">
					</div>	
					<div class="form-group">
						<input type="checkbox" name="remember-me">자동로그인
					</div>
					<div class="form-group">
						<button class="btn btn-primary px-3" type="submit" value="login">
							<i class="fa fa-heart pr-2" aria-hidden="true"></i>로그인
						</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/member/register">
							<button class="btn btn-primary px-2" type="button" value="login">
								<i class="fa fa-heart pr-2" aria-hidden="true"></i>회원가입
							</button>
						</a>
					</div>
					
					<input type="hidden"
					name="${_csrf.parameterName}"
					value="${_csrf.token}">
					
				<a href="/member/findid">아이디 찾기</a>&nbsp;
				<a href="/member/findpw">비밀번호 찾기</a><br>
				</form>
				</div>
			</div>
		</div>	
			
		<script>
			var result = '<c:out value="${result}"/>';
			
			if(result != null && result != ''){
				alert(result);
			}
		</script>
<%@ include file="includes/footer.jsp"%>