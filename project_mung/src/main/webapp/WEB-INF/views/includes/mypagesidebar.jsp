<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">
<style>
.skydiv{
	display:none;
}
</style>
<head>
<meta charset="utf-8">
<div style="float:left; width:18%;">
	<!-- Sidebar -->
	<div id="sidebar">
		 <div>
                <img src="/resources/images/mypagelogo.jpg" style="width:62%;">
                </div>
		<div class="sidebar-box ftco-animate" style="margin:auto;">
                  <h3 class="heading">나의 상품</h3>
                  <ul class="categories">
                     <li><a href="/mypage/getReview" class="">-나의 상품 후기</a></li>
                     <li><a href="/mypage/getCart" class="">-장바구니 목록</a></li>
                  </ul>
                   <h3 class="heading">쪽지함</h3>
                  <ul class="categories">
                     <li><a href="/mypage/getSentMail" class="">보낸 쪽지</a></li>
                     <li><a href="/mypage/getRecvMail" class="">받은 쪽지</a></li>
                     <li><a href="/mypage/getWriteMail" class="">쪽지 보내기</a></li>
                  </ul>
                   <h3 class="heading">쇼핑 정보</h3>
                  <ul class="categories">
                     <li><a href="/mypage/order" class="">-주문목록/배송조회 </a></li>
                  </ul>
                  <h3 class="heading">혜택 관리</h3>
                  <ul class="categories">
                     <li><a href="/mypage/getCoupon" class="">-쿠폰</a></li>
                  </ul>
                  <h3 class="heading">회원 정보</h3>
                  <ul class="categories">
                     <li><a href="/mypage/getInfo" class="">-회원정보 변경</a></li>
                     <li><a href="/mypage/memberout" class="">-회원 탈퇴</a></li>
                  </ul>
                  
               </div>
	</div>
</div>