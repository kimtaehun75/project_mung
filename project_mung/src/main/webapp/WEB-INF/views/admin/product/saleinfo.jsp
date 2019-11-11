<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
    	<div class="container">
    		<div class="row">
    			<form role="form" action="/admin/product/saleInfo" method="post">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" /> 
					<br>
					<br>
					<br>
					<div class="form-group">
						카테고리
						<select name="cate.cateno">
							<c:forEach items="${cate}" var="cate">
								<option value="${cate.cateno}" ${cate.cateno eq saleInfo.cate.cateno?"selected":"${cate[0].cateno}"}>
									${cate.cateName }
								</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="form-group">
						상품번호<input class="form-control" name="saleno"
							value='<c:out value="${saleInfo.saleno }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
						상품이름<input class="form-control" name="saleName"
							value='<c:out value="${saleInfo.saleName }"/>'>
					</div>
					
					<div class="form-group">
						상품가격<input class="form-control" name="cost" value='${saleInfo.cost}'>
					</div>
					
					<div class="form-group">
						상품갯수<input class="form-control" name="amount"
							value='<c:out value="${saleInfo.amount }"/>'>
					</div>
					
					<div class="form-group">
						상품설명
						<textarea rows="10"  cols="5	0" class="form-control" name="content"><c:out
								value="${saleInfo.content}" /></textarea>
					</div>
				
					<div class="form-group">
						올린날짜<input class="form-control" name="updateDate"
							value='<fmt:formatDate pattern="yyyy/MM/dd" 
						value="${saleInfo.updateDate}"/>'
							readonly="readonly">
					</div>
					
					<div class="form-group">
						좋아요<input class="form-control" name="updateDate" 
						value="${saleInfo.good}" readonly="readonly" />
					</div>					

					<div>
						<label for="image">이미지</label>
						<input type="file" name="uploadImage" multiple>						
					</div>
					
					<h4>현재 이미지</h4>												
    						<img width=200 height=200 src="http://localhost:8090/resources/images/${saleInfo.attachImage.imagePath}/${saleInfo.attachImage.uuid}_${saleInfo.attachImage.fileName}" 
    						class="img-fluid" alt="Colorlib Template">  					    					

					<h4>바뀔 이미지</h4>										
					<div class="uploadResult">
						<ul>					
						
						</ul>
					</div>
							<button type="submit" data-oper="modify" class="btn btn-warning">수정</button>
							<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
							<button type="submit" data-oper="list" class="btn btn-info">목록</button>
				</form>
    		</div>
    	</div>
<!--======================================================================================================== -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
		$(document).ready(function(){
			
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			$(document).ajaxSend(function(e,xhr,options){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			});
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|txt)$");
			// 정규표현식. 일부 파일의 업로드 제한.
			
			var maxSize = 5242880; // 5MB
								
			function showImage(uploadImage){
				if(!uploadImage || uploadImage.length == 0){
					return;
				}
				
				var uploadUL = $(".uploadResult ul");
				var str="";
				
				var fileCallPath = decodeURIComponent(uploadImage.imagePath+"/"+uploadImage.uuid+"_"+uploadImage.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				console.log(fileLink);
				str += "<li data-path='";
				str += uploadImage.imagePath+"' data-uuid='";
				str += uploadImage.uuid+"' data-filename='";
				str += uploadImage.fileName+"' data-type='";
				str += uploadImage.image+"'><div>";
				str += "<img width=200 height=200 src='http://localhost:8090/resources/images/"+fileLink;
				str += "'><br>";
				str += "<span>"+uploadImage.fileName+"</span>";
				str += "<b data-file='"+fileCallPath;
				str += "' data-type='file'>[x]</b>";
				str += "</div></li>";
				
				$(uploadUL).empty();
				
				uploadUL.append(str);
				
				var fileName = $(".uploadResult ul li").data("filename");
				var uuid = $(".uploadResult ul li").data("uuid");
				var path = $(".uploadResult ul li").data("path");
				var type = $(".uploadResult ul li").data("type");
				
				console.log(fileName);
				console.log(uuid);
				console.log(path);
				console.log(type);
			}	
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 크기 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드 불가합니다");
					return false;
				}
				return true;
			}
			
			$("input[name='uploadImage']").change(function(e){
				var formData = new FormData();
				var inputImage = $("input[name='uploadImage']");
				var files = inputImage[0].files;
				
				for(var i=0;i<files.length;i++){
					if(!checkExtension(files[i].name,
							files[i].size)){
						return false;
					}
					formData.append("uploadImage",files[i]);
				}
				
				$.ajax({
					url : '/uploadImageAction',
					processData : false,
					contentType : false,
					data: formData,
					type : 'POST',
					dataType : 'json',
					success : function(result){
						console.log(result);
						showImage(result);
					}
				});
			})
			
			$(".uploadResult").on("click","b",function(e){
				console.log("delete file");
				var targetFile = $(this).data("file");
				var type= $(this).data("type");
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url : '/deleteFile',
					data : {
						fileName : targetFile,
						type : type
					},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						alert(result);
						targetLi.remove();
					}
				});
			});
		
			
		});
	</script>
	<script>
	$(document).ready(function() {
		console.log("history.state : " + history.state);
		var formObj = $("form");/* form 객체를  변수에 할당. */
		
		$('button').on("click", function(e) {
			/* 버튼이 클릭된다면, */
			e.preventDefault();/* 버튼의 기본 기능을 막고 */
			var operation = $(this).data("oper");
			/* 버튼에서 data oper 를 가져와서 변수에 할당. */
			console.log(operation);
			/* 웹브라우저 콘솔로 해당 변수 출력 */

			if (operation === 'remove') {
				formObj.attr("action", "/admin/product/remove");
				/* 삭제라면 액션을 변경함. */
			} else if (operation === 'list') {
				formObj.attr("action", "/admin/product/list").attr("method", "get");
				var typeTag = $("input[name='type']").clone();
				formObj.empty();//폼의 내용들 비우기.
			} else if (operation === 'modify') {
				var fileName = $(".uploadResult ul li").data("filename");
				if(fileName != null){
				var uuid = $(".uploadResult ul li").data("uuid");
				var path = $(".uploadResult ul li").data("path");
				var type = $(".uploadResult ul li").data("type");
				
				if(path != null){
					path = path.replace(new RegExp(/\\/g),"/");
				}
				if(type == null){
					type = null;
				}
				var str = "";
					str += "<input type='hidden' name='attachImage.fileName'";
					str += ' value="';
					str += fileName;
					str += '"/>';
					
					str += "<input type='hidden' name='attachImage.uuid'";
					str += ' value="';
					str += uuid;
					str += '"/>';
					
					str += "<input type='hidden' name='attachImage.imagePath'";
					str += ' value="';
					str += path;
					str += '"/>';
					
					str += "<input type='hidden' name='attachImage.fileType'";
					str += ' value="';
					str += type;
					str += '"/>';
				
					console.log(str);
					
				formObj.append(str).submit();
				}
			}
			formObj.submit();
		});
	});
	</script>
	
<%@ include file="../includes/footer.jsp"%>