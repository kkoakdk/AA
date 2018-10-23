<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<style type="text/css">
.board_search {
	margin-bottom: 5px;
	text-align: right;
	margin-right: -7px;
}
.board_search .btn_search, #btnWrite{
	height: 20px;
	line-height: 20px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #e9e9e9;
	background-color: #f7f7f7;
	font-size: 12px;
	font-family: Dotum, "돋움";
	font-weight: bold;
	text-align: center;
	cursor: pointer;
}
select {
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin-left : 3px;
	padding: 0;
	font-size: 12px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #d7d7d7;
	color: #7f7f7f;
	/* padding: 0 5px; */
	vertical-align: middle;
}
</style>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>

<script type="text/javascript">

$(document).ready(function(){
	// Tab
	$( "#tabs" ).tabs();
	
	$('#btnSearch').click(function(){
		//아이디
			var searchType = $('#searchType option:selected').val();
		
		//닉네임
			var searchText = $('#searchText').val();
		$('#boardGrid').jqGrid('setGridParam', 
		{
			postData : {
				searchType : searchType,
				searchText : searchText
			},
			page : 1
		}	
		).trigger("reloadGrid");

	});

	$("#boardGrid").jqGrid({
		url : '<c:url value="/board/gList.do" />',
		datatype : "json",
		jsonReader : {
			id : "board_seq"
		},
		prmNames : {
			id : "board_seq"
		},
		//datatype: "local",
		//data: myData,
		colModel : [ {
			label : '글번호',
			name : 'board_seq',
			width : 100,
			align : 'center'
		}, {
			label : '제목',
			name : 'title',
			width : 200,
			align : 'center'
		}, {
			label : '작성자',
			name : 'member_nick',
			width : 130,
			align : 'center'
		}, {
			label : '조회수',
			name : 'hits',
			width : 100,
			align : 'center'
		},
		{
			label : '작성일시',
			name : 'createDate',
			width : 150,
			align : 'center'

		}],

		rownumbers : true,// 그리드 목록에 대한 순번
		sortname : "boardSeq", //기본 정렬 컬럼
		sortorder : 'desc', //기본 정렬 컬럼
		scrollrows : true, //스크롤 유뮤
		viewrecords : true, //row 보기

		pager : "#boardGridPager",
//----------------------------------------------------------------------------
		onCellSelect : function(rowId, colIdx, content, event){
			
		/*	if(colIdx == 3){
			alert(content);
			}else{
				alert("읽기");
			}
			console.log(rowId);
			console.log(colIdx);
			console.log(content);
		*/
		},
			
		onSelectRow: function(rowId, status, event){
		var url =	"<c:url value='/board/read.do?boardSeq="+rowId +"&typeSeq=2' />";
			window.location.href = url;
		}
//----------------------------------------------------------------------------	
	});
		
	
	$("#boardGrid").jqGrid('navGrid', "#boardGridPager", {
		edit : false,
		add : false,
		del : true,
		search : false,
		refresh : true,
		view : true
		
		
	});
	
});
	
	
</script>
<title></title>
</head>
<body>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">자유게시판(그리드)</a></li>
	</ul>
	<div id="tabs-1">
		<!-- content -->
		<div id="content">

			<!-- board_search -->
			<div class="board_search">
				<form name="searchForm" method="get">
					<select id="searchType" name="searchType" title="선택메뉴">
						<option value="1" selected="selected">전체</option>
						<option value="2">아이디</option>
						<option value="3">이메일</option>
					</select> 
					<input type="text" id="searchText" name="searchText" title="검색어 입력박스" class="input_100" /> 
					<input type="button" id="btnSearch" value="검색" title="검색버튼" class="btn_search" />
				</form>
			</div>

			
			<!-- //board_search -->

			<!-- board_area -->
			<div class="board_area board_search">
				<table id="boardGrid"></table>
  				<div id="boardGridPager"></div>
  												<c:if test="${sessionScope.memberId!=null}">
<a href="<c:url value='/board/goWritePage.do'/> ">
				<button id="btnWrite" style="margin-bottom:3px;">작성</button>
</a>
</c:if>

			</div>
			<!-- //board_area -->

		</div>
		<!-- //content -->
	</div>
	
	</body>
	</html>