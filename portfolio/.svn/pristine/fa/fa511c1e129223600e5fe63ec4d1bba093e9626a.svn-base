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

$(document).ready(function(){
	//Tab
	$( "#tabs" ).tabs();
});
</script>
<title></title>
</head>
<body>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">메인</a></li>
		<li><a href="#tabs-2">시간</a></li>
		<li><a href="#tabs-3">API</a></li>

	</ul>
	<div id="tabs-1">
		이 페이지는 아래 항목을 이용하여 구현하였습니다.<br/>
  		<ul class="page_desc">
			<li>Spring Framework 4.3.14.RELEASE</li>
			<li>myBatis 3.4.1</li>
			<li>jUnit 4.12</li>
		</ul>
		<a href="<c:url value='/member/goLogin.do' />" target="_parent">
		<h1>관리자 계정 (admin/admin)</h1>
		</a>
		<h5>(로그인 페이지기본값으로 설정되어 있음)</h5>
		<br><br>
		
		<br/>
		last update.... 2018. 03. 27 <br>
		<%@ page import="java.util.*, java.text.*"  %>
		

	</div>
	
	
	<div id="tabs-2">
<%
 Date now = new Date();
 SimpleDateFormat sf = new SimpleDateFormat("yyyy년  MM월  dd일  E요일  a hh:mm:ss");
 
 String today = sf.format(now);
%>
<%= now %><br>
<%= today %>
	</div>
	
	
	
		
<script src="https://api.myip.com"></script>
		<div id="tabs-3">
		

		
		
	</div>
	

	
	
</div>

</body>
</html>