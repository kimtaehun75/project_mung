<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/mypagesidebar.jsp"%>
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
h3{
	text-align: left;
}
span{
	text-align: left;
}
</style>
<div class="order_wrap">
   <div class="order_tit">
      <h2>주문 조회</h2>
   </div>
</div>

<div class="container">
   <div class="card shadow mb-4">
	  <c:forEach items="${list}" var="order">
	  <div class="cart-body">
		<input class="form-control" value="주문번호 : ${order.orderno} / <fmt:formatDate pattern="yyyy-MM-dd" value="${order.orderDate}" />" onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != ''){this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '주문번호 : ${order.orderno} / <fmt:formatDate pattern="yyyy-MM-dd" value="${order.orderDate}" />';}else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '주문번호 : ${order.orderno} / <fmt:formatDate pattern="yyyy-MM-dd" value="${order.orderDate}" />';}" type="text"  readonly="readonly" style="text-align: center;"/> 
        <div style="display: none;">
			            <!-- 이름 -->
			            <div class="form-group">
			               <label for="">주문하신 분</label> 
			               <input type="text" class="form-control" value="${order.userName}" readonly="readonly">
			            </div>
			            <!-- 주소 -->
			            <div class="form-group">
			            	<label for="">주소</label> 
			               <input class="form-control" style="width: 40%; " type="text"
			                  readonly="readonly" value="${order.addr_1}">
			            </div>
			            <div class="form-group">
			               <input class="form-control" style="top: 5px;" value="${order.addr_2}" type="text" readonly="readonly" />
			            </div>
			            <div class="form-group">
			               <input class="form-control" value="${order.addr_3 }" type="text" readonly="readonly"/>
			            </div>
			            <!-- 휴대전화 -->
			            <div class="form-group">
			               <label for="">휴대폰 번호</label> 
			               <input type="text" class="form-control" value="${order.phone}" readonly="readonly">
			            </div>            
			            <!-- 이메일 -->
			            <div class="form-group">
			               <label for="">이메일</label> 
			               <input type="text" class="form-control" value="${order.email}" readonly="readonly">
			            </div>
                  		
                      <section class="ftco-section ftco-cart">
					         <h3 style="text-align:center;">사진을 누르면 해당 상품 후기로 이동합니다.</h3>
					         <div class="container">
					            <div class="row">
					             <div class="col-md-12 ftco-animate">
					                <div class="cart-list">
					                   <table class="table">
					                      <thead class="thead-primary">
					                        <tr class="text-center">
					                          <th></th>
					                          <th>상품 이름</th>
					                          <th>가격</th>
					                          <th>수량</th>
					                          <th>총 가격</th>
					                        </tr>
					                      </thead>
					                      <tbody id="tbody">
					                         <c:forEach items="${order.orderList }" var="product">
					                         <tr class="text-center">
						                             <td class="image-prod">
						                                <a href="/mypage/reviewReg?saleno=${product.saleno }">
						                                 	<img style="display:block;" class='img-fluid' width='200' height='200' alt='Colorlib Template' src='http://localhost:8090/resources/images/${product.attachImage.imagePath}/${product.attachImage.uuid}_${product.attachImage.fileName}'>
														</a> 
						                             </td>
					                                 <td class="product-name">
					                                    <h3 style="text-align:center;">
					                                    ${product.saleName}
					                                    </h3>
					                                 </td>
					                                 <td class="price">
					                                 	￦<fmt:formatNumber value="${product.cost }" pattern="###,####,###"/>
					                                 </td>
					                                 <td class="quantity">
					                                    <div class="input-group mb-3">
					                                       <input type="text" name="quantity" 
					                                       class="quantity form-control input-number" 
					                                       value="${product.amount }"
					                                       readonly>
					                                    </div>
					                                 </td>
					                                 <td class="total">
					                                    ￦<fmt:formatNumber value="${product.costSum }" pattern="###,####,###"/>
					                                 </td>
					                         </tr>
					                         </c:forEach>
					                      </tbody>
					                    </table>
					                 </div>
					             </div>
					          </div>
					          <div class="row justify-content-end">
					             <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
					                <div class="cart-total mb-3">
					                   <h3>쿠폰</h3>
					                   <p id="couponP">
					                   	<c:if test="${order.cpName != null }">
					                   		${order.cpName}
					                   	</c:if>
					                   	<c:if test="${order.cpName == null }">
					                   		사용한 쿠폰 없음
					                   	</c:if>
					                   </p>
					                </div>
					             </div>
					             <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
					                <div class="cart-total mb-3">
					                   <h3>총 합계</h3>
					                   <p class="d-flex" id="allCost">
						                   <span>합계</span>
						                   <span>￦<fmt:formatNumber value="${order.allCost }" pattern="###,####,###"/></span>
					                   </p>
					                   <p class="d-flex" id="disCost">
					                      <span>할인</span>
					                      <span>￦<fmt:formatNumber value="${order.disCost }" pattern="###,####,###"/></span>
					                   </p>
					                   <hr>
					                   <p class="d-flex total-price" id="saleCost">
					                      <span>최종 합계</span>
					                      <span>￦<fmt:formatNumber value="${order.finalCost }" pattern="###,####,###"/></span>
					                   </p>
					                </div>
					             </div>
					          </div>
					         </div>
     			 </section>
               </div>
               </div>
               </c:forEach>
      		</div>         
   <div>
      <div class="col-lg-12">
           
      </div>
   </div>
   <!-- 다른 페이지들 -->
      <!--  <div class="row mt-5">
         <div class="col text-center">
            <div class="block-27">
               <ul>
                  <c:if test="${pageMaker.prev}">
                     <li class="page-item"><a href="${pageMaker.startPage - 1}">&lt;</a></li>
                  </c:if>
                  <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
                     <li class="page-item" ${pageMaker.cri.pageNum==num?"active":"" }><a href="${num }">${num}</a></li>
                  </c:forEach>
                  <c:if test="${pageMaker.next}">
                     <li class="page-item"><a href="${pageMaker.startPage + 10}">&gt;</a></li>
                  </c:if>
               </ul>
            </div>
         </div>
      </div>-->
<!-- 다른 페이지들 끝 -->
</div>
   <form id="actionForm" action="/mypage/order" method="get">
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