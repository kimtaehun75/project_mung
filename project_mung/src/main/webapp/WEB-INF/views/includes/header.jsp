<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>멍품 천국</title>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
   href="/resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/animate.css">

<link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/resources/css/magnific-popup.css">

<link rel="stylesheet" href="/resources/css/aos.css">

<link rel="stylesheet" href="/resources/css/ionicons.min.css">

<link rel="stylesheet" href="/resources/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/resources/css/jquery.timepicker.css">
<link rel="stylesheet" href="/resources/css/sb-admin-2.css">
<link rel="stylesheet" href="/resources/css/sb-admin-2.min.css">
<link rel="stylesheet" href="/resources/css/flaticon.css">
<link rel="stylesheet" href="/resources/css/icomoon.css">
<link rel="stylesheet" href="/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js">
   
</script>

<style>
html {
    scroll-behavior: smooth;
}
a#MOVE_TOP_BTN {
   position: fixed;
   right: 5%;
   bottom: 40%;
   display: none;
   z-index: 999;
}
</style>
<script>
   $(function() {
      $(window).scroll(function() {
         if ($(this).scrollTop() > 500) {
            $('#MOVE_TOP_BTN').fadeIn();
         } else {
            $('#MOVE_TOP_BTN').fadeOut();
         }
      });

      $("#MOVE_TOP_BTN").click(function() {
         $('html, body').animate({
            scrollTop : 0
         }, 400);
         return false;
      });
   });
</script>

<style type="text/css">
.skydiv {
   position: fixed;
   top: 35%;
   left: 45px;
}
</style>

</head>

<body class="goto-here">

   <!-- Header -->

   <!-- Header-Top -->

   <div class="py-2 bg-primary">
      <div class="container">
         <div
            class="row no-gutters d-flex align-items-start align-items-center px-md-0">
            <div class="col-lg-12 d-block">
               <div class="row d-flex">
                  <div class="col-md pr-4 d-flex topper align-items-center">
                     <div
                        class="icon mr-2 d-flex justify-content-center align-items-center">
                        <span class="icon-phone2"></span>
                     </div>
                     <span class="text">010-4652-6481</span>
                  </div>
                  <div class="col-md pr-4 d-flex topper align-items-center">
                     <div
                        class="icon mr-2 d-flex justify-content-center align-items-center">
                        <span class="icon-paper-plane"></span>
                     </div>
                     <span class="text">kimtaehun75@naver.com</span>
                  </div>
                  <div
                     class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
                     <span class="text">멍품천국에 오신걸 환영합니다.</span>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

   <!-- END Header-Top-->

   <!-- nav -->
   <nav
      class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
      id="ftco-navbar">
      <div class="container">
         <div style="margin-left:50px;">
         <a href="http://pf.kakao.com/_tVJtT"> <img
            onmouseover="this.style.cursor='pointer';" class="index"
            src="/resources/images/사이드카톡.png"></a>
         </div>
         <!-- 로고-->
         <div class="col-md-6">
            <div style="margin: 0px 0px 0px 60px">
               <img onmouseover="this.style.cursor='pointer';" class="index"
                  src="/resources/images/brand.png" onclick="location.href='/'">
            </div>
         </div>
      </div>
      <!-- navitem 1 -->
      <div style="margin-right:240px;">
      <ul class="navbar-nav ml-auto">
         <sec:authorize access="isAuthenticated()">
            <li class="nav-item"><a class="nav-link"> <img
                  class='img-profile rounded-circle' height=30 width=30
                  id='profilePicture' src=''>
            </a></li>
         </sec:authorize>
         <sec:authorize access="isAuthenticated()">
            <li class="nav-item"><a class="nav-link">
                  ${pageContext.request.userPrincipal.name}님 </a></li>
         </sec:authorize>
         <sec:authorize access="isAnonymous()">
            <li class="nav-item"><a href="/userlogin" class="nav-link">
                  로그인 </a></li>
         </sec:authorize>
         <sec:authorize access="isAuthenticated()">
            <li class="nav-item"><a class="nav-link" id="logoutBtn" href="">
                  로그아웃 </a>
               <form action="/userlogout" method="post" id="logoutForm">
                  <input type="hidden" name="${_csrf.parameterName}"
                     value="${_csrf.token}">
               </form></li>
         </sec:authorize>
         <sec:authorize access="isAnonymous()">
            <li class="nav-item"><a href="/member/register"
               class="nav-link"> 회원가입 </a></li>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_MEMBER')">
            <li class="nav-item"><a id="myPage" class="nav-link"
               onmouseover="this.style.cursor='pointer';"> <span
                  class="icon-user"></span>
            </a>
               <form method="get" id="myPageForm" action="/mypage/getInfo">
               </form></li>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="nav-item"><a href="/admin/member/member"
               class="nav-link"> <span class="icon-cog"></span>
            </a></li>
         </sec:authorize>
         <sec:authorize access="isAuthenticated()">
            <li class="nav-item cta cta-colored"><a
               href="/mypage/getRecvMail" class="nav-link" id="mailIcon"> <span
                  class="icon-mail"></span>
            </a></li>
         </sec:authorize>
         <sec:authorize access="isAuthenticated()">
            <li class="nav-item cta cta-colored"><a href="/mypage/getCart"
               class="nav-link" id="cartIcon"> <span
                  class="icon-shopping_cart"></span>
            </a></li>
         </sec:authorize>
      </ul>
      </div>
   </nav>
   <nav
      class="navbar navbar-expand-lg navbar-dark ftco_navbar1 bg-dark ftco-navbar1-light"
      id="ftco-navbar1">
      <div style="font-size: 16pt; white-space: nowrap; margin: auto;">
         <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="/company"
               aria-haspopup="true" aria-expanded="false"> 회사 소개 </a></li>
            <li class="nav-item"><a class="nav-link" href="/grade"
               aria-haspopup="true" aria-expanded="false"> 멍품 멤버쉽 </a></li>
            <li class="nav-item"><a class="nav-link" href="/guide"
               aria-haspopup="true" aria-expanded="false"> 반려동물 가이드 </a></li>
            <li class="nav-item"><a class="nav-link"
               href="/freeboard/freeboard" aria-haspopup="true"
               aria-expanded="false"> 게 시 판 </a></li>
            <li class="nav-item"><a class="nav-link" href="/event/event"
               aria-haspopup="true" aria-expanded="false"> Event </a></li>
            <li class="nav-item dropdown"><a
               class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false"> 애견 상품 </a>
               <div class="dropdown-menu">
               	  <a class="dropdown-item" href="/sale/list?cateno=1">초보 집사를 위한 멍품</a>
                  <a class="dropdown-item" href="/sale/list?cateno=2"> 사료/간식 </a> <a
                     class="dropdown-item" href="/sale/list?cateno=3"> 미용 </a> <a
                     class="dropdown-item" href="/sale/list?cateno=4"> 건강 </a> <a
                     class="dropdown-item" href="/sale/list?cateno=5"> 장난감 </a>

               </div></li>
            <li class="nav-item dropdown"><a
               class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false"> 주인을 찾아요 </a>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="/adopt/adoptList"> 보호중인 유기견들 </a> <a
                     class="dropdown-item" href="/adopt/adoptAfter"> 분양 후기 및 관리 </a> <a
                     class="dropdown-item" href="/adopt/adoptReg"> 유기견 개인등록 </a>
               </div></li>
            <li class="nav-item dropdown"><a
               class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false"> 고객센터 </a>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="/service/faq"> FAQ </a> 
               </div>
			</li>
         </ul>
      </div>
   </nav>
   <!-- Tocplus 15.1 -->
   <script type="text/javascript">
      tocplusTop = 1150;
      tocplusLeft = 5;
      tocplusMinimizedImage = 'http://kr03.tocplus007.com/img/minimized_ko.gif';
      tocplusHAlign = 'right';
      tocplusWidth = 200;
      tocplusHeight = 240;
      tocplusUserName = '집사님';
      tocplusFrameColor = '#FFA500';
      tocplusFloatingWindow = true;
      var tocplusHost = (("https:" == document.location.protocol) ? "https://"
            : "http://");
      document
            .write(unescape("%"
                  + "3Cscript src='"
                  + tocplusHost
                  + "kr03.tocplus007.com/chatLoader.do?userId=chldlsgn00' type='text/javascript'"
                  + "%" + "3E" + "%" + "3C/script" + "%" + "3E"));
   </script>
   <!-- End of Tocplus -->

   <div class="skydiv">
      <style type="text/css">
#info {
   height: 450px;
}

.menu, .menu ul {
   padding: 0;
   margin: 0;
   list-style: none;
}

.menu {
   margin-left: 10px;
} /* this demo only */
.menu {
   width: 180px;
   height: 340px;
   background: #fcfcfc;
   border: 1px solid #ddd;
   border-width: 1px 0 1px 1px;
   position: relative;
   z-index: 500;
}

.menu table {
   border-collapse: collapse;
   padding: 0;
   margin: 0 0 -1px 0;
   width: 0;
   height: 0;
   font-size: 1em;
}

.menu ul {
   position: absolute;
   left: -9999px;
}

.menu li {
   width: 180px;
   height: 42px;
   float: left;
   border-right: 1px solid #ddd;
}

.menu li a {
   display: block;
   width: 100%;
   height: 42px;
   line-height: 42px;
   color: #777;
   text-decoration: none;
   font-size: 12px;
   font-family: "lucida grande", arial, sans-serif;
   text-indent: 50px;
   float: left;
}

.menu li.sub a {
   background: url(/data/201012/IJ12934917389802/grey.gif) no-repeat 150px
      center;
}

.menu li a:hover {
   white-space: nowrap;
   position: relative;
   color: #06f;
}

.menu li.sub a:hover {
   background: url(/data/201012/IJ12934917389802/blue.gif) no-repeat 150px
      center;
   color: #06f;
}

.menu li.sub a b {
   display: block;
   color: #06f;
   font-weight: normal;
}

.menu li:hover {
   position: relative;
}

.menu li:hover.sub>a {
   background: url(/data/201012/IJ12934917389802/blue.gif ) no-repeat 150px
      center;
   color: #06f;
}

.menu li.home {
   background: url(/data/201012/IJ12934917389802/home.gif) no-repeat 10px
      center;
}

.menu li.products {
   background: url(/data/201012/IJ12934917389802/graph.gif) no-repeat 10px
      center;
}

.menu li.services {
   background: url(/data/201012/IJ12934917389802/services.gif) no-repeat
      10px center;
}

.menu li.shop {
   background: url(/data/201012/IJ12934917389802/flower.gif) no-repeat 10px
      center;
}

.menu li.contacts {
   background: url(/data/201012/IJ12934917389802/mail.gif) no-repeat 10px
      center;
}

.menu li.privacy {
   background: url(/data/201012/IJ12934917389802/lock.gif) no-repeat 10px
      center;
}

.menu :hover ul {
   width: 120px;
   height: auto;
   left: 165px;
   top: 7px;
   background: #fcfcfc;
   border: 1px solid #ddd;
}

.menu :hover ul :hover ul, .menu :hover ul :hover ul :hover ul, .menu :hover ul :hover ul :hover ul :hover ul,
   .menu :hover ul :hover ul :hover ul :hover ul :hover ul {
   width: 120px;
   height: auto;
   left: 115px;
   top: -1px;
   background: #fcfcfc;
   border: 1px solid #ddd;
   border-width: 1px 0 1px 1px;
}

.menu :hover ul ul, .menu :hover ul :hover ul ul, .menu :hover ul :hover ul :hover ul ul,
   .menu :hover ul :hover ul :hover ul :hover ul ul {
   left: -9999px;
   width: 0;
   height: 0;
}

.menu :hover ul li, .menu :hover ul li a {
   width: 120px;
   height: 25px;
   line-height: 25px;
   text-indent: 10px;
   float: none;
}

.menu :hover ul li.sub a, .menu :hover ul :hover ul li.sub a, .menu :hover ul :hover ul :hover ul li.sub a,
   .menu :hover ul :hover ul :hover ul :hover li.sub a, .menu :hover ul :hover ul :hover ul :hover ul :hover li.sub a
   {
   background: url(/data/201012/IJ12934917389802/grey.gif) no-repeat 100px
      center;
   color: #777;
}

.menu :hover ul li.sub a:hover, .menu :hover ul :hover ul li.sub a:hover,
   .menu :hover ul :hover ul :hover ul li.sub a:hover, .menu :hover ul :hover ul :hover ul :hover ul li.sub a:hover
   {
   background: url(/data/201012/IJ12934917389802/blue.gif) no-repeat 100px
      center;
   color: #06f;
}

.menu :hover ul li.sub:hover>a, .menu :hover ul :hover ul li.sub:hover>a,
   .menu :hover ul :hover ul :hover ul li.sub:hover>a, .menu :hover ul :hover ul :hover ul :hover ul li.sub:hover>a
   {
   background: url(/data/201012/IJ12934917389802/blue.gif) no-repeat 100px
      center;
   color: #06f;
}

.menu :hover ul li a, .menu :hover ul :hover ul li a, .menu :hover ul :hover ul :hover ul li a,
   .menu :hover ul :hover ul :hover ul :hover ul li a, .menu :hover ul :hover ul :hover ul :hover :hover ul li a
   {
   background: #fcfcfc;
   color: #777;
}

.menu :hover ul li a:hover, .menu :hover ul :hover ul li a:hover, .menu :hover ul :hover ul :hover ul li a:hover,
   .menu :hover ul :hover ul :hover ul :hover ul li a:hover, .menu :hover ul :hover ul :hover ul :hover ul :hover ul li a:hover
   {
   background: #fcfcfc;
   color: #06f;
}

.menu li.sub a b, .menu :hover li.sub a b, .menu :hover ul :hover li.sub a b,
   .menu :hover ul :hover ul :hover li.sub a b, .menu :hover ul :hover ul :hover ul :hover li.sub a b,
   .menu :hover ul :hover ul :hover ul :hover ul :hover li.sub a b {
   display: block;
   color: #06f;
   font-weight: normal;
}

.menu li.sub a.selected b, .menu :hover ul li.sub a.selected b, .menu :hover ul :hover ul li.sub a.selected b,
   .menu :hover ul :hover ul :hover ul li.sub a.selected b, .menu :hover ul :hover ul :hover ul :hover ul li.sub a.selected b,
   .menu :hover ul :hover ul :hover ul :hover ul :hover ul li.sub a.selected b
   {
   display: block;
   background: #fcfcfc;
   color: #06f;
   font-weight: normal;
}
</style>
      <div id="adoptImg" style="margin-left: 35px;">
         <a href="/adopt/adoptList"> 
         <img src="/resources/images/분양받기.png"
            width="110px;" height="110px;">
         </a>
      </div>
      <div id="info">
         <ul class="menu">
            <li class="home"><a href="/company">회사소개</a></li>
            <li class="home"><a href="/grade">명품멤버쉽</a></li>
            <li class="home"><a href="/guide">반려동물 가이드</a></li>
            <li class="home"><a href="/freeboard/freeboard">게시판</a></li>
            <li class="home"><a href="/event/event">EVENT</a></li>
            <li class="sub products"><a href="#"><b>애견상품</b>
               <!--[if IE 7]><!--></a>
            <!--<![endif]--> <!--[if lte IE 6]><table><tr><td><![endif]-->
               <ul>
               	  <li><a href="/sale/list?cateno=1">초보 집사 멍품</a></li>
                  <li><a href="/sale/list?cateno=2">사료/간식</a></li>
                  <li><a href="/sale/list?cateno=3">미용</a></li>
                  <li><a href="/sale/list?cateno=4">건강</a></li>
                  <li><a href="/sale/list?cateno=5">장난감</a></li>
               </ul> <!--[if lte IE 6]></td></tr></table></a><![endif]-->
            </li>
            <li class="sub products"><a href="#"><b>주인을 찾아요</b>
               <!--[if IE 7]><!--></a>
            <!--<![endif]--> <!--[if lte IE 6]><table><tr><td><![endif]-->
               <ul>
                  <li><a href="/adopt/adoptList">보호중인 유기견들</a></li>
                  <li><a href="/adopt/adoptAfter">분양후기 및 관리</a></li>
                  <li><a href="/adopt/adoptReg">유기견 개인 등록</a></li>
               </ul> <!--[if lte IE 6]></td></tr></table></a><![endif]-->
            </li>
            <li class="sub products"><a href="#"><b>고객센터</b></a>
           		<ul>
					<li><a href="/service/faq">faq</a></li>
           		</ul>
            </li>
         </ul>
      </div>
   </div>
   <a id="MOVE_TOP_BTN" href="#"><img src="/resources/images/위.png"
      width="50px;" height="50px;"></a>
   <!-- END nav -->