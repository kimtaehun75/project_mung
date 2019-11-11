<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="includes/header.jsp"%>

<!-- Main -->
<div class="col-4 col-12-narrower" style="float:left; width:18%;" >
	<!-- Sidebar -->
	<div id="sidebar">
		
		<!-- <section>
			<h3>유기견 등록 / 분양</h3>
			<ul class="links">
				<li><a href="/adopt/adoptDog" class="">보호중인 유기견들</a></li>
				<li><a href="/adopt/userboard" class="">자유게시판</a></li>
				<li><a href="/adopt/adoptAfter" class="">분양 후기관리</a></li>
				<li><a href="/adopt/adoptReg" class="">유기견 개인 등록</a></li>
			</ul>
			<footer> </footer>
		</section>
 -->
	</div>
</div>
<div class="container">
		<div class="card shadow mb-4" style="float:center;">
			<div class="card-header py-3" align="right">
				<!-- <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6> -->
				<button id="regBtn" style="color: green;">write</button>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" style="width:100%; 
					cellspacing:0;">						
						<tr>
							<th style="width:15%;">작성자</th>
							<th style="width:50%;">제목</th>
							<th style="width:25%;">작성일</th>
							<th style="width:10%;">조회수</th>
						</tr>
					</table>
				</div>
			</div>
		</div>

	<!-- Footer -->
</div>
<%@ include file="includes/footer.jsp"%>