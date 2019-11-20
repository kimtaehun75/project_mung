<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
<div>
	<form action="./dogUpdate" method="post" role="form">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}">
		<div align="center">
			<input type="hidden" value="${dogs.dogno }" name="dogno"/>
			<div class="inputArea">
				<label for="title"> 강아지 이름</label> <input type="text"
					value="${dogs.dogName }" name="dogName" style="width: 150px;"
					readonly="readonly" />
			</div>
			<div class="inputArea">
				<label for="userid"> 작성자 아이디</label> <input type="text"
					name="userid" style="width: 135px;" value="${dogs.userid }"
					readonly="readonly" />
			</div>

			<div class="inputArea">
				<label for="kind"> 품종</label> <input type="text" id="" name="kind"
					style="width: 193px;" value="${dogs.kind }" readonly="readonly" />
			</div>
			<div class="inputArea">
				<label for="kind"> 나이</label> <input type="text" id="" name="age"
					style="width: 193px;" value="${dogs.age }" readonly="readonly" />
			</div>
			<div class="inputArea">
				<label>예방접종</label> <input type="text" name="pre"
					value="${dogs.pre}" readonly="readonly" />
			</div>
			<div class="inputArea">
				<label>성별</label> <input type="text" name="gender"
					style="width: 193px;" value="${dogs.gender}" readonly="readonly" />
			</div>

			<label for="content"> 설명</label>
			<div class="inputArea">
				${dogs.detail}
			</div>
			
			<div class="inputArea">
				<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
			</div>
		</div>
	</form>
</div>

<%@ include file="../../admin/includes/footer.jsp"%>