<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- 파비콘 아이콘 -->
<link rel="icon" type="image/png" sizes="16x16"
   href="/resources/adminbt/assets/images/logo-icon.png">
<title>멍품 관리자페이지</title>
<!-- Custom CSS -->
<link href="/resources/adminbt/assets/libs/flot/css/float-chart.css"
   rel="stylesheet">
<!-- Custom CSS -->
<link href="/resources/adminbt/dist/css/style.min.css" rel="stylesheet">
<!-- 스크립트 -->
<script src="/resources/adminbt/assets/libs/jquery/dist/jquery.min.js"></script>
<script
   src="/resources/adminbt/assets/libs/popper.js/dist/umd/popper.min.js"></script>
<script
   src="/resources/adminbt/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<script
   src="/resources/adminbt/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
<script
   src="/resources/adminbt/assets/extra-libs/sparkline/sparkline.js"></script>
<!--Menu sidebar -->
<script src="/resources/adminbt/dist/js/sidebarmenu.js"></script>
<!--Custom JavaScript -->
<script src="/resources/adminbt/dist/js/custom.min.js"></script>
<!--This page JavaScript -->
<script src="/resources/adminbt/dist/js/pages/chart/chart-page-init.js"></script>

<link
   href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap"
   rel="stylesheet">

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
</head>

<body>

   <div class="preloader">
      <div class="lds-ripple">
         <div class="lds-pos"></div>
         <div class="lds-pos"></div>
      </div>
   </div>

   <div id="main-wrapper">
      <header class="topbar" data-navbarbg="skin5">
         <div class="navbar-header" data-logobg="skin5">

            <!-- 사이드바 메뉴 열고 닫기 -->
            <a class="nav-toggler waves-effect waves-light d-block d-md-none"
               href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>

            <!-- 로고 아이콘-->
            <a class="navbar-brand" href="../../"> <!-- Logo icon --> <b
               class="logo-icon p-l-10"> <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                  <!-- Dark Logo icon -->
             <!-- 로고 텍스트 -->
            </b> <span class="logo-text"> <!-- dark Logo text --> <img
                  src="/resources/adminbt/assets/images/adminlogo.png"
                  alt="homepage" class="light-logo" />
            </span>
            </a>

            <div class="navbar-collapse collapse" id="navbarSupportedContent"
               data-navbarbg="skin5">

               <!-- 네비 아이템 -->
               <ul class="navbar-nav float-left mr-auto">
                  <li class="nav-item d-none d-md-block"><a
                     class="nav-link sidebartoggler waves-effect waves-light"
                     href="javascript:void(0)" data-sidebartype="mini-sidebar"><i
                        class="mdi mdi-menu font-24"></i></a></li>
               </ul>
            </div>
         </div>

      </header>