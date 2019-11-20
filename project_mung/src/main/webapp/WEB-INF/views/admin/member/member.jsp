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
				<h4 class="page-title">회원관리</h4>
			</div>
		</div>
	</div>
	<!--=================================================== 회원목록 ================================================-->
	<hr>
	<br>
	<div>
		<div align="right"></div>
		<div>
			<div>
				<div>
					<form id="searchForm" action="/admin/member/member" method="get">
						&nbsp;&nbsp;&nbsp;
						<select name="type">
							<option value="" ${pageMaker.cri.type==null?"selected":"" }>
								--
							</option>
							<option value="G" ${pageMaker.cri.type eq "G"?"selected":"" }>
								회원등급
							</option>
							<option value="N" ${pageMaker.cri.type eq "N"?"selected":"" }>
								이름
							</option>
							<option value="I" ${pageMaker.cri.type eq "I"?"selected":"" }>
								아이디
							</option>
							<option value="A" ${pageMaker.cri.type eq "A"?"selected":"" }>
								주소
							</option>
						</select> 
						<input type="text" name="keyword" />
						<button>검색</button>
					</form>
				</div>
			</div>
			<table id="dataTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원등급</th>
						<th>이름</th>
						<th>아이디</th>
						<th>주소</th>
						<th>연락처</th>
						<th>가입일</th>
						<th>계정 권한</th>
						<th>계정상태</th>
						<th>신고 횟수</th>
						<th>분양 유무</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${list}">
						<tr>
							<td>
								${member.userno}
							</td>
							<td>
								${member.grade.tear} 
							</td>
							<td>
								${member.userName}
							</td>
							<td>
								<c:if test="${member.report > 4}">
									<a href="./getMember?userid=${member.userid}" class="" style="color:red;">${member.userid}</a>
								</c:if>
								<c:if test="${member.report < 5}">
									<a href="./getMember?userid=${member.userid}" class="">${member.userid}</a>
								</c:if>
							</td>
							<td>
								${member.addr_2}
							</td>
							<td>
								${member.phone}
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${member.joinDate}" />
							</td>
							<td>
								${member.authList[0].auth}
							</td>
							<td>
								${member.enabled}
							</td>
							<td>
								${member.report}
							</td>
							<td>
								${member.adopt}
							</td>
						</tr>
					</c:forEach>
				</tbody>
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
		
		<form id="actionForm" action="/admin/member/member" method="get">
                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                	<input type="hidden" name="type" value="${pageMaker.cri.type }">
                	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
        </form>

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
																			"/admin/member/getUser");
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

<!-- ==============================================footer================================================ -->
<%@ include file="../../admin/includes/footer.jsp"%>