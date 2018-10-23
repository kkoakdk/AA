<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>

<script type="text/javascript">
var adjustSize = false;

$(document).ready(function(){
	$('#erdDialog').hide();
	
	
$(document).ready(function(){
	//Tab
	$( "#tabs" ).tabs();
	
	
$('#btnErd').on('click', function(){
	$("#erdDialog").dialog({
		// my : dialog 위치
		// at : dialog() 왼쪽 상단 모서리 위치
		// of : 위치시킬 element
			position : { my:"center top", at:"top", of:"#tabs-1" },
			open : function() {
				$('#erdDialog').show();
			if(!adjustSize){
				$('#erdDialog').dialog('option', 'width', $('#erdImage').width()*1);
				$('#erdDialog').dialog('option', 'height', $('#erdImage').height()*1);
				$('#erdImage').css({width:'100%'});
				adjustSize = true;
			}
		}
	});
	//{key : value, key1 : value1}
		});
	});
});
</script>
<title></title>
</head>
<body>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">개발노트</a></li>


	</ul>
	<div id="tabs-1">

  		<ul class="page_desc">
			<li>
			ERD보기
			<input type="button" id="btnErd" value="보기" />
			</li>
			
			<li>
			사이트 DB 모델링 (MWB)
			
			<a href="<c:url value='/file/downloadErd.do' />">
				<input type="button" value="다운로드">
			</a>	
			</li>
		</ul>


		<%@ page import="java.util.*, java.text.*"  %>
	</div>

	<div id="erdDialog" title="사이트 모델링 PNG">
	<img id="erdImage" src="<c:url value='/resources/ERD.PNG' />" />
	</div>

</body>
</html>