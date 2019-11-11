<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<!-- Main -->
<%@ include file="../includes/mypagesidebar.jsp"%>
<div class="card shadow mb-4" style="float:center;">
   <div class="card-body">
      <div class="row">
   <div class="container">
      <div class="col-md-12 d-flex ftco-animate">
         <table id="" width="100%" cellspacing="10px;">
            <tr style="text-align:center;">
            	<td>
            		작성한 리뷰
            	</td>
            </tr>
            <tbody>
               <c:forEach items="${list }" var="review">
               <c:set var="checkList" value="${checkList+1 }"/>
               <tr>
                  <td>
                     <div class="about-author d-flex p-4 bg-light">
                          <div class="bio align-self-md-center mr-4">
                            <!-- 썸네일 -->
                            <a href="/sale/detail?saleno=${review.saleno }">
	                            <c:if test="${review.bno eq review.attachImage.bno }">
	                               <img src="http://localhost:8090/resources/images/${review.attachImage.imagePath}/${review.attachImage.uuid}_${review.attachImage.fileName}" width=141px height=141px class="img-fluid mb-4">
	                            </c:if>
                            </a>                     
                          </div>
                          <div class="desc align-self-md-center">
                            <!-- 제목 -->
                            <h3>${review.title}</h3>
                            <!-- 내용 -->
                            <p>${review.content}</p>
                         </div>
                        </div>
                  </td>
               </tr>
            </c:forEach>
            </tbody>
            <tfoot>
               <tr>
                  <td>
                     <c:if test="${checkList == null}">
                        작성된 리뷰가 없습니다.
                     </c:if>
                  </td>
               </tr>
            </tfoot>
         </table>
      </div>
   </div>
         </div>
         <!-- 리뷰작성 끝 -->       
          <!-- 페이징 -->
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
   </div>
</div>      
      
<!-- 다른 페이지들 끝 -->
   <form id="actionForm" action="/mypage/review" method="get">
       <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
        <input type="hidden" name="type" value="${pageMaker.cri.type }">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
        <input type="hidden" name="saleno" value="${saleno}"> 
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
    
<!-- jQuery -->
<script type="text/javascript"
   src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"
   type="text/javascript"></script>
<script>
   $("#adopt").on("click",function(param,callback) {
      var IMP = window.IMP; // 생략가능
      IMP.init('imp91385194');
      IMP.request_pay({
         pg : 'kakaopay', // version 1.1.0부터 지원.
         pay_method : 'card',
         merchant_uid : 'merchant_' + new Date().getTime(),
         name : '주문명:결제테스트',
         amount : 22000,
         buyer_email : 'iamport@siot.do',
         buyer_name : '구매자이름',
         buyer_tel : '010-1234-5678',
         buyer_addr : '서울특별시 강남구 삼성동',
         buyer_postcode : '123-456',
      }, function(rsp) {
         if (rsp.success) {
               var msg = '결제가 완료되었습니다.';
               msg += '고유ID : ' + rsp.imp_uid;
               msg += '상점 거래ID : ' + rsp.merchant_uid;
               msg += '결제 금액 : ' + rsp.paid_amount;
               msg += '카드 승인번호 : ' + rsp.apply_num;
         } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
         }
         alert(msg);
      });
   });
</script>
<script>
      $(document).ready(function(){
         var csrfHeaderName = "${_csrf.headerName}";
         var csrfTokenValue = "${_csrf.token}";
         
         $(document).ajaxSend(function(e,xhr,options){
               xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
            });
         function showList(page){
            SaleService.getReview(
                  {bno:bnoValue,page:page||1}, 
                  function(replyCnt,list){
                     console.log("replyCnt : "+replyCnt);
                     
                     if(page== -1){
                        // 페이지 번호가 음수 값 이라면,
                        pageNum 
                        = Math.ceil(replyCnt/10.0);
                        // 덧글의 마지막 페이지 구하기.
                        showList(pageNum);
                        // 덧글 목록 새로고침(갱신)
                        return;
                     }
                     
                     var str="";
                     if(list==null || 
                           list.length==0){
                        replyUL.html("");
                        return;
                     }
                  for(var i=0, 
                        len=list.length||0;
                  i<len;i++){
                        //console.log(list[i]);
                        console.log("replyer : "+list[i].userid);
                        console.log("userid : "+userid);
                        
                        str+="<li class='left ";
                        str+="clearfix' data-rno='";
                        str+=list[i].rno+"'>";
                        str+="<div><div class='header' ";
                        str+="><strong class='";
                        str+="primary-font'>";
                        str+=list[i].userid+"</strong>";
                        if((list[i].userid) == userid){
                           str+="<img style='cursor:pointer;' width=15 height=15 src='http://localhost:8090/resources/images/수정사진.png' id='modifyBtn'>";
                        }
                        str+="<small class='float-sm-right '>";
                        if((list[i].userid) == userid){
                           str+="<img style='cursor:pointer;' width=15 height=15 src='http://localhost:8090/resources/images/x사진.png' id='removeBtn'>&nbsp;";
                        }
                        //str+="text-muted'>";
                        if((list[i].userid) != userid){
                        str+="<img style='cursor:pointer;' width=15 height=15 src='http://localhost:8090/resources/images/신고사진.png' id='reportBtn'>&nbsp;";
                        }
                        str+=replyService.displayTime(list[i].replyDate)+"</small></div>";
                        str+="<p>"+list[i].reply;
                        str+="</p></div></li>";
                     }
                  replyUL.html(str);
                  showReplyPage(replyCnt);
                  });
         }// end_showList
         
         var quantitiy=0;
         var cart = $("#cart");
         $('.quantity-right-plus').click(function(e){
              
              // Stop acting like a button
              e.preventDefault();
              // Get the field name
              var quantity = parseInt($('#quantity').val());
              
              // If is not undefined
                  
                  $('#quantity').val(quantity + 1);

                
                  // Increment
              
          });

           $('.quantity-left-minus').click(function(e){
              // Stop acting like a button
              e.preventDefault();
              // Get the field name
              var quantity = parseInt($('#quantity').val());
              
              // If is not undefined
            
                  // Increment
                  if(quantity>0){
                  $('#quantity').val(quantity - 1);
                  }
          });
          
           cart.on("click",function(e){
              e.preventDefault();
              
              var saleno = $(this).attr("href");
              var userid = '<c:out value="${pageContext.request.userPrincipal.name}"/>';
             var amount = $("input[name='amount']").val();
                 
              var cart = {
                    saleno:saleno,
                    userid:userid,
                    amount:amount
              };
              cartService.insertMainCart(cart,function(result){
                 if(result === 'success'){
                    console.log(result);
                    alert('장바구니에 추가하였습니다');
                    
                    cartService.cartCount(function(count){
                       $("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
                    });
                 }else{
                    console.log(result);
                    alert('이미 추가된 상품입니다.');
                    
                   cartService.cartCount(function(count){
                      $("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
                    });
                 }
              });
           });
      });
   </script>

   <!-- Footer -->
</div>
<%@ include file="../includes/footer.jsp"%>