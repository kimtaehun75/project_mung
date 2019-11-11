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
.skydiv{
	display:none;
}
</style>
<div class="order_wrap">
   <div class="order_tit">
      <h2>분양후기</h2>
   </div>
</div>
		<div style="float:right; display:block;">
			<a id="adoptRegister" href="./adoptAfterReg" style="text-decoration: none; color:white; margin-bottom:15px;">
				<button class="btn btn-primary px-3" id="">
					<i class="fa fa-heart pr-2" aria-hidden="true">
					
					</i>분양 후기 작성하기
				</button>
			</a>
		</div>
<div class="row">
      <c:forEach items="${after}" var="after" varStatus="i">
	      <c:set var="checkList" value="${checkList+1 }" />
	      <div class="col-md-6 col-lg-3 ftco-animate">
	         <div class="product">
	            <!-- 강아지 사진 -->
	            <a href="./adoptAfterInfo?bno=${after.bno}" class="img-prod">
	               <img class="img-fluid" style="margin:auto; heigth:200px;"
	               src="http://localhost:8090/resources/images/${after.attachImage.imagePath}/${after.attachImage.uuid}_${after.attachImage.fileName}">
	               <div class="overlay"></div>
	            </a>
	            <!--=============-->
	            <div class="text py-3 pb-4 px-3 text-center">
	               <!-- 강아지이름 -->
	               <h3>
	                  <a href="./adoptAfterInfo?bno=${after.bno}">${after.title }</a>
	               </h3>
	               <!--============-->
				</div>
			</div>
		</div>
		</c:forEach>
</div>    
	  
   <c:if test="${checkList == null}">
      <span style="margin: auto;">작성된 분양후기가 없어요 :(</span>
   </c:if>
	<form id="actionForm" action="/adopt/adoptAfter" method="get">
         <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
         <input type="hidden" name="type" value="${pageMaker.cri.type }">
         <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
      </form>
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
<script>
	$(document).ready(function(){
		var register = $("#adoptRegister");
		
			register.on("click",function(e){
				e.preventDefault();
				
				var userid =  '<c:out value="${pageContext.request.userPrincipal.name}"/>';
				if(userid == ''){
					alert("분양한 사용자만 이용이 가능합니다.");
           		 	return;
				}else{
				 	profileService.getProfile(function(profile) {
	               	
	            	 if(profile.adopt == 1){
	            		 location.href="./adoptAfterReg";
	            	 }else{
	            		 alert("분양한 사용자만 이용이 가능합니다.");
	            		 return;
	            	 }
	            	 
	           		});
				}
	    });
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>