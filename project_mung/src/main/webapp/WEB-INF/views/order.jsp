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
	      <h2 style="padding-top:50px;">주문 신청</h2>
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
		         <li class="page_on">
		         	<span class="dot">
		         		02
		         	</span>
		         		주문서작성/결제
		         	<span>
		         		<img src="/resources/images/icon_join_step.gif" alt="">&nbsp;&nbsp;&nbsp;&nbsp;
		         	</span>
		         </li>
		         <li><span class="dot">03</span>주문완료</li>
		      </ol>
	   </div>
	</div>
      <div class="card-body">
   <form method="POST" action="/order" role="form">
            <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}">
            <input type="hidden" name="userid" value="${userid}">
            <!-- 이름 -->
            <div class="form-group">
            	<input id="write" type="checkbox" checked>직접 입력&nbsp;
            	<input id="call" type="checkbox">주문자 정보 불러오기
            </div>
            <div class="form-group">
               <label for="">주문하신 분</label> 
               <input type="text" class="form-control" id="username" 
                     name="userName" placeholder="이름" required>
            </div>
            <!-- 주소 -->
            <div class="form-group">
           		<label style="display:block;" for="">주소</label> 
				<input class="form-control" style="width:40%; display:inline-block;" placeholder="우편번호" name="addr_1" id="addr1" type="text"
                  readonly="readonly">
				<button type="button" class="btn btn-default" onclick="execPostCode();">
					<i class="fa fa-search"></i> 우편번호 찾기
				</button>
            </div>
            <div class="form-group">
               <input class="form-control" style="top: 5px;" placeholder="도로명 주소"
                  name="addr_2" id="addr2" type="text" readonly="readonly" />
            </div>
            <div class="form-group">
               <input class="form-control" placeholder="상세주소" name="addr_3"
                  id="addr3" type="text" />
            </div>
            <!-- 휴대전화 -->
            <div class="form-group">
               <label for="">휴대폰 번호</label> <input
                  type="text" class="form-control" id="phone" name="phone"
                  placeholder="휴대폰 번호" required>
               <div class="check_font" id="phone_check"></div>
            </div>            
            <!-- 이메일 -->
            <div class="form-group">
               <label for="">이메일</label> <input type="text"
                  class="form-control" name="email" id="email" placeholder="이메일"
                  required>
            </div>
            <input name="cpnum" id="cpnum" type="hidden">
	</form>
            <section class="ftco-section ftco-cart">
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
                        <p>
                           <button id="couponBtn" class="btn btn-primary py-3 px-4">쿠폰
                              적용하기</button>
                        </p>
                     </div>
                     <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                        <div class="cart-total mb-3">
                           <h3>총 합계</h3>
                           <p class="d-flex" id="allCost"></p>
                           <p class="d-flex" id="disCost"></p>
                           <hr>
                           <p class="d-flex total-price" id="saleCost"></p>
                        </div>
                        <p>
							<button class="btn btn-default px-3" onclick="javascript:history.go(-1);"> 
								<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>뒤로가기
							</button>
							<button class="btn btn-primary py-3 px-4" id="payment">결제하기</button>
                        </p>
                     </div>
                  </div>
               </div>
            </section>
      </div>
   </div>
</div>



<!--====================================================SCRIPT==============================================================-->
<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=addr_1]").val(data.zonecode);
           $("[name=addr_2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
</script>

<script>
   $(document)
         .ready(
               function() {
            	  var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                  var tbody = $('#tbody');
                  var couponList = $('#couponList');
                  var couponBtn = $('#couponBtn');
                  var cpnum = $("#couponList option:selected").val();

                  showCart();
                  showCost();
                  showSale();
                  showCouponList();

                  function showCart() {
                     cartService
                           .getCartList(
                                 {
                                    userid : userid
                                 },
                                 function(list) {
                                    console.log("list : " + list);

                                    var str = "";
                                    if (list == null
                                          || list.length == 0) {
                                       tbody.html("");
                                       return;
                                    }

                                    for (var i = 0, len = list.length || 0; i < len; i++) {
                                       str += '<tr class="text-center">';
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

                  function showCost() {
                     var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';

                     cartService.getCartCost({
                        userid : userid
                     }, function(cost) {
                        console.log("cost : " + cost);

                        $('#allCost').html(
                              '<span>합계</span><span>' + cost.cost
                                    + '</span>');

                     });
                  }//showCost   

                  function showSale() {
                     var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                     var cpnum = $("#couponList option:selected").val();

                     if (cpnum == "") {
                        cpnum = 0;
                     }

                     cartService.getSaleCost({
                        userid : userid,
                        cpnum : cpnum
                     }, function(result) {
                        $("#disCost").html(
                              '<span>할인</span><span>'
                                    + result.disCost + '</span>')
                        $("#saleCost").html(
                              '<span>결제금액</span><span>'
                                    + result.saleCost + '</span>')
                     });
                  }

                  function showCouponList() {
                     var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';

                     cartService
                           .getCouponList(
                                 {
                                    userid : userid
                                 },
                                 function(list) {
                                    console.log("coupon : " + list);

                                    var str = '';

                                    if (list == null
                                          || list.length == 0) {
                                    	couponList.remove();
                                    	couponBtn.remove();
                                    	$("#couponP").remove();
            							$("#couponLabel").text("소지 쿠폰 없음");
            							return;
                                    }

                                    str += '<option value="">쿠폰 사용 안함</option>'

                                    for (var i = 0, len = list.length || 0; i < len; i++) {
                                       str += '<option value="';
                        str += list[i].cpnum;
                        str += '">';
                                       str += list[i].cpName;
                                       str += '</option>';
                                    }

                                    couponList.html(str);
                                 });
                  }

                  tbody
                        .on(
                              "click",
                              'a',
                              function(e) {
                                 e.preventDefault();
                                 // 기본 이벤트 동작을 막고,
                                 var csrfHeaderName = "${_csrf.headerName}";
                                 var csrfTokenValue = "${_csrf.token}";

                                 $(document)
                                       .ajaxSend(
                                             function(e, xhr,
                                                   options) {
                                                xhr
                                                      .setRequestHeader(
                                                            csrfHeaderName,
                                                            csrfTokenValue);
                                             });
                                 console.log("click");
                                 // 웹 브라우저 검사 창에 클릭을 표시
                                 var saleno = $('.product-remove a')
                                       .attr("href");
                                 console.log(saleno);
                                 var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                                 console.log(userid);
                                 cartService
                                       .removeCart(
                                             saleno,
                                             userid,
                                             function(result) {
                                                console
                                                      .log("result : "
                                                            + result);
                                                showCart();
                                                showCost();
                                                showSale();
                                                cartService
                                                      .cartCount(function(
                                                            count) {
                                                         $(
                                                               "#cartIcon")
                                                               .html(
                                                                     '<span class="icon-shopping_cart"></span>'
                                                                           + "["
                                                                           + count
                                                                           + "]");
                                                      });
                                             });
                              });

                  couponBtn
                        .on(
                              "click",
                              function(e) {
                                 e.preventDefault();
                                 var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
                                 var cpnum = $(
                                       "#couponList option:selected")
                                       .val();

                                 if (cpnum == "") {
                                    cpnum = 0;
                                 }

                                 cartService
                                       .getSaleCost(
                                             {
                                                userid : userid,
                                                cpnum : cpnum
                                             },
                                             function(result) {
                                                $("#disCost")
                                                      .html(
                                                            '<span>할인</span><span>'
                                                                  + result.disCost
                                                                  + '</span>')
                                                $("#saleCost")
                                                      .html(
                                                            '<span>결제금액</span><span>'
                                                                  + result.saleCost
                                                                  + '</span>')
                                             });

                 });
                  
                 
                 $("input[id='write']").on("click",function(e){
                	 $("input:checkbox[id='call']").prop("checked", false);

                	 $("input[id='username']").val("");
                	 $("input[id='addr1']").val("");
                	 $("input[id='addr2']").val("");
                	 $("input[id='addr3']").val("");
                	 $("input[id='email']").val("");
                	 $("input[id='phone']").val("");
                	 
                	 $(this).prop("checked",true);
                 })
                 
                 $("input[id='call']").on("click",function(){
                	 $("input:checkbox[id='write']").prop("checked", false);
                	 
                	 profileService
	                 .getProfile(function(profile) {
	                	 $("input[id='username']").val(profile.userName);
	                	 $("input[id='addr1']").val(profile.addr_1);
	                	 $("input[id='addr2']").val(profile.addr_2);
	                	 $("input[id='addr3']").val(profile.addr_3);
	                	 $("input[id='email']").val(profile.email);
	                	 $("input[id='phone']").val(profile.phone);
	                 });
	                 
                	 $(this).prop("checked",true);
                 });
				
                 $("button[id='payment']").on("click",function(e){
                	e.preventDefault();
                	 
                	var form = $("form[role='form']");
                	var cpnum = $("#couponList option:selected").val();
                	
                	if(cpnum != null && cpnum != ""){
                		form.find("input[id='cpnum']").val(cpnum);
                	}else{
                		$("input[id='cpnum']").attr("disabled",true);
                	}
                	
                	form.submit();
                 });
});
</script>
<%@ include file="includes/footer.jsp"%>