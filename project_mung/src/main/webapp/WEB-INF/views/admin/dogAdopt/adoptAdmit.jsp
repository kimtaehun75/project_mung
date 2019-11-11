<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
<div>
	<form action="./adoptCompl" method="post" role="form">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}">
		<div align="center">
			<h2>분양 신청 상세정보</h2>
			<div class="inputArea">
				<label for="userid"> 신청자 아이디</label> <input type="text"
					value="${adopt.userid }" name="userid" style="width: 150px;"
					/>
			</div>
			<div class="inputArea">
			<input type="hidden" value="${adopt.bno }" name="bno"/>
			<input type="hidden" value="${adopt.dogno }" name="dogno"/>
				<label for="userName"> 신청자 이름</label> <input type="text"
					name="userName" style="width: 135px;" value="${adopt.userName }"
					readonly="readonly" />
			</div>
			
			<div class="inputArea">
				<label for="phone"> 신청자 전화번호</label> <input type="text" name="phone"
					style="width: 193px;" value="${adopt.phone }" readonly="readonly"/>
			</div>
			<div class="inputArea">
				<label for="addr_1"> 주소1</label> <input type="text" name="addr_1"
					style="width: 193px;" value="${adopt.addr_1 }" readonly="readonly"/>
			</div>
			<div class="inputArea">
				<label for="addr_2"> 주소2</label> <input type="text" name="addr_2"
					style="width: 193px;" value="${adopt.addr_2 }" readonly="readonly"/>
			</div>
			<div class="inputArea">
				<label for="addr_3"> 주소3</label> <input type="text" name="addr_3"
					style="width: 193px;" value="${adopt.addr_3 }" readonly="readonly"/>
			</div>
			<label for="reason"> 신청 이유</label>
			<div class="inputArea">
				<textarea rows="20" cols="80" name="reason"  readonly="readonly">${adopt.reason}</textarea>
			</div>
			
			<div class="inputArea">
				<button type="submit" id="complete_Btn" class="btn btn-primary">분양 완료</button>
			</div>
		</div>
	</form>
</div>

<%@ include file="../../admin/includes/footer.jsp"%>