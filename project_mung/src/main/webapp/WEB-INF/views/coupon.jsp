<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태크에c 로 표시 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl  fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="/resources/css/main.css" />
<title>Insert title here</title>
</head>
<body>
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header">

			<!-- Logo -->
			<h1>
				<a href="#" id="logo">Project by <em>멍품</em></a>
			</h1>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li class="current"><a href="#">홈으로</a></li>
					<li><a href="#">유기견 등록/분양</a>
						<ul>
							<li><a href="#">보호중인 유기견들</a></li>
							<li><a href="#">자유게시판</a></li>
							<li><a href="#">분양 후기 관리</a></li>
							<li><a href="#">유기견 개인등록</a></li>
						</ul></li>
					<li><a href="#">강아지 모델</a>
						<ul>
							<li><a href="#">강아지 모델</a></li>
						</ul></li>
					<li><a href="#">제품</a>
						<ul>
							<li><a href="#">사료,간식</a></li>
							<li><a href="#">미용</a></li>
							<li><a href="#">건강관리</a></li>
							<li><a href="#">초보자 추천상품</a></li>
							<li><a href="#">이벤트</a></li>
						</ul></li>
					<li><a href="#">고객센터</a>
						<ul>
							<li><a href="#">상담</a></li>
							<li><a href="#">1:1 문의</a></li>
							<li><a href="#">유기견 분양/등록/취소 현황</a></li>
						</ul></li>
					<li><a href="#">마이 페이지 , 관리자 페이지</a>
						<ul>
							<li><a href="#">쇼핑 조회</a></li>
							<li><a href="#">주문 조회</a></li>
							<li><a href="#">장바구니</a></li>
						</ul>
				</ul>
			</nav>
		</div>

		<!-- Main -->
		<section class="wrapper style1">
			<div class="container">
				<div class="row gtr-200">
					<div class="col-4 col-12-narrower">
						<div id="sidebar">

							<!-- Sidebar -->

							<section>
								<h3>정보</h3>
								<ul class="links">
									<li><a href="#">마이 페이지</a></li>
									<li><a href="#">주문 조회</a></li>
									<li><a href="#">제품 취소/교환/반품</a></li>
									<li><a href="#">장바구니</a></li>
									<li><a href="#">보유 쿠폰 조회</a></li>
									<li><a href="#">유기견 등록/분양/취소</a></li>
									<li><a href="#">나의상품 문의 관리</a></li>
									<li><a href="#">나의상품 후기 관리</a></li>
								</ul>
								<footer> </footer>
							</section>

						</div>
					</div>
					<div class="col-8  col-12-narrower imp-narrower">
						<div id="content">

							<!-- Content -->

							<article>
								<header>
									<h2>보유 쿠폰 조회</h2>
								</header>
								<h3>보유중인 쿠폰</h3>
								<table>
									<tbody>
										<c:forEach var="sale" items="${sale_info}">
											<tr>
												<th><c:out value="${sale.orderno }" /></th>
												<th><c:out value="${sale.salename }" /></th>
												<th><c:out value="${sale.cost }" /></th>
												<th><c:out value="${sale.amount }" /></th>
												<th><c:out value="${sale.state }" /></th>
												<th>
													<button type="button" class="cancle">취소</button>
													<button type="button" class="trade">교환</button>
													<button type="button" class="return">반품</button>
												</th>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</article>
						</div>
					</div>
</body>
</html>