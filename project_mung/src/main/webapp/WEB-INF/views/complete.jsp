<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>
<script
   src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
</script>
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


<div class="container">
   <div class="card shadow mb-4">
      <div class="order_wrap">
      <div class="order_tit">
         <h2 style="padding-top:50px;">주문이 완료되었습니다</h2>
            <ol style="margin:30px 40% 0px 0px; list-style:none;">
               <li>
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
               <li class="page_on"><span class="dot">03</span>주문완료</li>
            </ol>
      </div>
   </div>
      <div class="col-md-12 d-flex ftco-animate">
			<table id="eventTable" width="100%">
				<tbody>
					<tr>
						<td>
							<img src="/resources/images/주문완료.png" > 
						</td>
						<td> 
					    	<form method="" action="" role="">
							  	<!-- 주문번호 -->
							  <div class="form-group">
							   	  <label for="">주문번호</label>
							   	  <h1 style="font-family:Black Hans Sans; font-size:30pt;">${orderno}</h1>	    
							  </div>	   
							</form>				   
						</td>
					</tr>
					<tr>
						<td>
							<div class="reg_button">
								<a class="btn btn-primary px-3"
								href="/"> 
									<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>쇼핑 계속하기
								</a>&emsp;&emsp;	
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
   </div>
</div>
<%@ include file="includes/footer.jsp"%>