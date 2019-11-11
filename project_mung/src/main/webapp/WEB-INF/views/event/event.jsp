<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
      <h2>이벤트</h2>
   </div>
</div>
<div style="div .container{text-align: center;}">
<div class="container">
<section class="ftco-section ftco-degree-bg">   
       <ul class="product-category" style="float:right;">
			<li><a href="/event/event?time=S">진행중인 이벤트</a></li>
			<li><a href="/event/event?time=E">종료된 이벤트</a></li>
       </ul>
      <div class="col-md-12 d-flex ftco-animate">
         <table id="eventTable" width="100%" cellspacing="10px;">
            <tbody>
            <c:forEach items="${list}" var="event" varStatus="i">
               <c:set var="checkList" value="${checkList+1 }"/>
               <tr>
                  <td style="width: 5%;">
                     <c:if test="${event.bno eq event.attachImage.bno }">
                        <a href="/eventDetail?bno=${event.bno }">
                           <img width=250px height=200px
                              src="http://localhost:8090/resources/images/${event.attachImage.imagePath}/${event.attachImage.uuid}_${event.attachImage.fileName}">
                           <br>
                        </a>
                     </c:if>
                  </td>
                  <td style="width:40%;"> 
                  <fmt:formatDate pattern="yyyy-MM-dd" value="${event.updateDate}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${event.endDate}" /> <br>
                  <h3 class="heading">
                  ${event.title }
                   </h3><br>
                   <div>
                  <p> ${event.sub}</p>
                   </div>
                  	<a href="/event/detail?bno=${event.bno }" class="btn btn-primary py-2 px-3" >이벤트 이동하기</a>
                  </td>
               </tr>
            </c:forEach>
            </tbody>
            <tfoot>
               <tr>
                  <td>
                     <c:if test="${checkList == null}">
                        진행 중인 이벤트가 없습니다.
                     </c:if>
                  </td>
               </tr>
            </tfoot>
         </table>
      </div>
   
</section>
</div>
</div>
<!-- 다른 페이지들 -->
      <div class="row mt-5">
         <div class="col text-center">
            <div class="block-27">
            <form id="searchForm" action="/event/event" method="get">
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
   <form id="actionForm" action="/event/event" method="get">
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
<!-- .section -->
<%@ include file="../includes/footer.jsp"%>