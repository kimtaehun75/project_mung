<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<style>

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
      <h2>자주 하는 질문</h2>
   </div>
</div>

<div class="container">
	<div class="card shadow mb-4" style="float:center;">
		<div class="card-body">
			<div class="table-responsive">
				<div>
					<form id="searchForm" action="/service/faq" method="get">&nbsp;&nbsp;&nbsp;
		        		<select name="type">
							<option value="" ${pageMaker.cri.type == null?"selected":"" }>--</option>
		                	<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>질문</option>
		                </select>
		                	<input type="text" name="keyword">
			                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			                <button class="btn btn-warning">Search</button>
					</form>	 
				</div>
				<br>				
				<table class="table table-bordered" id="dataTable" style="width:100%; cellspacing:0;">						
					<thead>
						<tr>
						<th align="center">F A Q</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="faq" items="${faq}">
						<tr align="center">					
							<td>
								<input class="form-control" value="${faq.title}" onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != ''){this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '${faq.title }';}else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '${faq.title}';}" type="text" 
						readonly="readonly" style="text-align:center;" /> 
						<div style="display: none;"><p>${faq.content }</p></div>
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
	<form id="actionForm" action="/service/faq" method="get">
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



<%@ include file="../includes/footer.jsp" %>