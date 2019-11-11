<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="includes/header.jsp"%>

		<!-- Main -->
		<section class="wrapper style1">
			<div class="container">
				<div class="row gtr-200">
					<div class="col-4 col-12-narrower">
					</div>
					<div>					
						<div id="content">
							<img src="resources/images/반려동물가이드.png" width=100%;>
							
							<!-- 배변훈련 -->
							<h3 style="color:black; font-family:Black Han Sans; font-size:40pt;">애완견 배변훈련</h3>
							<object type="text/html" width="100%" height="700" data="//youtube.com/embed/hMuird65Gdw" allowfullscreen=""></object>
							
							<!-- 놀이방법 -->
							<h3 style="color:black; font-family:Black Han Sans; font-size:40pt;">올바른 놀이방법</h3>
							<object type="text/html" width="100%" height="700" data="//youtube.com/embed/MoSkg0VQf-4" allowfullscreen=""></object>
							
							<!-- 산책 -->
							<h3 style="color:black; font-family:Black Han Sans; font-size:40pt;">애완견 산책방법</h3>
							<object type="text/html" width="100%" height="700" data="//youtube.com/embed/gNyEsbP2WbY" allowfullscreen=""></object>
							
							<!-- 마사지 -->
							<h3 style="color:black; font-family:Black Han Sans; font-size:40pt;">마사지 방법</h3>
							<object type="text/html" width="100%" height="700" data="//youtube.com/embed/q0CdSTvMlvw" allowfullscreen=""></object>
						</div>
					</div>
				</div>
			</div>
		</section>

<%@ include file="includes/footer.jsp"%>