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
		<div class="card-body">
			<div class="table-responsive">
				<h1>받은 쪽지</h1>
				<table class="table table-bordered" id="dataTable" style="width:100%; cellspacing:0;">						
					<tr>
						<th style="width:20%;">
							보낸사람
						</th>
						<th style="width:60%;">
							제목
						</th>
						<th style="width:20%;">
							날짜
						</th>
					</tr>					
					<tbody>
					<c:forEach var="recv" items="${recv}">
						<tr>					
							<td>
								${recv.sentid}
							</td>
							<td>
								<c:if test="${recv.recvread == '읽음' }">
									<a style="color: gray;" href="./getRecvMailInfo?noteno=${recv.noteno}" class="">${recv.title}</a>
								</c:if>
								<c:if test="${recv.recvread == '읽지않음' }">
									<a href="./getRecvMailInfo?noteno=${recv.noteno}" class="">${recv.title}</a>
								</c:if>									
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${recv.sentDate}" />
							</td>						
						</tr>
					</c:forEach>
				</tbody>	
						
				</table>
			</div>
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>