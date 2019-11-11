<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<table style="width: 60%; margin: auto;">
      <!-- 보낸사람 -->
   <tr>   
      <td><div class="form-group">
         신고자
         <input class="form-control" name="userid" value="${list.userid }" readonly="readonly" style="width:60%;">
      </div></td>
   </tr>   
   <tr>
      <td><div class="form-group">
         피고자
         <input class="form-control" name="rpuser" value="${list.rpuser }" readonly="readonly" style="width:60%;">
      </div></td>
   </tr>   
   <tr>
      <td><div class="form-group">
         <textarea cols="40" rows="10" name="content" readonly="readonly" style="width:60%;">${list.content}</textarea>
      </div></td>
   </tr>
   
<!--=====================버튼=======================-->
      <tr>   
		<td>
	      	<div class="reg_button">
	         	<a class="btn btn-primary px-3"
	                  href="/admin/report/report"> 
	                  <i class="fa fa-rotate-right pr-2" aria-hidden="true">
	                  
	                  </i>목록으로
				</a>&emsp;&emsp;   
	      	</div>
		</td>
   </tr>
</table>   
<%@ include file="../includes/footer.jsp"%>