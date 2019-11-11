<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
	<div>
		<form action="./registerUser" method="post" role="form">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div align="center">
				<br>
				<h3>회원 쿠폰 부여</h3>
				<div class="inputArea">
					<label for="userid">아이디</label> 
					<input type="text" name="userid">
				</div>
				<div>
					<label for="cpEndDate">쿠폰 사용 종료일</label>
					<input type="date" id="" name="cpEndDate">
				</div>
				<div>
					<label for="cpNum">부여할 쿠폰 선택</label>
						<select name="cpnum">
							<c:forEach items="${list}" var="coupon">
								<option value="${coupon.cpnum}">
									[${coupon.cpnum}]${coupon.cpName}
								</option>
							</c:forEach>
						</select>
				</div>
				<br>
				
				<div class="inputArea">
					<button type="submit" id="register_Btn" class="btn btn-primary">쿠폰 부여하기</button>
				</div>
			</div>
		</form>
	</div>
	
	
<%@ include file="../../admin/includes/footer.jsp"%>