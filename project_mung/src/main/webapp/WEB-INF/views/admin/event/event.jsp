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
				<h4 class="page-title">이벤트관리</h4>
			</div>
		</div>
	</div>
	<!--=================================================== 이벤트목록 ================================================-->
	<hr>
	<br>
	<div>
		<div>
			<div>
				<div>
					<form id="searchForm" action="/admin/event/event" method="get">
						<select name="type">
							<option value="" ${pageMaker.cri.type==null?"selected":"" }>
								--
							</option>
							<option value="T" ${pageMaker.cri.type eq "T"?"selected":""}>
								제목
							</option>
							<option value="C" ${pageMaker.cri.type eq "C"?"selected":""}>
								내용
							</option>
						</select> <input type="text" name="keyword" />
						<button class="btn btn-warning">Search</button>
					</form>
				</div>
				<div>
					<form id="searchEvent" action="/admin/event/event" method="get">
						<select name="time">
							<option value="" ${pageMaker.cri.time==null?"selected":"" }>
								--
							</option>
							<option value="S" ${pageMaker.cri.time eq "S"?"selected":"" }>
								진행중인 이벤트
							</option>
							<option value="E" ${pageMaker.cri.time eq "E"?"selected":"" }>
								종료된 이벤트
							</option>
						</select>
						<button>검색</button>
					</form>
				</div>
				<div align="right">
					<a href="../event/addEvent"><button id="addEvent"
							style="color: green;">이벤트 추가</button></a>
				</div>
			</div>
		</div>
		<table id="eventTable" width="100%" cellspacing="0">
			<thead>
				<th>
					이벤트 섬내일
				</th>
				<th>
					이벤트 제목
				</th>
				<th>
					관리자 아이디
				</th>
				<th>
					이벤트 시작 날짜 
				</th>
				<th>
					종료 날짜
				</th>
				<th>
					조회 수
				</th>
			</thead>
				<c:forEach items="${list}" var="event" varStatus="i">
					<tr>
						<td>
							<c:if test="${event.bno eq event.attachImage.bno }">
								<img width=200 height=200 src="http://localhost:8090/resources/images/${event.attachImage.imagePath}/${event.attachImage.uuid}_${event.attachImage.fileName}">
							</c:if>
							</td>
							<td> ${event.title}</td>
							<td> ${event.userid}</td>
							<td> <fmt:formatDate pattern="yyyy-MM-dd" value="${event.updateDate}" /></td>
							<td> <fmt:formatDate pattern="yyyy-MM-dd" value="${event.endDate}" /></td>
							<td> ${event.good}</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	
	<div>
			<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev}">
					<%-- <li class="paginate_button previous"><a href="/board/list?pageNum=${pageMaker.cri.pageNum-((pageMaker.cri.pageNum-1)%10+1) }" class="page-link">prev</a></li> --%>
					<li class="page-item"><a href="${pageMaker.startPage - 1}" class="page-link">prev</a>
				</c:if>
						
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<%-- <li class="page-item"><a href="/board/list?pageNum=${num }" class="page-link">${num }</a></li> --%>
					<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'><a href="${num }" class="page-link">${num}</a></li>
				</c:forEach>
						
				<c:if test="${pageMaker.next}">
					<%-- <li class="paginate_button next"><a href="/board/list?pageNum=${pageMaker.cri.pageNum+(11-((pageMaker.cri.pageNum-1)%10+1)) }" class="page-link">next</a></li> --%>
					<li class="page-item"><a href="${pageMaker.startPage + 10}" class="page-link">next</a>
				</c:if>
			</ul>
        </div>
		
		<form id="actionForm" action="/admin/event/event" method="get">
                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                	<input type="hidden" name="type" value="${pageMaker.cri.type }">
                	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
                	<input type="hidden" name="time" value="${pageMaker.cri.time }">
        </form>
</div>
<!-- ==================================================SCRIPT================================================================= -->

<script type="text/javascript">										
										var actionForm = $("#actionForm");
										// 클래스 page-item 에 a 링크가 클릭 된다면,
										$(".page-item a")
												.on(
														"click",
														function(e) {
															e.preventDefault();
															// 기본 이벤트 동작을 막고,
															console
																	.log("click");
															// 웹 브라우저 검사 창에 클릭을 표시
															actionForm
																	.find(
																			"input[name='pageNum']")
																	.val(
																			$(
																					this)
																					.attr(
																							"href"));
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
																	.append("<input type='hidden' name='userno' "
																			+ "value='"
																			+ $(
																					this)
																					.attr(
																							"href")
																			+ "'>");
															actionForm
																	.attr(
																			"action",
																			"/admin/getMember");
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
										var searchEvent = $("#searchEvent");
										$("#searchEvent button").on("click",function(e){
											if(!searchEvent.find("option:selected").val()){
											alert("검색 종류를 선택해 주세요.");
											return false;
										}
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

<!-- ==============================================footer================================================ -->
<%@ include file="../../admin/includes/footer.jsp"%>