<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
	<div>
		<form action="./saleUpload" method="post" role="form">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div align="center">
				<div class="inputArea">
					<label for="sNumber">상품번호</label>
						<input type="text" value="${count+1 }" readonly>
				</div>
				
				<div>
					<label>분류</label> 
					<select name="cate.cateno">
						<option value="">--</option>
						<c:forEach items="${list}" var="cate">
							<option value="${cate.cateno }">${cate.cateName }</option>	
						</c:forEach>
					</select>
				</div>

				<div class="inputArea">
					<label for="salename">상품이름</label> 
					<input type="text" id="" name="saleName" />
				</div>

				<div class="inputArea">
					<label for="cost">상품가격</label> 
					<input type="text" id="" name="cost" />
				</div>

				
				
				<div class="inputArea">
					<label for="amount">상품수량</label>
					<input type="text" id="" name="amount" />
				</div>
				
				<label for="content">상품 내용</label> 
				
				<div class="inputArea">
					<textarea rows="10" cols="50" name="content"></textarea>
				</div>
				<br>
				<div>
					<label for="image">이미지</label>
					<input type="file" name="uploadImage" multiple>
				</div>
				<div class="uploadResult">
					<ul>
					
					</ul>
				</div>
				<br>
				
				<div class="inputArea">
					<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
				</div>
			</div>
		</form>
	</div>
	
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
	$(document).ready(function(){
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
	
			// 글 등록 시 첨부파일도 같이 db로 저장되는 과정
			
			var fileName = $(".uploadResult ul li").data("filename");
			var uuid = $(".uploadResult ul li").data("uuid");
			var path = $(".uploadResult ul li").data("path");
			var type = $(".uploadResult ul li").data("type");
			
			path = path.replace(new RegExp(/\\/g),"/");
			
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
				str += '"/>"';
			
				console.log(str);
				
			formObj.append(str).submit();
		});
	});
	</script>
	
	
<%@ include file="../../admin/includes/footer.jsp"%>