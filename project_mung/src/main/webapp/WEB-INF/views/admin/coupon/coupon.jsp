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
				<h4 class="page-title">쿠폰 관리</h4>
			</div>
		</div>
	</div>
	<hr>
	<h5>쿠폰 리스트</h5>
		<div>
			<div>
				<div>
					<form id="searchForm" action="/admin/coupon/coupon" method="get">
						&nbsp;&nbsp;&nbsp;
						<select name="type">
							<option value="" ${pageMaker.cri.type==null?"selected":"" }>
								--
							</option>
							<option value="N" ${pageMaker.cri.type eq "N"?"selected":"" }>
								쿠폰명
							</option>
							<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
								내용
							</option>
							<option value="M" ${pageMaker.cri.type eq "M"?"selected":"" }>
								할인금
							</option>
						</select> 
						<input type="text" name="keyword" />
						<button>검색</button>
					</form>
				</div>
				<div align="right">
					<a href="../coupon/list">
						<button id="list" style="color: green;">
							회원 보유 쿠폰 보기
						</button>
					</a>
					<a href="../coupon/addCoupon">
						<button id="addEvent" style="color: green;">
							쿠폰 추가
						</button>
					</a>
					<a href="../coupon/addUser">
						<button id="addUser" style="color: green;">
							회원 쿠폰 부여
						</button>
					</a>
					<a href="../coupon/addGrade">
						<button id="addGrade" style="color: green;">
							등급 쿠폰 부여
						</button>
					</a>
				</div>
			</div>
			<table id="dataTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>쿠폰번호</th>
						<th>쿠폰명</th>
						<th>쿠폰 할인치</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="coupon" items="${list}">
						<tr>
							<td>
								${coupon.cpnum}
							</td>
							<td>
								${coupon.cpName}
							</td>
							<td>
								<c:if test="${coupon.type == '%'}">
									${coupon.value}${coupon.type}
								</c:if>
								<c:if test="${coupon.type == '-'}">
									${coupon.type}${coupon.value}
								</c:if>
							</td>
							<%-- <td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${coupon.updateDate}" />
							</td> --%>
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
		
		<form id="actionForm" action="/admin/coupon/coupon" method="get">
                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                	<input type="hidden" name="type" value="${pageMaker.cri.type }">
                	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
        </form>
	</div>
	
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
	
</script>
<%@ include file="../../admin/includes/footer.jsp"%>