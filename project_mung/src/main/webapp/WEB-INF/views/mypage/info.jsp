<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mypagesidebar.jsp"%>
<script 
   src="http://dmaps.daum.net/map_js_init/postcode.v2.js">
</script>
<body>
<div class="container">
   <div class="card shadow mb-4" style="float:center;">
      <div class="card-body">
   <form method="POST" action="/member/modify" role="form">
      <input type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}">
      <input type="hidden" name="userno" value="${member.userno}">
      <h2>회원정보 수정</h2>
      <label for="image">프로필 사진</label>
      <input type="file" name="uploadImage" multiple>
      <div class="uploadResult">
         <ul style="list-style:none;">
            <c:if test="${member.attachImage.fileName != null}">
               <li data-path='${member.attachImage.imagePath }'
               data-uuid='${member.attachImage.uuid}'
               data-filename='${member.attachImage.fileName }'
               data-type='${member.attachImage.fileType}'>
               <div>
                  <img class='img-profile rounded-circle' width=150 height=150 src='http://localhost:8090/resources/images/${member.attachImage.imagePath}/${member.attachImage.uuid}_${member.attachImage.fileName}'>
                  <b data-file='${member.attachImage.imagePath }/${member.attachImage.uuid}_${member.attachImage.fileName}'
                  data-type='file'>
                  [x]
                  </b>
               </div>
               </li>
            </c:if>
            <c:if test="${member.attachImage.fileName == null}">
               <li>
                  <div>
                     <img class='img-profile rounded-circle' width=150 height=150 src='http://localhost:8090/resources/images/기본프로필.png'>
                  </div>
               </li>
            </c:if>
         </ul>
      </div>
      <!-- 아이디 -->
      <div class="form-group">
         <label for="userid">아이디</label> 
         <input type="hidden" id="userid" name="userid" value="${member.userid }">
         <b>${member.userid}</b>
      </div>
      <!-- 비밀번호 -->
      <div class="form-group">
         <label for="userpw">비밀번호</label> 
         <a href="/mypage/changepw">변경하기</a>
      </div>
      <!-- 이름 -->
      <div class="form-group">
         <label for="username">이름</label> 
         <input type="hidden" name="userName" id="username" value="${member.userName}">
         <b>${member.userName}</b>
      </div>
      <!-- 생년월일 -->
      <div class="form-group required">
         <label for="birth">생년월일</label> 
         <input type="text"
            class="form-control" id="birth" name="birth" value="${member.birth }"
            placeholder="ex) 19990415" required style="width:60%;">
         <div class="check_font" id="birth_check"></div>
      </div>
      <!-- 본인확인 이메일 -->
      <div class="form-group">
         <label for="email">이메일</label> 
         <input type="text"
            class="form-control" name="email" id="useremail" placeholder="E-mail" value="${member.email }"
            required style="width:60%;">
         <!-- <input type="text" style="margin-top: 5px;"class="email_form" name="email_confirm" id="email_confirm" placeholder="인증번호를 입력해주세요!" required>
                  <button type="button" class="btn btn-outline-danger btn-sm px-3" onclick="confirm_email()">
                     <i class="fa fa-envelope"></i>&nbsp;인증
                  </button>&nbsp;
                  <button type="button" class="btn btn-outline-info btn-sm px-3">
                     <i class="fa fa-envelope"></i>&nbsp;확인
                  </button>&nbsp; -->
         <div class="check_font" id="email_check"></div>
      </div>
      <!-- 휴대전화 -->
      <div class="form-group">
         <label for="phone">휴대전화 ('-' 없이 번호만 입력해주세요)</label> 
         <input
            type="text" class="form-control" id="userphone" name="phone"
            value="${member.phone}" placeholder="Phone Number" required style="width:60%;">
         <div class="check_font" id="phone_check"></div>
      </div>
      <div class="form-group">                   
            <input class="form-control" style="width: 20%; display: inline;" placeholder="우편번호" name="addr_1" id="addr1" type="text" value="${member.addr_1 }" readonly="readonly" >
            <button type="button" class="btn btn-primary px-3" onclick="execPostCode();" >
               <i class="fa fa-search"></i> 우편번호 찾기
            </button>                               
         </div>
         <div class="form-group">
               <input class="form-control" style="top: 5px; width:60%;" placeholder="도로명 주소" name="addr_2" id="addr2" type="text" value="${member.addr_2 }" 
               readonly="readonly"/>
         </div>
         <div class="form-group">
               <input class="form-control" placeholder="상세주소" name="addr_3" id="addr3" type="text" value="${member.addr_3}" style="width:60%;"/>
      </div>
      <div class="reg_button">
         <a class="btn btn-danger px-3"
            href="/"> <i
            class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
         </a>&emsp;&emsp;
         <button class="btn btn-primary px-3" id="reg_submit">
            <i class="fa fa-heart pr-2" aria-hidden="true"></i>수정하기
         </button>
      </div>
   </form>
   </div>
   </div>
   </div>
   <!-- ==============================SCRIPT======================================= -->

   <script>
      //모든 공백 체크 정규식
      var empJ = /\s/g;
      //아이디 정규식
      var nameJ = /^[가-힣]{2,6}$/;
      // 이메일 검사 정규식
      var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
      // 휴대폰 번호 정규식
      var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
                  // 휴대전화
                  $('#userphone').blur(function(){
                     if(phoneJ.test($(this).val())){
                        $("#phone_check").text('');
                     } else {
                        $('#phone_check').text('휴대폰번호를 확인해주세요 :)');
                        $('#phone_check').css('color', 'red');
                     }
                  });
                  
                  // 생일 유효성 검사
                  var birthJ = false;
                  // 생년월일   birthJ 유효성 검사
                  $('#birth').blur(function(){
                     var dateStr = $(this).val();      
                      var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
                      var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
                      var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
                      var today = new Date(); // 날짜 변수 선언
                      var yearNow = today.getFullYear(); // 올해 연도 가져옴
                      
                     
                      if (dateStr.length <=8) {
                        // 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
                         if (1900 > year || year > yearNow){
                            
                            $('#birth_check').text('생년월일을 확인해주세요 :)');
                           $('#birth_check').css('color', 'red');
                            
                         }else if (month < 1 || month > 12) {
                               
                            $('#birth_check').text('생년월일을 확인해주세요 :)');
                           $('#birth_check').css('color', 'red'); 
                         
                         }else if (day < 1 || day > 31) {
                            
                            $('#birth_check').text('생년월일을 확인해주세요 :)');
                           $('#birth_check').css('color', 'red'); 
                            
                         }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
                             
                            $('#birth_check').text('생년월일을 확인해주세요 :)');
                           $('#birth_check').css('color', 'red'); 
                             
                         }else if (month == 2) {
                             
                               var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                               
                             if (day>29 || (day==29 && !isleap)) {
                                
                                $('#birth_check').text('생년월일을 확인해주세요 :)');
                              $('#birth_check').css('color', 'red'); 
                            
                           }else{
                              $('#birth_check').text('');
                              birthJ = true;
                           }//end of if (day>29 || (day==29 && !isleap))
                             
                         }else{
                            
                            $('#birth_check').text(''); 
                           birthJ = true;
                        }//end of if
                        
                        }else{
                           //1.입력된 생년월일이 8자 초과할때 :  auth:false
                           $('#birth_check').text('생년월일을 확인해주세요 :)');
                           $('#birth_check').css('color', 'red');  
                        }
                     }); //End of method /*
                  
                  
                     // 가입하기 실행 버튼 유효성 검사!
                     var inval_Arr = new Array(3).fill(false);
                     $('#reg_submit').click(function(){
                        // 이메일 정규식
                        if (mailJ.test($('#useremail').val())){
                           console.log(mailJ.test($('#useremail').val()));
                           inval_Arr[0] = true;
                        } else {
                           inval_Arr[0] = false;
                        }
                        // 휴대폰번호 정규식
                        if (phoneJ.test($('#userphone').val())) {
                           console.log(phoneJ.test($('#userphone').val()));
                           inval_Arr[1] = true;
                        } else {
                           inval_Arr[1] = false;
                        }
                        // 생년월일 정규식
                        $("#birth").focus();
                        $("#birth").blur();
                        if (birthJ) {
                           console.log(birthJ);
                           inval_Arr[2] = true;
                        } else {
                           inval_Arr[2] = false;
                        }
                        
                        var validAll = true;
                        for(var i = 0; i < inval_Arr.length; i++){
                           
                           if(inval_Arr[i] == false){
                              validAll = false;
                           }
                        }
                        
                        var id = $('#username').val();
                        
                        if(validAll == false){ // 유효성 모두 통과
                           alert('입력한 정보들을 다시 한번 확인해주세요 :)')
                           return false;
                        }
                        
                        var formObj = $("form[role='form']");
                        
                        var fileName = $(".uploadResult ul li").data("filename");
                        var uuid = $(".uploadResult ul li").data("uuid");
                        var path = $(".uploadResult ul li").data("path");
                        var type = $(".uploadResult ul li").data("type");
                        var userno = formObj.find("input[name='userno']").val();
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
                           
                           str += "<input type='hidden' name='attachImage.userno'";
                           str += ' value="';
                           str += userno;
                           str += '"/>"';
                        
                           console.log(str);
                           
                        formObj.append(str).submit();
                     });                     
      
      </script>
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
            str += "<img class='img-profile rounded-circle' width=150 height=150 src='http://localhost:8090/resources/images/"+fileLink;
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
      <script type="text/javascript">

<!--

function popupOpen(){
   var popUrl = "/mypage/info";   //팝업창에 출력될 페이지 URL
   var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
      
   window.open(popUrl,"",popOption);
   }
</script>               
      <script>
      function execPostCode() {
               new daum.Postcode({
                   oncomplete: function(data) {
                      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
       
                      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
       
                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraRoadAddr += data.bname;
                      }
                      // 건물명이 있고, 공동주택일 경우 추가한다.
                      if(data.buildingName !== '' && data.apartment === 'Y'){
                         extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                      if(extraRoadAddr !== ''){
                          extraRoadAddr = ' (' + extraRoadAddr + ')';
                      }
                      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                      if(fullRoadAddr !== ''){
                          fullRoadAddr += extraRoadAddr;
                      }
       
                      // 우편번호와 주소 정보를 해당 필드에 넣는다.
                      console.log(data.zonecode);
                      console.log(fullRoadAddr);
                      
                      
                      $("[name=addr_1]").val(data.zonecode);
                      $("[name=addr_2]").val(fullRoadAddr);
                      
                      /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                      document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                      document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
                  }
               }).open();
           }
   </script>

</body>
<%@ include file="../includes/footer.jsp"%>