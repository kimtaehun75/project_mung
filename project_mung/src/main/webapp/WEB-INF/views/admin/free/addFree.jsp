<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../../admin/includes/header.jsp"%>
<%@ include file="../../admin/includes/nav.jsp"%>
<body>
	<form action="./insertBoard.do" method="post" id="insertBoardFrm"
		enctype="multipart/form-data">
		<table style="margin:auto;">
			<tr>
			<td><h2>자유게시판</h2></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" id="title" name="title"
					style="width: 650px" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="editor" id="editor"
						style="width: 600px; height: 400px;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" id="insertBoard"
					value="등록" /></td>
			</tr>
		</table>
	</form>


<!--=========================================SCRIPT====================================  -->
	<script src="https://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript"
		src="../../resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(function() {
			//전역변수
			var obj = [];
			//스마트에디터 프레임생성
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : obj,
				elPlaceHolder : "editor",
				sSkinURI : "../../resources/editor/SmartEditor2Skin.html",
				htParams : {
					// 툴바 사용 여부
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부
					bUseModeChanger : true
				}
			});
			//전송버튼
			$("#insertBoard").click(function() {
				//id가 smarteditor인 textarea에 에디터에서 대입
				obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
				//폼 submit
				$("#insertBoardFrm").submit();
			});
		});
	</script>
</body>
<%@ include file="../../admin/includes/footer.jsp"%>
