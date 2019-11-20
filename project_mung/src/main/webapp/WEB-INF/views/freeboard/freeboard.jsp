<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>

<style>
/* ---------------------------------------  

   장바구니 - order/cart.php

--------------------------------------- */
.order_wrap .order_tit {
   border: none;
   margin-bottom: 0;
   padding-bottom: 18px;
}

.order_wrap .order_tit h2 {
   float: none;
   width: 100%;
   text-align: center;
   margin: 0;
   font-size: 40px;
   line-height: 1.1;
   text-transform: uppercase;
   font-weight: 600;
   padding: 6px 0 52px;
   position: relative;
   letter-spacing: 0;
   color: #000000;
   position: relative;
   border-bottom: 2px solid #000;
}

.order_wrap .order_tit ol {
   float: right;
   line-height: 22px;
   height: 26px;
   margin-top: 60px;
}

.order_wrap .order_tit ol li {
   float: left;
   font-size: 17px;
   font-weight: 200;
   color: #9e9e9e;
}

.order_wrap .order_tit .page_on {
   color: #333333;
   font-weight: 500;
}

.order_wrap .order_tit li span {
   font-size: 16px;
   font-weight: bold;
   display: inline-block;
   vertical-align: top;
}

.order_wrap .order_tit li span.dot {
   width: 25px;
   height: 25px;
   border-radius: 100%;
   line-height: 22px;
   text-align: center;
   font-size: 14px;
   font-weight: 500;
   color: #fff;
   background: #bebebe;
}

.order_wrap .order_tit li.page_on span.dot {
   background: #ffc71d;
}

.order_wrap .order_tit li span>img {
   padding: 0 14px;
   vertical-align: -1px;
}

.order_wrap .cart_cont .no_data {
   padding: 60px 0;
   margin: 0 0 20px 0;
   text-align: center;
   border-bottom: 1px solid #dbdbdb;
   color: #444;
}

.cart_cont_list .order_cart_tit h3 {
   font-weight: 400;
   padding-top: 40px;
}

.cart_cont_list .order_cart_tit1 h3 {
   padding-top: 0;
}

.body-order .order_table_type font {
   display: inline-block;
   vertical-align: top;
   font-size: 14px;
   line-height: 24px;
   height: 24px;
   padding: 0 8px 0 21px;
   letter-spacing: -1px;
}

.body-order .order_table_type .icn_red {
   border: 1px solid #f44a4b;
   color: #f44a4b;
   background: url(../img/dimg/icn_red.png) no-repeat 6px center
}

.body-order .order_table_type .icn_blue {
   border: 1px solid #0380ff;
   color: #0380ff;
   padding: 0 8px;
}

.body-order .order_table_type .icn_orange {
   border: 1px solid #ffc71d;
   color: #333;
   padding: 0 8px;
}
</style>
<div class="order_wrap">
   <div class="order_tit">
      <h2>게 시 판</h2>
   </div>
</div>

<div class="container">
	<div class="card shadow mb-4" style="float:center;">
		<div class="card-body">
			<div class="table-responsive">
				<div>
					<form id="searchForm" action="/freeboard/freeboard" method="get">&nbsp;&nbsp;&nbsp;
		        		<select name="type">
							<option value="" ${pageMaker.cri.type == null?"selected":"" }>--</option>
		                	<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>제목</option>
		                	<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>내용</option>
		                	<option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>작성자</option>
		                	<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>제목+내용</option>
		                	<option value="TW" ${pageMaker.cri.type eq "TW"?"selected":"" }>제목+작성자</option>
		                	<option value="CW" ${pageMaker.cri.type eq "CW"?"selected":"" }>내용+작성자</option>
		                	<option value="TCW" ${pageMaker.cri.type eq "TCW"?"selected":"" }>제목+내용+작성자</option>
		                </select>
		                	<input type="text" name="keyword">
			                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			                <button class="btn btn-warning">Search</button>
					</form>	 
					<a href="./register" style="text-decoration: none; color:white; float:right; margin-bottom:15px; display:inline-block;">
						<button class="btn btn-primary px-3" id="">
							<i class="fa fa-heart pr-2" aria-hidden="true"></i>
								글쓰기
						</button>
					</a>
				</div>
				<br>				
				<table class="table table-bordered" id="dataTable" style="width:100%; cellspacing:0;">						
					<tr>
						<th style="width:15%;" colspan="2">
							작성자
						</th>
						<th style="width:50%;">
							제목
						</th>
						<th style="width:20%;">
							날짜
						</th>
						<th style="width:15%;">
							조회수
						</th>
					</tr>					
					<tbody>
					<c:forEach var="free" items="${free}">
						<tr>					
							<td>
								<c:if test="${free.tear == '브론즈'}">
									<img src="/resources/images/브론즈.png" height=30 width=30>
								</c:if>
								<c:if test="${free.tear == '실버'}">
									<img src="/resources/images/실버.png" height=30 width=30>
								</c:if>
								<c:if test="${free.tear == '골드'}">
									<img src="/resources/images/골드.png" height=30 width=30>
								</c:if>
								<c:if test="${free.tear == '플래티넘'}">
									<img src="/resources/images/플래티넘.png" height=30 width=30>
								</c:if>
								<c:if test="${free.tear == '다이아몬드'}">
									<img src="/resources/images/다이아.png" height=30 width=30>
								</c:if>
								<c:if test="${free.tear == '마스터'}">
									<img src="/resources/images/마스터.png" height=30 width=30>
								</c:if>
							</td>
							<td>
								<c:if test="${free.auth == 'ROLE_MEMBER' }">
									${free.userid }
								</c:if>
								<c:if test="${free.auth == 'ROLE_ADMIN' }">
									관리자
								</c:if>
							</td>
							<td>						
								<a href="./info?bno=${free.bno}" class="">${free.title}</a>							
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${free.updateDate}" />
							</td>
							<td>
								${free.views}
							</td>						
						</tr>
					</c:forEach>
				</tbody>							
				</table>
			</div>
			
		</div>
	</div>
	
	<div>
		<div class="col-lg-12">
        	
		</div>
	</div>
	<!-- 다른 페이지들 -->
      <div class="row mt-5">
         <div class="col text-center">
            <div class="block-27">
               <ul>
                  <c:if test="${pageMaker.prev}">
                     <li class="page-item"><a href="${pageMaker.startPage - 1}">&lt;</a></li>
                  </c:if>
                  <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                     <li class="page-item" ${pageMaker.cri.pageNum==num?"active":"" }><a href="${num }">${num}</a></li>
                  </c:forEach>
                  <c:if test="${pageMaker.next}">
                     <li class="page-item"><a href="${pageMaker.startPage + 10}">&gt;</a></li>
                  </c:if>
               </ul>
            </div>
         </div>
      </div>
<!-- 다른 페이지들 끝 -->
</div>
	<form id="actionForm" action="/freeboard/freeboard" method="get">
    	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
        <input type="hidden" name="type" value="${pageMaker.cri.type }">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
    </form>
<script>
	var actionForm = $("#actionForm");
		
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
<script>
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력해주세요");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val(1);
		e.preventDefault();
		searchForm.submit();
	});
</script>
<%@ include file="../includes/footer.jsp"%>