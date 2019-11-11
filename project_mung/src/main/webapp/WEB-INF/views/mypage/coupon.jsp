<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<%@ include file="../includes/mypagesidebar.jsp"%>

<div class="page-wrapper">
	<div class="page-breadcrumb">
		<div class="row">
			<div class="col-12 d-flex no-block align-items-center">
				<h4 class="page-title">쿠폰</h4>
			</div>
		</div>
	</div>
	<hr>
	<h5>보유 쿠폰</h5>
	<div>
		<table id="dataTable" width="50%" cellspacing="0">
			<thead>
				<tr>
					<th>쿠폰명</th>
					<th>쿠폰내용</th>
					<th>생성일</th>
					<th>만료일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="coupon" items="${coupon}">
					<tr>
						<td>${coupon.cpName}</td>
						<td>${coupon.cpContent}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${coupon.cpUpdate}"/></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${coupon.cpEndDate}"/></td>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>