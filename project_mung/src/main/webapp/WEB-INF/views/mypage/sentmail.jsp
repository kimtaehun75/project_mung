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
				<h1>보낸 쪽지</h1>
				<table class="table table-bordered" id="dataTable" style="width:100%; cellspacing:0;">						
					<tr>			
						<th style="width:20%;">
							받은사람
						</th>
						<th style="width:60%;">
							제목
						</th>
						<th style="width:20%;">
							날짜
						</th>
					</tr>					
					<tbody>
					<c:forEach var="sent" items="${sent}">
						<tr>					
							<td>
								${sent.recvid}
							</td>
							<td>
								<a href="./getSentMailInfo?noteno=${sent.noteno}" class="">${sent.title}</a>
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${sent.sentDate}" />
							</td>						
						</tr>
						<input type="hidden" value="${sent.noteno }">
					</c:forEach>
				</tbody>	
						
				</table>
			</div>
		</div>
	</div>
</div>

<!--==========================================================SCRIPT=================================================================-->

<script type="text/javascript">										
	
	var result = '<c:out value="${result}"/>';
	
	if(result != null && result != ''){
		alert(result);
	}
										
	var actionForm = $("#actionForm");
										
	// 클래스 page-item 에 a 링크가 클릭 된다면,
										
	$(".page-item a").on("click",function(e) {							
			e.preventDefault();							
			// 기본 이벤트 동작을 막고,
			console.log("click");
			// 웹 브라우저 검사 창에 클릭을 표시
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			// 액션폼 인풋태그에 페이지넘 값을 찾아서,
			// href로 받은 값으로 대체함.
	actionForm.submit();
			
	});

										$(".move")
												.on(
														"click",
														function(e) {
															e.preventDefault();
															actionForm
																	.append("<input type='hidden' name='userid' "
																			+ "value='"
																			+ $(
																					this)
																					.attr(
																							"href")
																			+ "'>");
															actionForm
																	.attr(
																			"action",
																			"/mypage/sentMailInfo");
															actionForm.submit();
														});

										var searchForm = $("#searchForm");
										$("#searchForm button")
												.on(
														"click",
														function(e) {
															if (!searchForm
																	.find(
																			"option:selected")
																	.val()) {
																alert("검색 종류를 선택하세요.");
																return false;
															}
															if (!searchForm
																	.find(
																			"input[name='keyword']")
																	.val()) {
																alert("키워드를 입력하세요.");
																return false;
															}

															searchForm
																	.find(
																			"input[name='pageNum']")
																	.val(1);
															e.preventDefault();
															searchForm.submit();

														});
</script>

<script>
					$(document).ready(function() {
						$('#dataTable').DataTable({
							"order" : [ [ 0, "desc" ] ], //정렬 0컬럼의 내림차순으로
							"paging" : false, // 페이징 표시 안함.
							"bFilter" : false, // 검색창 표시 안함.
							"info" : false
						// 안내창 표시 안함.
						})
					})
				</script>
<%@ include file="../includes/footer.jsp"%>