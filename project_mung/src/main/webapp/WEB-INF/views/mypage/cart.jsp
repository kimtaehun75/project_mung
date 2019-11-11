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
      <h2>장바구니</h2>
	      <ol style="margin:30px 40% 0px 0px; list-style:none;">
	         <li class="page_on">
	         	<span class="dot">
	         		01
	         	</span>
	         		장바구니
	         	<span>
	         		<img src="/resources/images/icon_join_step.gif" alt="" style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;
	         	</span>
	         </li>
	         <li>
	         	<span class="dot">
	         		02
	         	</span>
	         		주문서작성/결제
	         	<span>
	         		<img src="/resources/images/icon_join_step.gif" alt="">&nbsp;&nbsp;&nbsp;&nbsp;
	         	</span>
	         </li>
	         <li>
	         	<span class="dot">
	         		03
	         	</span>
	         		주문완료
	         	</li>
	      </ol>
   </div>
</div>

    <section class="ftco-section ftco-cart">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>&nbsp;</th>
						        <th>&nbsp;</th>
						        <th>상품 이름</th>
						        <th>가격</th>
						        <th>수량</th>
						        <th>총 가격</th>
						      </tr>
						    </thead>
						    <tbody id="tbody">
						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
    		<div class="row justify-content-end">
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>쿠폰</h3>
    					<p id="couponP">쿠폰을 선택하세요.</p>
  							<div class="form-group">
		              			<label id="couponLabel" for=""></label>
			               			<select id="couponList">
			                	
			                		</select>
	              			</div>
    				</div>
    				<p><button id="couponBtn" class="btn btn-primary py-3 px-4">쿠폰 적용하기</button></p>
    			</div>
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>총 합계</h3>
    					<p class="d-flex" id="allCost">
    					
    					</p>
    					<p class="d-flex" id="disCost">
    						
    					</p>
    					<hr>
    					<p class="d-flex total-price" id="saleCost">
    						
    					</p>
    				</div>
    				<p>
	    				<a href="../order">
		    				<button id="orderBtn" class="btn btn-primary py-3 px-4">
		    					주문신청
		    				</button>
	    				</a>
    				</p>
    			</div>
    		</div>
			</div>
		</section>
		
	<script>
		$(document).ready(function(){
				var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
				var tbody = $('#tbody');
				var couponList = $('#couponList');
				var couponBtn = $('#couponBtn');
				var cpnum = $("#couponList option:selected").val();
				var orderBtn = $("#orderBtn");
				
				showCart();
				showCost();
				showSale();
				showCouponList();
				
				
				 function showCart(){
					cartService.getCartList({
						userid:userid
					},function(list){
						console.log("list : "+list);
						
						var str="";
						if(list==null || list.length == 0){
							tbody.html("");
							orderBtn.prop("disabled", true);
							return;
						}
						
						for(var i=0,len=list.length||0; i<len; i++){
							str += '<tr class="text-center">';
							str += '<td class="product-remove"><a href="';
							str += list[i].saleno;
							str += '"><span class="ion-ios-close"></span></a></td>';
							str += '<td class="image-prod">';
							str += "<img class='img-fluid' ";
							str += "width='200' height='200' ";
							str += 'alt="Colorlib Template "';
							str += "src='http://localhost:8090/resources/images/";
							str += list[i].attachImage.imagePath+"/";
							str += list[i].attachImage.uuid+'_';
							str += list[i].attachImage.fileName;
							str += "'>";
							str += '<td class="product-name">';
							str += '<h3>';
							str += list[i].saleName;
							str += '</h3>';
							str += '<td class="price">';
							str += list[i].cost;
							str += '</td>';
							str += '<td class="quantity">';
							str += '<div class="input-group mb-3">';
							str += '<input type="text" name="quantity" ';
							str += 'class="quantity form-control input-number"';
							str += 'value="'
							str += list[i].amount;
							str += '" readonly>';
							str += "</div>";
							str += '</td>';
							str += '<td class="total">';
							str += list[i].allCost;
							str += '</td>';
							str += '</tr>';
						}
						
						tbody.html(str);
					});
				}//showCart	
				
				function showCost(){
					var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
		
					cartService.getCartCost({
					userid:userid
					},function(cost){
						console.log("cost : "+cost);
						
						$('#allCost').html('<span>합계</span><span>'+cost.cost+'</span>');
						
					});
				}//showCost	
			
				function showSale(){
					var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
					var cpnum = $("#couponList option:selected").val();
					
					if(cpnum == ""){
						cpnum = 0;
					}
					
					cartService.getSaleCost({
						userid:userid,
						cpnum:cpnum
					},function(result){
						$("#disCost").html('<span>할인</span><span>'+result.disCost+'</span>')
						$("#saleCost").html('<span>결제금액</span><span>'+result.saleCost+'</span>')
					});
				}
				
				function showCouponList(){
					var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
					
					cartService.getCouponList({
						userid:userid
					},function(list){
						console.log("coupon : "+list);
						
						var str = '';
						
						if(list==null || list.length == 0){
							couponList.remove();
							couponBtn.remove();
							$("#couponP").remove();
							$("#couponLabel").text("소지 쿠폰 없음");
							return;
						}
							
							str += '<option value="">쿠폰 사용 안함</option>'
							
							for(var i=0,len=list.length||0; i<len; i++){
								str += '<option value="';
								str += list[i].cpnum;
								str += '">';
								str += list[i].cpName;
								str += '</option>';
							}
						
						couponList.html(str);
					});
				}
				
				tbody.on("click",'a',function(e) {
					e.preventDefault();
					// 기본 이벤트 동작을 막고,
					var csrfHeaderName = "${_csrf.headerName}";
					var csrfTokenValue = "${_csrf.token}";
					
					$(document).ajaxSend(function(e,xhr,options){
			    		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			    	});	
					console.log("click");
					// 웹 브라우저 검사 창에 클릭을 표시
					var saleno = $('.product-remove a').attr("href");
					console.log(saleno);
					var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
					console.log(userid);
					cartService.removeCart(saleno,userid,
					function(result){
						console.log("result : "+result);
						showCart();
						showSale();
						showCost();
						
						cartService.cartCount(function(count){
		    				 $("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
		    			});
					});
				});	
			
				couponBtn.on("click",function(e){
					e.preventDefault();
					var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
					var cpnum = $("#couponList option:selected").val();
					
					if(cpnum == ""){
						cpnum = 0;
					}
					
					cartService.getSaleCost({
						userid:userid,
						cpnum:cpnum
					},function(result){
						$("#disCost").html('<span>할인</span><span>'+result.disCost+'</span>')
						$("#saleCost").html('<span>결제금액</span><span>'+result.saleCost+'</span>')
					});
					
					
				});
		});
		
			
		
</script>		
		
		
		
<%@ include file="../includes/footer.jsp" %>    
 