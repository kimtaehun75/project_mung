<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>
.content img{
	max-width : 100%;
}
</style>
<div class="container">
	<div class="card shadow mb-4" style="float: center;">
		<div class="card-body">

			<div class="form-group">
				작성자<input class="form-control" name="userid" value="${free.userid}"
					readonly="readonly" style="width: 30%;" />
			</div>
			<div class="form-group">
				제목<input class="form-control" name="title" value="${free.title}"
					readonly="readonly" style="width: 100%;">
			</div>
			<div class="form-group">
				<div class="content">
					${free.content}
				</div>
			</div>
			<div>
				<button data-oper="list" class="btn btn-info">
					<!-- <a href="/board/list">  -->
					목록
					<!-- </a> -->
				</button>
				
					<!-- 인증된 사용자만 허가 -->
					<!-- 인증되었으면서 작성자가 본인 일때 수정 버튼 표시 -->
						<button class="btn btn-primary" data-oper="modify"> 
							<i aria-hidden="true"></i>수정
						</button>
						<button class="btn btn-warning" data-oper="remove"> 
							<i aria-hidden="true"></i>삭제
						</button>
			</div>
			<form id="operForm" action="/free/modify" method="get">
				<input type="hidden" id="bno" name="bno" value="${free.bno}" /> 
				<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
				<input type="hidden" name="amount" value="${cri.amount}" /> 
				<input type="hidden" name="type" value="${cri.type}"> 
				<input type="hidden" name="keyword" value="${cri.keyword}">
			</form>
			<!-- 폼을 생성해서 게시물번호를 숨김 값으로 전달. 
				나중에 현재 페이지 번호, 페이지당 게시물수, 검색어, 검색타입 추가 예정
				-->


			<!-- 덧글 시작 -->
			<br />
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i>댓글						
							<input type="text" 
							name="reply" 
							style="width:75%;" 
							placeholder="댓글을 입력해주세요">
							<sec:authorize access="isAuthenticated()">
								<button id="addReplyBtn"
									class="btn btn-primary btn-xs float-right">등록</button>
							</sec:authorize>
							<!-- 로그아웃 상태에서는 글을 읽을 수는 있지만,
							덧글을 추가할 수는 없음. -->
						</div>
						<br />

						<div class="panel-body">
							<ul class="chat">
								<li>댓글이 없어요! 힝!</li>
							</ul>
						</div>

						<div class="panel-footer">
						
						</div>
					</div>
				</div>
				<!-- 덧글 끝 -->
			</div>
		</div>
	</div>
</div>

<div class="modal fade" 
               id="myModal" 
               tabindex="-1" 
               role="dialog" 
               aria-labelledby="myModalLabel"
               aria-hidden="true">
               <div class="modal-dialog">
               	<div class="modal-content">
	               	<div class="modal-header">
	               		<button type="button" 
	               		class="close"
	               		data-dismiss="modal"
	               		aria-hidden="true">
	               		&times;
	               		</button>
	               		<h4 class="modal-title" id="myModalLabel">신고하기</h4>
	               	</div>
	               	<div class="modal-body">
		               	<div class="form-group">
			               	<label>대상</label>
			               	<input class="form-control" name=rpuser value="${free.userid}" readonly>
		               	</div>
		               	<div class="form-group">
			               	<label>작성자</label>
			               	<input class="form-control" name="userid" value="">
		               	</div>
		               	<div class="form-group">
			               	<label id="replyContent">신고 사유</label>
			               	<input class="form-control" name="content" value="" placeholder="신고사유를 입력해주세요.">
		               	</div>
	               	</div>
	               	<div class="modal-footer">
	               		<button
	               		id="modalRegisterBtn" 
	               		type="button"
	               		class="btn btn-primary"
	               		>
	               		신고
	               		</button>
	               		<button
	               		id="modalModifyBtn" 
	               		type="button"
	               		class="btn btn-primary"
	               		>
	               		수정
	               		</button>
	               		<button 
	               		id="modalCloseBtn"
	               		type="button"
	               		class="btn btn-default"
	               		>
	               		닫기
	               		</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	/* console.log("=======");
	console.log("js test");
	var bnoValue = '<c:out value="${board.bno}"/>'; */
	/* replyService.add({
		reply : "js test",
		replyer : "tester",
		bno : bnoValue
	}, function(result) {
		alert("result: " + result);
	}); */
	// 게시글을 읽을때 자동으로 댓글 1개 등록.
	/* replyService.getList(
			{bno:bnoValue,page:1}, function(list){
			for(var i=0, len=list.length||0;i<len;i++){
					console.log(list[i]);
				}
			}); */
	/* replyService.remove(12,function(count){
		console.log(count);
		
		if(count==="success"){
			alert("removed");
		}
	},function(err){
		alert("error");
	}); */
	
	/* replyService.update({
		rno:19,
		bno:bnoValue,
		reply:"ajax modify"
		}, function(result){
			alert("result: "+result);
		}); */
		
		/* replyService.get(39, function(data){
			console.log(data);
		}) */
		$(document).ready(function(){
			var bnoValue = '<c:out value="${free.bno}"/>';
			
			// reply Unorderd List
			var replyUL = $(".chat");
			var modifyBtn = $("#modifyBtn");
			var removeBtn = $("#removeBtn");
			var replyReportBtn = $("#reportBtn");
			var rpuser = '<c:out value="${free.userid}"/>';
			var userid=null;
			<sec:authorize access="isAuthenticated()">
			userid='<sec:authentication property="principal.username"/>';
			</sec:authorize>
			
			
			console.log("userid : "+userid);
			
			showList(1);
			
			function showList(page){
				replyService.getList(
						{bno:bnoValue,page:page||1}, 
						function(replyCnt,list){
							console.log("replyCnt : "+replyCnt);
							
							if(page== -1){
								// 페이지 번호가 음수 값 이라면,
								pageNum 
								= Math.ceil(replyCnt/10.0);
								// 덧글의 마지막 페이지 구하기.
								showList(pageNum);
								// 덧글 목록 새로고침(갱신)
								return;
							}
							
							var str="";
							if(list==null || 
									list.length==0){
								replyUL.html("");
								return;
							}
						for(var i=0, 
								len=list.length||0;
						i<len;i++){
								//console.log(list[i]);
								console.log("replyer : "+list[i].userid);
								console.log("userid : "+userid);
								
								str+="<li class='left ";
								str+="clearfix' data-rno='";
								str+=list[i].rno+"'>";
								str+="<div><div class='header' ";
								str+="><strong class='";
								str+="primary-font'>";
								str+=list[i].userid+"</strong>";
								
									str+="<img style='cursor:pointer;' width=15 height=15 src='http://localhost:8090/resources/images/수정사진.png' id='modifyBtn'>";
								
								str+="<small class='float-sm-right '>";
								
									str+="<img style='cursor:pointer;' width=15 height=15 src='http://localhost:8090/resources/images/x사진.png' id='removeBtn'>&nbsp;";
								
								//str+="text-muted'>";
								
								str+=replyService.displayTime(list[i].replyDate)+"</small></div>";
								str+="<p>"+list[i].reply;
								str+="</p></div></li>";
							}
						replyUL.html(str);
						showReplyPage(replyCnt);
						});
			}// end_showList
			
			
			var pageNum=1;
			var replyPageFooter = $(".panel-footer");
			//.panel-footer
			
			function showReplyPage(replyCnt){
				var endNum 
				=Math.ceil(pageNum/10.0)*10;
				var startNum=endNum-9;
				var prev=startNum != 1;
				var next=false;
				
				if(endNum *10 >= replyCnt){
					endNum = Math.ceil(replyCnt/10.0);
				}
				if(endNum * 10 < replyCnt){
					next=true;
				}
				
				var str
				="<ul class='pagination"; 
				str+=" justify-content-center'>";
				
				if(prev){
					str+="<li class='page-item'><a ";
					str+="class='page-link' href='";
					str+= (startNum-1);
					str+="'>이전</a></li>";
				}
				
				for(var i=startNum;i<=endNum;i++){
					var active = pageNum==i?"active":"";
					str+="<li class='page-item "+ active+"'><a class='page-link' ";
					str+="href='"+i+"'>"+i+"</a></li>";
				}
				
				if(next){
					str+="<li class='page-item'>";
					str+="<a class='page-link' href='";
					str+=(endNum+1)+"'>다음</a></li>";
				}
				
				str+="</ul>";
				console.log(str);
				replyPageFooter.html(str);
			}
			
			replyPageFooter.on("click","li a"
					,function(e){
				e.preventDefault();
				var targetPageNum=$(this).attr("href");
				pageNum=targetPageNum;
				showList(pageNum);
			});
			
			var modal = $("#myModal");
			var modalRegisterBtn = $("#modalRegisterBtn");
			var modalModifyBtn = $("#modalModifyBtn");
			var rpuserInput = $("input[name='rpuser']");
			var useridInput = $("input[name='userid']");
			var replyInput = $("input[name='reply']");
			var contentInput = $("input[name='content']");
			
			modalRegisterBtn.on("click",function(){
				var report = {
						userid:useridInput.val(),
						rpuser:rpuserInput.val(),
						content:contentInput.val()
				};
					console.log(report);	
				
				$.ajax({
					type:'post',
					url:'/replies/report',
					data:JSON.stringify(report),
					contentType:"application/json; charset=utf-8",
					// 설정
					success : function(result){
							if(result == 'success'){
								alert("신고 접수가 완료되었습니다.");
								modal.modal("hide");
							}
						}
						
					})
					
			});
			
			$("#addReportBtn").on("click",function(e){
				// 덧글 쓰기 버튼을 클릭한다면,
				// 모달의 모든 입력창을 초기화
				
				console.log("click");
				
				
				$("#myModalLabel").text("신고하기");
				$("#replyContent").text("신고 사유");
				
				modal.find("input[name='rpuser']").val(rpuser);
				modal.find("input[name='userid']").val(userid);
				modal.find("input[name='userid']").attr("readonly","readonly");
				
				if(modal.find("input[name='rpuser']").val() == 
					modal.find("input[name='userid']").val()){
					alert("자신을 신고할 수는 없습니다.");
					return;
				}
				// closest : 선택 요소와 가장 가까운 요소를 지정.
				// 즉, modalInputReplyDate 요소의 가장 가까운
				// div를 찾아서 숨김. (날짜창 숨김)
				modal.find("button[id != 'modalCloseBtn']").hide();
				// 모달창에 버튼이 4개 인데, 닫기 버튼을 제외하고 숨기기.
				
				modalRegisterBtn.show(); // 등록 버튼은 보여라.
				$("#myModal").modal("show");// 모달 표시.
			});
			
			replyUL.on("click","img[id='reportBtn']",function(e){
				// 덧글 쓰기 버튼을 클릭한다면,
				// 모달의 모든 입력창을 초기화
				
				if(userid == null){
					alert("로그인 후 이용해주시기 바랍니다");
					return;
				}
				
				var rno = $(this).parents("li").data("rno");
				
				console.log(rno);
				
				$("#myModalLabel").text("신고하기");
				$("#replyContent").text("신고 사유");
				
				replyService.get(rno,function(reply){
					console.log(reply.userid);
					modal.find("input[name='rpuser']").val(reply.userid);
					modal.find("input[name='rpuser']").attr("readonly","readonly");
				});
				
				modal.find("input[name='userid']").val(userid);
				modal.find("input[name='userid']").attr("readonly","readonly");
				
				// closest : 선택 요소와 가장 가까운 요소를 지정.
				// 즉, modalInputReplyDate 요소의 가장 가까운
				// div를 찾아서 숨김. (날짜창 숨김)
				modal.find("button[id != 'modalCloseBtn']").hide();
				// 모달창에 버튼이 4개 인데, 닫기 버튼을 제외하고 숨기기.
				
				modalRegisterBtn.show(); // 등록 버튼은 보여라.
				$("#myModal").modal("show");// 모달 표시.
			});
			
			replyUL.on("click","img[id='modifyBtn']",function(e){
				// 덧글 쓰기 버튼을 클릭한다면,
				// 모달의 모든 입력창을 초기화
				var rno = $(this).parents("li").data("rno");
				
				console.log(rno);
				
				$("#myModalLabel").text("수정하기");
				$("#replyContent").text("댓글");
				
				
				replyService.get(rno,function(reply){
					console.log(reply.userid);
					modal.find("input[name='reply']").val(reply.reply);
					modal.find("input[name='userid']").val(reply.userid);
					modal.find("input[name='userid']").attr("readonly","readonly");
				});
				
				modal.find("input[name='rpuser']").closest("div").hide();
				modal.find("input[name='content']").attr("placeholder","수정할 내용을 입력해 주세요.");
				// closest : 선택 요소와 가장 가까운 요소를 지정.
				// 즉, modalInputReplyDate 요소의 가장 가까운
				// div를 찾아서 숨김. (날짜창 숨김)
				modal.find("button[id != 'modalCloseBtn']").hide();
				// 모달창에 버튼이 4개 인데, 닫기 버튼을 제외하고 숨기기.
				
				modalModifyBtn.show(); // 수정 버튼은 보여라.
				$("#myModal").modal("show");// 모달 표시.
				
				
				modalModifyBtn.on("click",function(e){
					var reply = {
							rno : rno,
							reply : contentInput.val(),
							userid : useridInput.val()
					};
					
					replyService.update(reply,function(result){
						if(result == 'success'){
							alert("댓글이 수정되었습니다.");	
						}
						modal.modal("hide");
						showList(pageNum);
					});
				});
			});
			
			replyUL.on("click","img[id='removeBtn']",function(e){
				// 덧글 쓰기 버튼을 클릭한다면,
				// 모달의 모든 입력창을 초기화
				var rno = $(this).parents("li").data("rno");
				var userid = $(this).parents("li").find("strong").text();
				console.log(rno);
				console.log(userid);
				
				var check = confirm("삭제하시겠습니까?");
				
				if(check){
					replyService.remove(rno,userid,function(result){
						if(result == 'success'){
							alert("삭제가 완료되었습니다.");
						}
						showList();
					});
				}
			});
			
			
			
			$("#modalCloseBtn").on("click",function(e){
				modal.modal("hide");
				// 모달 닫기 버튼을 클릭하면 모달창을 숨김
			});
			
			var csrfHeaderName="${_csrf.headerName}";
			var csrfTokenValue="${_csrf.token}";
			
			$(document).ajaxSend(function(e,xhr,options){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			});//csrf 값을 미리 설정해 두고, ajax 처리시마다 이용.
			
			$("#addReplyBtn").on("click",function(e){
				// 덧글 등록 버튼을 눌렀다면,
				var reply={
						reply:replyInput.val(),
						userid:userid,
						bno:bnoValue
				}; // ajax로 전달할 reply 객체 선언 및 할당.
				
				replyService.add(reply, function(result){
					if(result == 'success')
						alert("댓글이 등록되었습니다.");
					// ajax 처리후 결과 리턴.
					//showList(1); // 덧글 목록 갱신.
					replyInput.val("");
					showList(-1); // 목록 자동 새로고침.
				});
			});
			
			
			
		}); // end_ready
</script>

<script>
	/* $(document).ready(function() {
		console.log("history.state : " + history.state);
	}); */
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/admin/free/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/admin/free/free");
			operForm.submit();
		});
		$("button[data-oper='remove']").on("click", function(e) {
			var check = confirm("게시물을 삭제하시겠습니까?");
			if(check){
				operForm.append("<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token}'/>");
				operForm.attr("action","/admin/free/remove"); 
				operForm.attr("method","post");
				operForm.submit();
			}
		});
		/* 폼에서 어떤 버튼이 눌렸는지 확인하여,
		액션을 변경하거나, 일부 값을 삭제하여 전송.*/
		
		
	});
</script>
<%@ include file="../includes/footer.jsp"%>