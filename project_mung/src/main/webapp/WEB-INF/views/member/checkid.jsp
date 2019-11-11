<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<div class="table-responsive">
   <table class="table table-bordered" id="dataTable">
      <tr>
         <td style="">귀하가 가지고 있는 ID</td>
      </tr>
      <c:forEach var="id" items="${id}">
         <tr>
            <td>${id}</td>
         </tr>
      </c:forEach>
   </table>
   <p style="text-align:center;">
   <a href="/userlogin"> 로그인 하러 가기 </a>
   </>
</div>
<%@ include file="../includes/footer.jsp"%>