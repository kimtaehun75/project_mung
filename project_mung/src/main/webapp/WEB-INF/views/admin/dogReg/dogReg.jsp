<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>

<%@ include file="../../admin/includes/nav.jsp"%>

<div class="page-wrapper">
   <div class="page-breadcrumb">
      <div class="row">
         <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">유기견 신청자 목록</h4>
         </div>
      </div>
   </div>
   <!--=================================================== 유기견 신청자 목록 ================================================-->
   <hr>
   <br>
   <div>
      <div align="right"></div>
      <div>
         <table id="dataTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>유기견 사진</th>
                  <th>유기견 번호</th>
                  <th>유기견 이름</th>
                  <th>작성자 아이디</th>
                  <th>품종</th>
                  <th>예방유무</th>
                  <th>성별</th>
                  <th>회원 등록일</th>
                  <th>분양 상태</th>
               </tr>
            </thead>
            <c:forEach items="${list}" var="dogs" varStatus="i">
               <tbody>
                  <tr>
                     <td>
                        <form id="actionForm" action="../admin/dogReg/dRegister"
                           method="get">
                           <a href="${dogs.dogno }" class="get">
                           <img width=200 height=200
                              src="http://localhost:8090/resources/images/${dogs.attachImage.imagePath}/${dogs.attachImage.uuid}_${dogs.attachImage.fileName}">
                           </a>
                        </form>
                     </td>
                     <td>${dogs.dogno }</td>
                     <td>${dogs.dogName }</td>
                     <td>${dogs.userid }</td>
                     <td>${dogs.kind }</td>
                     <td>${dogs.pre }</td>
                     <td>${dogs.gender }</td>
                     <td><fmt:formatDate pattern="yyyy-MM-dd"
                           value="${dogs.updateDate}" /></td>
                     <td>${dogs.adopt } </td>
                  </tr>
               </tbody>
            </c:forEach>
         </table>
      </div>
   </div>
</div>
<!-- ==================================================SCRIPT================================================================= -->

<script>

var actionForm = $("#actionForm");

$(".get").on("click",function(e) {
         e.preventDefault();
         actionForm.append("<input type='hidden' name='dogno' "
                     + "value='" + $(this).attr("href")
                     + "'>");
         actionForm.attr("action", "../dogReg/dRegister");
         actionForm.submit();
      });
</script>

<!-- ==============================================footer================================================ -->
<%@ include file="../../admin/includes/footer.jsp"%>