<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>

<%@ include file="../../admin/includes/nav.jsp"%>


<section class="ftco-section">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-md-10 mb-5 text-center">
            <ul class="product-category">
               <c:forEach items="${menu}" var="cate">
					<li><a href="/admin/product/list?cateno=${cate.cateno}">${cate.cateName }</a></li>
				</c:forEach>
            </ul>
         </div>
      </div>
   <div>
         <div>

            <div>
               <form id="searchForm" action="/admin/product/list" method="get">
                  &nbsp;&nbsp;&nbsp;
                  <select name="type">
                     <option value="" ${pageMaker.cri.type==null?"selected":"" }>
                        --
                     </option>
                     <option value="S" ${pageMaker.cri.type eq "S"?"selected":"" }>
                        상품명
                     </option>
                  </select> 
                  <input type="text" name="keyword" /> 
                  <button>검색</button>
               </form>               
            </div>
            <div align="right">
            <a href="./register"
            style="text-decoration: none; color:white;">
            <button class="btn btn-primary px-3" id="reg_submit">
            <i class="fa fa-heart pr-2" aria-hidden="true"></i>
               상품 등록
            </button>
            </a>
            </div>
            </div>
         </div>   
      
      <form id="actionForm" action="/admin/product/list" method="get">
         <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
         <input type="hidden" name="type" value="${pageMaker.cri.type}">
         <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
         <input type="hidden" name="cateno" value="${pageMaker.cri.cateno}">
      </form>
      <div class="row">
      <c:forEach items="${list }" var="sale">
         <c:set var="checkList" value="${checkList+1 }"/>
         <div class="col-md-6 col-lg-3 ftco-animate">
            <div class="product">
               <a href="/admin/product/saleinfo?saleno=${sale.saleno }" class="img-prod">
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
</body>   
<!-- ==================================================SCRIPT================================================================= -->

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


<!-- Scripts -->
<!-- css 1 -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
<script src="/resources/js/popper.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.easing.1.3.js"></script>
<script src="/resources/js/jquery.waypoints.min.js"></script>
<script src="/resources/js/jquery.stellar.min.js"></script>
<script src="/resources/js/owl.carousel.min.js"></script>
<script src="/resources/js/jquery.magnific-popup.min.js"></script>
<script src="/resources/js/aos.js"></script>
<script src="/resources/js/jquery.animateNumber.min.js"></script>
<script src="/resources/js/bootstrap-datepicker.js"></script>
<script src="/resources/js/scrollax.min.js"></script>

<script src="/resources/js/main.js"></script>
<!-- css 2 -->
<script src="/resources/js/jquery.waypoints.min.js"></script>
<script src="/resources/js/jquery.stellar.min.js"></script>
<script src="/resources/js/owl.carousel.min.js"></script>
<script src="/resources/js/jquery.magnific-popup.min.js"></script>
<script src="/resources/js/jquery.animateNumber.min.js"></script>



<script>
$("#logoutBtn").on("click",function(e){
   e.preventDefault();
   $("form[id='logoutForm']").submit();
});
$("#myPage").on("click",function(e){
   e.preventDefault();
   $("form[id='myPageForm']").submit();
});

var result = '<c:out value="${result}"/>';;

if(result != null && result != ''){
   if(result == 'success'){
	   alert("상품 수정에 성공하였습니다.");
   }else{
	   alert("상품 수정에 실패하였습니다.");
   }
}
</script>

         

            <script type="text/javascript">                              

                              var actionForm = $("#actionForm");
                              // 클래스 page-item 에 a 링크가 클릭 된다면,
                              $(".page-item a")
                                    .on(
                                          "click",
                                          function(e) {
                                             e.preventDefault();
                                             // 기본 이벤트 동작을 막고,
                                             console
                                                   .log("click");
                                             // 웹 브라우저 검사 창에 클릭을 표시
                                             actionForm
                                                   .find(
                                                         "input[name='pageNum']")
                                                   .val(
                                                         $(
                                                               this)
                                                               .attr(
                                                                     "href"));
                                             // 액션폼 인풋태그에 페이지넘 값을 찾아서,
                                             // href로 받은 값으로 대체함.
                                             actionForm.submit();
                                          });

                              $(".move")
                                    .on(
                                          "click",
                                          function(e) {
                                             e.preventDefault();
                                             actionForm
                                                   .append("<input type='hidden' name='userid' "
                                                         + "value='"
                                                         + $(
                                                               this)
                                                               .attr(
                                                                     "href")
                                                         + "'>");
                                             actionForm
                                                   .attr(
                                                         "action",
                                                         "/admin/member/getUser");
                                             actionForm.submit();
                                          });

                              var searchForm = $("#searchForm");
                              $("#searchForm button")
                                    .on(
                                          "click",
                                          function(e) {
                                             if (!searchForm
                                                   .find(
                                                         "option:selected")
                                                   .val()) {
                                                alert("검색 종류를 선택하세요.");
                                                return false;
                                             }
                                             if (!searchForm
                                                   .find(
                                                         "input[name='keyword']")
                                                   .val()) {
                                                alert("키워드를 입력하세요.");
                                                return false;
                                             }

                                             searchForm
                                                   .find(
                                                         "input[name='pageNum']")
                                                   .val(1);
                                             e.preventDefault();
                                             searchForm.submit();

                                          });
</script>
            
            <script>
               $(document).ready(function() {
                  $('#dataTable').DataTable({
                     "order" : [ [ 0, "desc" ] ], //정렬 0컬럼의 내림차순으로
                     "paging" : false, // 페이징 표시 안함.
                     "bFilter" : false, // 검색창 표시 안함.
                     "info" : false
                  // 안내창 표시 안함.
                  })
               })
            </script>

            <!-- ==============================================footer================================================ -->
            <%@ include file="../../admin/includes/footer.jsp"%>