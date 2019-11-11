<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>

<!-- Main -->
<section class="ftco-section">
	<form>
	<div class="container">
		<div class="row">
			<div class="col-lg-6 mb-5 ftco-animate">
			<input type="hidden" value="${dogs.dogno}" name="dogno"/>
				<img
					src="http://localhost:8090/resources/images/${dogs.attachImage.imagePath}/${dogs.attachImage.uuid}_${dogs.attachImage.fileName}"
					class="img-fluid">
			</div>
			<div class="col-lg-6 product-details pl-md-5 ftco-animate">
				<h3>유기견 이름 : ${dogs.dogName}</h3>

				<h4>
					<span>품종 : ${dogs.kind} </span> <br> 
					<span>나이 : ${dogs.age} </span> <br> 
					<span>성별 : ${dogs.gender} </span> <br>
					<span>예방유무 : ${dogs.pre} </span><br>
				</h4>
			</div>
		</div>
		<div >
			<font size="6em" >
				<p align="center">
				${dogs.detail}
				</p>
			</font>
		</div>
			<p align="center">
				<a href="/adopt/adoptProcess?dogno=${dogs.dogno}" class="btn btn-black py-3 px-5">입양 신청</a>
			</p>
	</div>
	</form>
</section>


<%@ include file="../includes/footer.jsp"%>