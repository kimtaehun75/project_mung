<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mypagesidebar.jsp"%>
<body>
	<div class="container">
	<h1 style="text-align:center;">취소/반품/교환 내역</h1>
		<div class="card shadow mb-4" style="float: center;">
			<!--  나중에 조회기능 
			<div class="card-header py-3" align="right">
				<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
				<button id="regBtn" style="color: green;">write</button>
			</div>
			-->
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable"
						style="width: 100%; cellspacing: 0;">
						<thead>
							<tr>
								<th style="width:30%;">날짜/주문번호</th>
								<th style="width:30%;">상품 이름</th>
								<th style="width:10%;">수량</th>
								<th style="width:20%;">상품 금액</th>
								<th style="width:10%;">배송 상태</th>
							</tr>
						</thead>
						<tbody>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="../includes/footer.jsp"%>