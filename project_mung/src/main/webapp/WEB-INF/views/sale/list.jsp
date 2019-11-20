<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
      <h2>애견 상품</h2>
   </div>
</div>

<div style="div .container{text-align: center;}">
<div class="container">
<section class="ftco-section">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-md-10 mb-5 text-center">
         <form id="searchForm" action="/sale/list" method="get">
            <input type="hidden" name="type" value="SC">
            <input id='input_text_search' type="text" name="keyword" placeholder="상품명/카테고리를 검색해주세요"
                  onblur="this.style.width='0px';
               this.style.paddingLeft='0px';"
                  style="border: 0; background-color: rgba(0, 0, 0, 0); color: #000000; border-bottom: solid 2px #E8DB5F; outline: none;width: 0px; transition: all 0.5s;">
                  <img id='image_search'
                  src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png"
                  style="width: 30px; height: 35px; margin-right: 5px; border:1;'"
                  onclick="var inputBox = document.getElementById('input_text_search');
                 inputBox.style.width = '800px';
                 inputBox.style.paddingLeft='3px';
                 inputBox.value='';
                 inputBox.focus();">
         </form>
            <ul class="product-category">
               <c:forEach items="${menu}" var="cate">
                  <li><a href="/sale/list?cateno=${cate.cateno}">${cate.cateName }</a></li>
               </c:forEach>
            </ul>
         </div>
      </div>
      <form id="actionForm" action="/sale/list" method="get">
         <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
         <input type="hidden" name="type" value="${pageMaker.cri.type }">
         <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
         <input type="hidden" name="cateno" value="${pageMaker.cri.cateno }">
      </form>
      <div class="row">
      <c:forEach items="${list}" var="sale" varStatus="i">
         <c:set var="checkList" value="${checkList+1 }"/>
         <div class="col-md-6 col-lg-3 ftco-animate">
            <div class="product">
               <a href="/sale/detail?saleno=${sale.saleno }" class="img-prod">
                  <img class="img-fluid"  
                  alt="Colorlib Template"
                  src="http://localhost:8090/resources/images/${sale.attachImage.imagePath}/${sale.attachImage.uuid}_${sale.attachImage.fileName}">
                  <div class="overlay"></div>
               </a>
               <div class="text py-3 pb-4 px-3 text-center">
                  <h3>
                     <a href="/sale/detail?saleno=${sale.saleno }">${sale.saleName}</a>
                  </h3>
                  <div class="d-flex">
                     <div class="pricing">
                        <p class="price">
                           <span>${sale.cost }</span>
                        </p>
                     </div>
                  </div>
                  <div class="bottom-area d-flex px-3">
                     <div class="m-auto d-flex" >
                        <sec:authorize access="isAuthenticated()">
                           <c:if test="${sale.amount > 0 }">
	                           <a href="${sale.saleno}" id="cartBtn${i.index}" class="buy-now d-flex justify-content-center align-items-center mx-1"
	                           style="color:white;">
		                              <span>
		                                 <i class="ion-ios-cart"></i>
		                              </span>
	                           </a>
                           </c:if>
                           <script>
                           $(document).ready(function(){
                              var saleno = '${sale.saleno}';
                              var cartBtn = $("#cartBtn${i.index}");
                              
                              cartService.checkCart({
                                  saleno:saleno
                               },function(result){
                                  console.log(result);
                                  if(result == '1'){
                                    cartBtn.css('color','orange');
                                  }
                              });
                              
                              var csrfHeaderName = "${_csrf.headerName}";
                              var csrfTokenValue = "${_csrf.token}";
                              
                              $(document).ajaxSend(function(e,xhr,options){
                                   xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
                                });
                              
                              cartBtn.on("click",function(e){
                                 e.preventDefault();
                                 
                                 var saleno = $(this).attr("href");
                                  var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                                 var amount = 1;
                                 
                                 var cart = {
                                    saleno : saleno,
                                     userid : userid,
                                    amount : amount
                                 };
                                 
                                 cartService.checkCart({
                                     saleno:saleno
                                  },function(result){
                                     console.log(result);
                                     if(result == '1'){
                                        cartService.removeCart(saleno,userid,function(result){
                                              console.log(result);
                                              alert('장바구니에서 삭제하였습니다.');
                                              cartBtn.css('color','white');
                                              
                                              cartService.cartCount(function(count){
                                                    $("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
                                                });
                                        });
                                     }else{
                                        cartService.insertMainCart(cart,function(result){
                                            if(result === 'success'){
                                               console.log(result);
                                               alert('장바구니에 추가하였습니다');
                                               cartBtn.css('color','orange');
                                            }
                                               cartService.cartCount(function(count){
                                                  $("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
                                              });
                                        });
                                     }
                                 });
                                 
                              });
                           });
                           </script> 
	                           <a href="${sale.saleno}" id="goodBtn${i.index}" class="heart d-flex justify-content-center align-items-center ">
		                              <span>
		                                 <i class="ion-ios-heart"></i>
		                              </span>
	                           </a>
                           <script>
                           $(document).ready(function(){
                              var saleno = '${sale.saleno}';
                              var goodBtn = $("#goodBtn${i.index}");
                              
                              goodService.checkGood({
                                  saleno:saleno
                               },function(result){
                                  console.log(result);
                                  if(result == '1'){
                                    goodBtn.css('color','red');
                                  }
                              });
                              
                              var csrfHeaderName = "${_csrf.headerName}";
                              var csrfTokenValue = "${_csrf.token}";
                              
                              $(document).ajaxSend(function(e,xhr,options){
                                   xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
                                });
                              
                              goodBtn.on("click",function(e){
                                 e.preventDefault();
                                 
                                 var saleno = $(this).attr("href");
                                  var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                                 
                                 
                                 var good = {
                                    saleno : saleno,
                                     userid : userid
                                 };
                                 
                                 goodService.checkGood({
                                     saleno:saleno
                                  },function(result){
                                     console.log(result);
                                     if(result == '1'){
                                        goodService.removeGood(saleno,userid,function(result){
                                              console.log(result);
                                              alert('좋아요를 취소했습니다.');
                                              goodBtn.css('color','white');
                                        });
                                     }else{
                                        goodService.insertGood(good,function(result){
                                            if(result === 'success'){
                                               console.log(result);
                                               alert('좋아요를 눌르셨습니다.');
                                               goodBtn.css('color','red');
                                            }
                                        });
                                     }
                                 });
                              });
                           });
                           </script> 
                        </sec:authorize>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </c:forEach>
      <c:if test="${checkList == null}">
         <span style="margin:auto;">등록된 상품이 없습니다.</span>
      </c:if>
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
</section>
</div>
</div>
<script>
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

<%@ include file="../includes/footer.jsp"%>