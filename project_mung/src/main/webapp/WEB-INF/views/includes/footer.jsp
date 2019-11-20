<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="/resources/js/mail.js"></script>
<script type="text/javascript" src="/resources/js/cart.js"></script>
<script type="text/javascript" src="/resources/js/good.js"></script>
<script type="text/javascript" src="/resources/js/profile.js"></script>
<!-- 슬라이드 쇼 배너 스크립트 -->
<sec:authorize access="isAuthenticated()">
   <script>
      $(document)
            .ready(
                  function() {
                     mailService.mailCount(function(count) {
                        $("#mailIcon").html(
                              '<span class="icon-mail"></span>' + "["
                                    + count + "]");
                     });
                     cartService.cartCount(function(count) {
                        $("#cartIcon").html(
                              '<span class="icon-shopping_cart"></span>'
                                    + "[" + count + "]");
                     });

                     profileService
                           .getProfile(function(profile) {
                              if (profile.attachImage.fileName != null) {
                                 $('#profilePicture')
                                       .attr(
                                             'src',
                                             'http://localhost:8090/resources/images/'
                                                   + profile.attachImage.imagePath
                                                   + '/'
                                                   + profile.attachImage.uuid
                                                   + '_'
                                                   + profile.attachImage.fileName);
                              } else {
                                 $('#profilePicture')
                                       .attr('src',
                                             'http://localhost:8090/resources/images/기본프로필.png');
                              }
                   	});
       });
   </script>
</sec:authorize>
<script>
   $("#logoutBtn").on("click", function(e) {
      e.preventDefault();
      $("form[id='logoutForm']").submit();
   });
   $("#myPage").on("click", function(e) {
      e.preventDefault();
      $("form[id='myPageForm']").submit();
   });

   var result = '<c:out value="${result}"/>';

   if (result != null && result != '') {
      	alert(result);
   }
</script>
<style type="text/css" media="screen" id="component_css105">
.Footer .padding_bar {
   padding: 0 15px
}

.Footer .notice {
   margin-top: -21px;
   margin-bottom: 24px;
   padding: 24px 0;
   background-color: #eee
}

.Footer .notice .title {
   padding-bottom: 16px
}

.Footer .kakao_btn {
   color: #3a1e1e;
   background-color: #fbe51a;
   border: none;
}

.Footer .kakao_btn>.scon {
   margin-top: -4px
}

.Footer .intro_member_container, .Footer .join_request {
   margin-bottom: 21px
}

.Footer .intro_brand_container, .Footer .mailto_container {
   margin-bottom: 8px
}

.Footer .mailto {
   text-decoration: underline;
   color: #666
}

.Footer .often {
   position: static
}

.Footer .policies a {
   text-decoration: underline;
   padding-right: 5px;
   color: #666
}

.Footer .policies ul li:nth-child(2n) {
   margin: 8px 0
}

.Footer .sns_container .oa-container .oa-middle {
   width: 25%
}

.Footer .sns_container .channel {
   display: inline-block;
   text-decoration: underline
}

.Footer .sns_container .channel:hover {
   text-decoration: none
}

.Footer .sns_container .channel .scon {
   font-size: 35px
}

.Footer .sns_container .channel .scon-fb {
   top: -1px
}

.Footer .sns_container .channel .scon-insta {
   top: 0
}

.Footer .sns_container .channel .naver {
   padding: 3px;
   height: 35px
}

.Footer .sns_container .channel .youtube {
   padding: 5px 1px;
   height: 35px
}

.Footer .desktop .oa-container {
   margin-left: -5px
}

.Footer .scon {
   font-size: 24px;
   vertical-align: middle
}

.Footer .information {
   padding: 32px 0
}

.Footer .cs_service_time {
   margin-top: 20px
}

.Footer .download {
   width: 100%
}

@media ( max-width :767px) {
   .mobile {
      display: block
   }
   .desktop, .tablet {
      display: none
   }
   .under_desktop {
      display: block
   }
}

@media ( min-width :768px) {
   .mobile {
      display: none
   }
   .tablet {
      display: block
   }
   .desktop {
      display: none
   }
   .under_desktop {
      display: block
   }
}

@media ( min-width :1200px) {
   .Footer .notice .title {
      padding-bottom: 0
   }
   .desktop {
      display: block
   }
   .under_desktop {
      display: none
   }
}
</style>
<style type="text/css" media="screen" id="component_css98">
.App_Grape .app_content.nav_affixed {
   margin-top: 94px
}

.Home .mt_20 {
   margin-top: 20px !important
}

.Home .mt_40 {
   margin-top: 40px !important
}

.Home .mt_56 {
   margin-top: 56px !important
}

.Home .container {
   margin-top: 32px
}

.Home .my_store_container {
   margin-top: 0;
   padding-top: 16px
}

.Home .carousel_container {
   margin-top: 0;
   margin-left: -20px;
   margin-right: -20px
}

.Home .mobile {
   margin-top: 32px
}

.Home .sub_banner {
   margin-left: -20px;
   margin-right: -20px
}

.Home .Footer .container, .Home .Footer .laptop, .Home .Footer .mobile,
   .Home .keywords_container .container, .Home .keywords_container .laptop,
   .Home .keywords_container .mobile {
   margin-top: 0
}

.Home .laptop {
   display: none
}

.Home .laptop .left {
   margin-right: 20px
}

.Home .laptop .left, .Home .laptop .right {
   width: calc(100%/ 2 - 10px)
}

@media ( min-width :768px) {
   .App_Grape .app_content.nav_affixed {
      margin-top: 94px
   }
   .Home .my_store_container {
      margin-top: 0;
      padding-top: 0
   }
   .Home .carousel_container, .Home .sub_banner {
      margin-left: auto;
      margin-right: auto
   }
   .Home .keywords_container, .Home .mobile {
      display: none
   }
   .Home .laptop {
      display: block
   }
}
</style>
<style type="text/css" media="screen" id="component_css105">
.Footer .padding_bar {
   padding: 0 15px
}

.Footer .notice {
   margin-top: -21px;
   margin-bottom: 24px;
   padding: 24px 0;
   background-color: #eee
}

.Footer .notice .title {
   padding-bottom: 16px
}

.Footer .kakao_btn {
   color: #3a1e1e;
   background-color: #fbe51a;
   border: none
}

.Footer .kakao_btn>.scon {
   margin-top: -4px
}

.Footer .intro_member_container, .Footer .join_request {
   margin-bottom: 21px
}

.Footer .intro_brand_container, .Footer .mailto_container {
   margin-bottom: 8px
}

.Footer .mailto {
   text-decoration: underline;
   color: #666
}

.Footer .often {
   position: static
}

.Footer .policies a {
   text-decoration: underline;
   padding-right: 5px;
   color: #666
}

.Footer .policies ul li:nth-child(2n) {
   margin: 8px 0
}

.Footer .sns_container .oa-container .oa-middle {
   width: 25%;
}

.Footer .sns_container .channel {
   display: inline-block;
   text-decoration: underline
}

.Footer .sns_container .channel:hover {
   text-decoration: none
}

.Footer .sns_container .channel .scon {
   font-size: 35px
}

.Footer .sns_container .channel .scon-fb {
   top: -1px
}

.Footer .sns_container .channel .scon-insta {
   top: 0
}

.Footer .sns_container .channel .naver {
   padding: 3px;
   height: 35px
}

.Footer .sns_container .channel .youtube {
   padding: 5px 1px;
   height: 35px
}

.Footer .desktop .oa-container {
   margin-left: -5px
}

.Footer .scon {
   font-size: 24px;
   vertical-align: middle
}

.Footer .information {
   padding: 32px 0
}

.Footer .cs_service_time {
   margin-top: 20px
}

.Footer .download {
   width: 100%
}

@media ( max-width :767px) {
   .mobile {
      display: block
   }
   .desktop, .tablet {
      display: none
   }
   .under_desktop {
      display: block
   }
}

@media ( min-width :768px) {
   .mobile {
      display: none
   }
   .tablet {
      display: block
   }
   .desktop {
      display: none
   }
   .under_desktop {
      display: block
   }
}

@media ( min-width :1200px) {
   .Footer .notice .title {
      padding-bottom: 0
   }
   .desktop {
      display: block
   }
   .under_desktop {
      display: none
   }
}
</style>
<div class="Footer">
   <hr>
   <div class="notice text-bold text-muted" style="display: none;">
      <div class="container">
         <div class="row">
            <div class="col-lg-4 title">
               <span class="notice_title"></span>
            </div>
            <div class="col-lg-8">
               <span class="notice_contents"></span>
            </div>
         </div>
      </div>
   </div>
   <div class="container">
      <div class="footer">
         <div class="row">
            <div class="col-xs-6 col-sm-4 col-lg-3">
               <h5>전화문의</h5>
               <p>월~금 10시 ~ 17시</p>
               <p class="text-bold">1668-4986</p>
            </div>
            <div class="col-xs-6 col-sm-4 col-lg-3">
               <h5>카톡문의</h5>
               <p>월~금 10시 ~ 18시</p>
               <a class="btn btn-default btn-sm kakao_btn"
                  href="http://pf.kakao.com/_tVJtT" target="_blank"> <span
                  class="scon scon-katalk"></span> <span>카톡문의</span>
               </a>
            </div>
            <div class="mobile col-xs-11">
               <hr>
            </div>
            <div class="col-lg-3 desktop">
               <div>
                  <h5>고객센터 운영시간 안내</h5>
                  <p>
                     월~금 10시 ~18시 / 점심 12시~13시<br>( 토/일, 공휴일은 휴무 )
                  </p>
               </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-lg-3 tablet">
               <h5>자주 묻는 질문</h5>
               <div>
                  <p>문의 전 자주 묻는 질문을 확인하세요.</p>
                  <a class="btn btn-default btn-sm" href="/service/faq"> <span
                     class="oa-middle">자주 묻는 질문</span><span
                     class="scon scon-arrow-right often oa-middle"></span>
                  </a>
               </div>
            </div>
            <div class="col-xs-12 cs_service_time under_desktop">
               <div class="clearfix row">
                  <div class="col-sm-4">
                     <h5>고객센터 운영시간 안내</h5>
                  </div>
                  <div class="col-sm-8">
                     <p>
                        월~금 10시 ~18시 / 점심 12시~13시<br>( 토/일, 공휴일은 휴무 )
                     </p>
                  </div>
               </div>
               <hr>
            </div>
            <div class="col-xs-12 col-sm-4 mobile">
               <h5>자주 묻는 질문</h5>
               <div class="clearfix row">
                  <div class="col-xs-6">
                     <p>
                        문의 전 자주 묻는 질문을<br>확인하세요.
                     </p>
                  </div>
                  <div class="text-right col-xs-6">
                     <a class="btn btn-default btn-sm" href="/service/faq"> <span
                        class="oa-middle">자주 묻는 질문</span><span
                        class="scon scon-arrow-right often oa-middle"></span>
                     </a>
                  </div>
               </div>
               <hr>
            </div>
         </div>
   <div class="information">
      <div class="container">
         <div class="row text-muted">
            <div class="col-xs-12 col-sm-6 col-lg-9">
               <p>
                  <strong>사업장소재지&nbsp;&nbsp;</strong><span>인천 미추홀구 매소홀로488번길 6-32
                     (태승빌딩 4층)&nbsp;&nbsp;|&nbsp;&nbsp;</span> <strong>상호&nbsp;&nbsp;</strong><span>(주)
                     멍품천국&nbsp;&nbsp;|&nbsp;&nbsp;</span> <strong>사업자번호&nbsp;&nbsp;</strong><span>610-86-33582&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                  <strong>통신판매신고&nbsp;&nbsp;</strong><span>2015-인천서구-03074&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                  <strong>대표&nbsp;&nbsp;</strong><span>김태훈&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                  <strong>개인정보책임자&nbsp;&nbsp;</strong><span>최인후
                     (chdllsgn00@naver.com)</span>
               </p>
            </div>
            <div class="col-sm-6 col-lg-3 tablet">
               <div class="col-sm-6">
                  <a
                     href="https://itunes.apple.com/us/app/%EC%84%9C%EC%9A%B8%EC%8A%A4%ED%86%A0%EC%96%B4/id1378226478?ls=1&amp;mt=8"
                     target="_blank"> 
                     
                  </a>
               </div>
               <div class="col-sm-6">
                  <a
                     href="https://play.google.com/store/apps/details?id=com.seoulstore"
                     target="_blank"> 
                  </a>
               </div>
            </div>
            <div class="col-sm-12 col-lg-12">
               <p>@ DUNIT. ALL RIGHTS RESERVED</p>
            </div>
         </div>
      </div>
   </div>
</div>
</body>
</html>