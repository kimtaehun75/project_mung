<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
	<div>
		<form action="./registerCoupon" method="post" role="form">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div align="center">
				<br>
				<h3>쿠폰 추가하기</h3>
				<div class="inputArea">
					<label for="cpName">쿠폰 이름</label> 
					<input type="text" id="" name="cpName" style="width:300px;"/>
				</div>

				<div class="inputArea">
					<label for="value">할인값</label> 
					<input type="text" id="" name="value" style="width:286px;" />
				</div>
				<div>
					<label for="type">종류('-' 원값에서 -, '%' 원값에서 %)</label>
					<select name="type">
						<option value="0">
							-
						</option>
						<option value="1">
							%
						</option>
					</select>
				</div>
				<label for="cpContent">쿠폰내용</label> 
				<div class="inputArea">
					<textarea rows="20" cols="80" name="cpContent"></textarea>
				</div>
				<br>
				
				<div class="inputArea">
					<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
				</div>
			</div>
		</form>
	</div>
	
	
<%@ include file="../../admin/includes/footer.jsp"%>