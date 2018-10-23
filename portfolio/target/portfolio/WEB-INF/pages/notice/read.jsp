<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>게시물 상세페이지</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/common.css" />" />
<script type="text/javascript">
	
		//j쿼리
		$(document).ready(function(){
	var msg = '${msg}';
	function init() {
		if(msg != ''){
			alert(msg);
		}		
	}
	
			$('#del').on('click', function(){
		//id = del인 버튼을 눌렀을때 기능구현  			
			if(confirm("삭제하겠습니까?")){
				var frm = document.readForm;
				
				
			frm.action = "<c:url value='/notice/del.do'/>";
			frm.submit();
				
			}
		});
	});
	
	
	
</script>

</head>
 <body> <!--onload="intin()">    @@@@@@@@@@@@@@  열자마자 실행되는것!@@@@@@ -->

	<!-- wrap -->
	<div id="wrap">

		<!-- container -->
		<div id="container">

			<!-- content -->
			<div id="content">

				<!-- title board detail -->
				<div class="title_board_detail">게시물 보기</div>
				<!-- //title board detail -->

				<!-- board_area -->
				<div class="board_area">
				
					<form name="readForm" method="post">
					
					<input type="hidden" name="boardSeq" value="${readAtcl.board_seq }" />
						<input type="hidden" name="typeSeq" value="${readAtcl.type_seq }" />

					
						<fieldset>
							<legend>Ses & Food 게시물 상세 내용</legend>

						
							<!-- board detail table -->
							<table summary="표 내용은 Ses & Food 게시물의 상세 내용입니다." class="board_detail_table">
								<caption>Ses & Food 게시물 상세 내용</caption>
								<colgroup>
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
								</colgroup>
								<tbody>
								<tr>
								<th class="tright">게시글 번호</th>
								<td  class="tleft"  colspan="5" > ${readAtcl.board_seq} </td>
								</tr>
									<tr>
										<th class="tright">제목</th>
										<td colspan="5" class="tleft">${readAtcl.title}</td>
									</tr>
									<tr>
										<th class="tright">작성자</th>
										<td colspan="5" class="tleft">${readAtcl.member_nick}</td>
									</tr>
									<tr>
										<th class="tright">작성일</th>
										<td>${readAtcl.create_date}</td>
										<th class="tright">조회수</th>
										<td class="tright">${readAtcl.hits}</td>
										<th class="tright">추천</th>
										<td class="tright">0</td>
										
						
									</tr>
									<tr>
										<td colspan="6" class="tleft">
											<div class="body">
											
												${readAtcl.content}
											<!-- 	
											<c:out value='${readAtcl.content}' /> 태그까지 출력함 -->
											</div>
										</td>
									</tr>
	 	<c:if test="${ !empty files}">
									<c:forEach items="${files}" var="file" varStatus="vs" >
									 <tr>
										<th class="tcenter">첨부파일 ${vs.count}</th>
										<td colspan="3" style="text-align:Left;"> 
						<c:choose>
										<c:when test="${file.linked == 1 }">
						 					${file.filename} (서버에 파일을 찾을 수 없습니다.)										
										</c:when>
										
										<c:otherwise> 
											<a href = '<c:url value= "/notice/donwload.do?fileIdx=${file.file_idx }"/>' />	
											${file.filename}(${file.file_size}bytes) 
										</c:otherwise>
						</c:choose>
										</td>
									</tr>     
									</c:forEach>	
		</c:if>							
								</tbody>
							</table>
							<!-- //board detail table -->

							<!-- bottom button -->
							<div class="btn_bottom">
								<div class="btn_bottom_left">
									<input type="button" value="추천하기" title="추천하기" />
								</div>
								<div class="btn_bottom_right">
								
								<c:if test ="${sessionScope.memberId == readAtcl.member_id }">
								
								<a href="<c:url value='/notice/goUpd.do?boardSeq=${readAtcl.board_seq}&typeSeq=${readAtcl.type_seq}'/>">
									<input type="button" value="수정" title="수정"/></a>
									<input type="button" value="삭제" title="삭제" id="del"/>
									<!-- <input type="button" value="삭제" title="삭제" onclick="del()"/> -->
								</c:if>
								<a href="<c:url value='/notice/listNotice.do'/>">
									<input type="button" value="목록" title="목록" onClick="history.back()" />
								</a>	
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