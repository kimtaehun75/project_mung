<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
<style type="text/css">
	.filebox label {
  display: inline-block;
  padding: .5em .75em;
  color: #fff;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #5cb85c;
  cursor: pointer;
  border: 1px solid #4cae4c;
  border-radius: .25em;
  -webkit-transition: background-color 0.2s;
  transition: background-color 0.2s;
}

.filebox label:hover {
  background-color: #6ed36e;
}
</style>
<script type="text/javascript"
	src="../../resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        //전역변수
        var obj = [];              
        //스마트에디터 프레임생성
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: obj,
            elPlaceHolder: "editor",
            sSkinURI: "../../resources/editor/SmartEditor2Skin.html",
            htParams : {
                // 툴바 사용 여부
                bUseToolbar : true,            
                // 입력창 크기 조절바 사용 여부
                bUseVerticalResizer : true,    
                // 모드 탭(Editor | HTML | TEXT) 사용 여부
                bUseModeChanger : true
            },
            fOnAppLoad : function(){
            	$(document).ready(function(){
        			
        			var csrfHeaderName = "${_csrf.headerName}";
        			var csrfTokenValue = "${_csrf.token}";
        			var formObj = $("form[role='form']");
        			$(document).ajaxSend(function(e,xhr,options){
        				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
        			});
        			
        			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|txt)$");
        			// 정규표현식. 일부 파일의 업로드 제한.
        			
        			var maxSize = 5242880; // 5MB
        			
        			function showImage(uploadImageArr){
        				if(!uploadImageArr || uploadImageArr.length == 0){
        					return;
        				}
        				console.log("이미지 : "+uploadImageArr);
        				var str="";
        			
        			$(uploadImageArr).each(function(i,obj){
        				var fileCallPath = decodeURIComponent(obj.imagePath+"/"+obj.uuid+"_"+obj.fileName);
        				
        				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
        				console.log(fileLink);
        				
        				str += "<img src='http://localhost:8090/resources/images/"+fileLink;
        				str += "'>";
        				
        			});
        			obj.getById["editor"].exec("PASTE_HTML", [str]);
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
        			
        			$("#ex_file").on("change",function(e){
        				var formData = new FormData();
        				var inputImage = $("input[id='ex_file']");
        				var files = inputImage[0].files;
        				
        				for(var i=0;i<files.length;i++){
        					if(!checkExtension(files[i].name,
        							files[i].size)){
        						return false;
        					}
        					formData.append("uploadImage",files[i]);
        				}
        				
        				$.ajax({
        					url : '/uploadImagesAction',
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
        			});
        			$("#register_Btn").click(function(e){
        				e.preventDefault();
        				obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
        				
        				
        				
        				formObj.submit();
        				
        			});
        		});
            }
        });     
    });
</script>

	<div>
		<form action="./insertFaq" method="post" role="form">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<input type="hidden" id="" name="userid" value="${userid}">
			<table style="width: 60%; margin: auto;">
			<tr>
				<td>
					<div class="form-group">
						제목 
						<input class="form-control" type="text" id="" name="title"
							style="width: 100%;" required/>
					</div>
				</td>
			</tr>
			<tr>
				<td><label for="">질문 내용</label>
					<div style="display:inline-block; float:right;" class="filebox">
						<label for="ex_file">사진추가</label>
						<input type="file" id="ex_file" hidden>
					</div>
					<div class="form-group">
						<textarea name="content" id="editor"
							style="width: 100%; height: 500px;"></textarea>							
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="inputArea">
						<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
					</div>
				</td>
			</tr>
		</table>
		</form>
	</div>
<%@ include file="../../admin/includes/footer.jsp"%>