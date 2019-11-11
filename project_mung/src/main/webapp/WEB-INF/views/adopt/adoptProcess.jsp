<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>

<!-- Main -->
<section class="ftco-section" >
	<form action="./adoptRequest" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 mb-5 ftco-animate">
					<input type="hidden" value="${dogs.dogno }" name="dogno" /> <img
						src="http://localhost:8090/resources/images/${dogs.attachImage.imagePath}/${dogs.attachImage.uuid}_${dogs.attachImage.fileName}"
						class="img-fluid">
				</div>
				<div class="col-lg-6 product-details pl-md-5 ftco-animate">
					<h3>유기견 이름 : ${dogs.dogName }</h3>

					<h4>
						<span>품종 : ${dogs.kind} </span> <br> <span>나이 :
							${dogs.age} </span> <br> <span>성별 : ${dogs.gender} </span> <br>
						<span>예방유무 : ${dogs.pre} </span><br>
					</h4>
				</div>
			</div>
			<div align="center">
				<div class="inputArea" align="center">
					<label for="userid"> 신청자 아이디</label> <input type="text"
						name="userid" value="${member.userid }" readonly="readonly"/><br>
				</div>
				<div class="inputArea" align="center">
					<label for="userName">신청자 이름</label> <input type="text"
						name="userName" value="${member.userName }" readonly="readonly"><br>
				</div>
				<div class="inputArea">
					<label for="phone">핸드폰 번호</label> <input type="text" name="phone"
						value="${member.phone }"><br>
				</div>
				<div class="inputArea">
					<label for="addr_1">주소1</label> <input type="text" name="addr_1"
						value="${member.addr_1 }" readonly="readonly"><br>
				</div>
				<div class="inputArea">
					<label for="addr_1">주소2</label> <input type="text" name="addr_2"
						value="${member.addr_2 }" readonly="readonly"><br>
				</div>
				<div class="inputArea">
					<label for="addr_1">주소3</label> <input type="text" name="addr_3"
						value="${member.addr_3 }" readonly="readonly"><br>
				</div>
				<label for="reason">분양을 원하는 이유</label>
				<div class="inputArea">
					<textarea rows="20" cols="80" name="reason"></textarea>
				</div>
			</div>
		</div>
		<p align="center">
		<button type="submit" id="adoptRequest_Btn" class="btn btn-primary">등록</button>
		</p>
	</form>
</section>


<%@ include file="../includes/footer.jsp"%>