<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>

<%@ include file="../../admin/includes/nav.jsp"%>

<div class="page-wrapper">
	<div class="page-breadcrumb">
		<div class="row">
			<div class="col-12 d-flex no-block align-items-center">
				<h4 class="page-title">유기견 신청자 목록</h4>
			</div>
		</div>
	</div>
	<!--=================================================== 유기견 신청자 목록 ================================================-->
	<hr>
	<br>
	<div>
		<div align="right"></div>
		<div>
			<table id="dataTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>유기견 사진</th>
						<th>유기견 번호</th>
						<th>신청자 아이디</th>
						<th>신청자 핸드폰</th>
						<th>신청자 주소1</th>
						<th>신청자 주소2</th>
					</tr>
				</thead>
				<c:forEach items="${list}" var="adopt" varStatus="i">
					<tbody>
						<tr>
							<td>
								<form id="actionForm" action="../admin/dogAdopt/adoptAdmit"
									method="get">
									<input type="hidden" value="${adopt.dogno}" name="dogno">
                         			<input type="hidden" value="${adopt.bno}" name="bno">
									<a href="${adopt.dogno }" class="get">
									<img width=200 height=200
										src="http://localhost:8090/resources/images/${adopt.attachImage.imagePath}/${adopt.attachImage.uuid}_${adopt.attachImage.fileName}">
									</a>
								</form>
							</td>
							<td>${adopt.dogno }</td>
							<td>${adopt.userid }</td>
							<td>${adopt.phone }</td>
							<td>${adopt.addr_1 }</td>
							<td>${adopt.addr_2 }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
<!-- ==================================================SCRIPT================================================================= -->

<script>

var actionForm = $("#actionForm");

$(".get").on("click",function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' "
							+ "value='" + $(this).attr("href")
							+ "'>");
			actionForm.attr("action", "../dogAdopt/adoptAdmit");
			actionForm.submit();
		});
</script>

<!-- ==============================================footer================================================ -->
<%@ include file="../../admin/includes/footer.jsp"%>