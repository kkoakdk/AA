<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>게시글 수정하기</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/common.css" />" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>
	<script>
	//function doUpd() {
	//}
	
		$(document).ready(function() {
	
			
			$('#upd').on('click', function(){
				
			var frm = document.updateForm;
			//; 타이틀의 값을 가져온다
			var title =  $('#btitle').val();
			if (title.length == 0) {
				alert("제목을 입력하세요.");
				$('#upd').focus();	
				return;
			}
			frm.content.value = ckEditor.getData();
			var content = frm.contents.value;
			if (content.length == 0) {
				alert("내용을 입력하세요.");
				frm.content.focus();
				return;
			}
	
			frm.action = "<c:url value ='/board/doUpd.do' />";
			frm.submit();

			
			});
		})
			
			
	
	

</script>
</head>
<body>



	<!-- wrap -->
	<div id="wrap">

		<!-- container -->
		<div id="container">

			<!-- content -->
			<div id="content">

				<!-- title board write -->
				<div class="title_board_write">게시글 수정</div>
				<!-- //title board write -->

				<!-- board_area -->
				<div class="board_area">
					<form method="post" name ="updateForm">
					
					<input type="hidden" name="boardSeq" value="${upd.board_seq }" />
						<input type="hidden" name="typeSeq" value="${upd.type_seq }" />
					
						<fieldset>
							<legend>게시글 수정</legend>

							<!-- board write table -->
							<table summary="표 내용은 게시글 수정 박스입니다."
								class="board_write_table">
								<caption>게시글 수정 박스</caption>
								<colgroup>
									<col width="20%" />
									<col width="80%" />
								</colgroup>
								<tbody>
									<tr>
										<th class="tright"><label for="board_write_name">글번호</label></th>
										<td class="tleft">
											${upd.board_seq}</td>
									</tr>
									<tr>
										<th class="tright"><label for="board_write_name">이름</label></th>
										<td class="tleft">
											${upd.member_nick}</td>
									</tr>
									<tr>
										<th class="tright"><label for="board_write_title">제목</label></th>
										<td class="tleft">
											<input type="text" id="btitle" title="제목 입력박스" class="input_380" name="title" value="${upd.title}" />
										</td>
									</tr>
									<tr>
										<th class="tright"><label for="board_write_title">내용</label></th>
										<td class="tleft" >
											<div class="editer">
												<p><textarea id="contents" name="content" rows="30" cols="100">${upd.content}</textarea></p>																	
												<!-- CK에디터 불러오는 소스  -->
														<script>
														var ckEditor;
   															 ClassicEditor
     													    .create( document.querySelector( '#contents' ) )
       													    .then( editor =>  {
     													   	ckEditor = editor
 													   	 })
      													  .catch( error => {
           												 console.error( error );
       													 });
														</script>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<!-- //board write table -->

							<!-- bottom button -->
							<div class="btn_bottom">
								<div class="btn_bottom_right">
								<a href="<c:url value='/board/list.do'/>">	
									<input type="button" value="목록으로" title="목록으로" /></a>
									<input type="button" value="완료" title="완료" id ="upd"/>
								<!--  <input type="button" value="완료" title="완료" onclick ="doUpd()"/>  -->
								</div>
							</div>
							<!-- //bottom button -->

						</fieldset>
					</form>
				</div>
				<!-- //board_area -->

			</div>
			<!-- //content -->

		</div>
		<!-- //container -->

	</div>
	<!-- //wrap -->

</body>
</html>