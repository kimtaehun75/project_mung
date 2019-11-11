<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>

<!-- Main -->
<%@ include file="../includes/mypagesidebar.jsp"%>
<div class="container">
		<div class="card shadow mb-4" style="float:center;">
			<div class="card-header py-3" align="right">
				<!-- <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6> -->
				<button id="regBtn" style="color: green;">1:1 문의하기</button>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" style="width:100%; 
					cellspacing:0;">						
						<tr>
							<th style="width:15%;">작성자</th>
							<th style="width:60%;">제목</th>
							<th style="width:25%;">작성일</th>
						</tr>
					<!--=========================== forEach ==================================-->
						<%-- <c:forEach var="null" items="${list}">
							<tr>
								<th><c:out value="${null}" /></th>
								<th><a href="${null}" class="move"><c:out
											value="${null}" /></a></th>
								<th><c:out value="${null }" /></th>
							</tr>
						</c:forEach> --%>
					<!--======================================================================-->
					</table>
				</div>
			</div>
		</div>

	<!-- Footer -->
</div>
<%@ include file="../includes/footer.jsp"%>