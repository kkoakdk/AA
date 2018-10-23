<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>로그인 및 회원가입</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/login.css" />" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript">



	$(document).ready(function() {
		var panelOne = $('.form-panel.two').height(), 
			panelTwo = $('.form-panel.two')[0].scrollHeight;
	
		$('.form-panel.two').not('.form-panel.two.active').on('click', function(e) {
			e.preventDefault();
	
		    $('.form-toggle').addClass('visible');
		    $('.form-panel.one').addClass('hidden');
		    $('.form-panel.two').addClass('active');
		    $('.form').animate({
		      'height': panelTwo
		    }, 200);
		});
	
		$('.form-toggle').on('click', function(e) {
		    e.preventDefault();
		    $(this).removeClass('visible');
		    $('.form-panel.one').removeClass('hidden');
		    $('.form-panel.two').removeClass('active');
		    $('.form').animate({
		      'height': panelOne
		    }, 200);
		});
		
		
		
		
		
		
		$('#reg').on('click', function(){
			
			var joinForm = document.joinForm;
			var id = joinForm.id.value;
			var pw = joinForm.pw.value;
			var rePw = document.getElementById("rePw").value;
			var name = joinForm.name.value;
			var email = joinForm.email.value;
			
			             
			var regExp = /^[a-z]+[a-z0-9]{3,20}$/g;
			if(id == null || id == ""){
				alert("아이디를 입력해주세요.");
				joinForm.id.focus();
				return;
			}
			if(id.match(regExp) == null){
				alert("아이디 형식이 안맞습니다. 영문/숫자 3~20자");
				joinForm.id.focus();
				return;
			}
			
			
			
			if((id.length) < 3 || id.length > 20){
				alert("아이디는 3자 이상, 20자 이하입니다.");
				joinForm.id.focus();
				return;
			}
			if(pw==""){
				alert("패스워드를 입력해주세요.");
				joinForm.pw.focus();
				return;
			}
			if(rePw==""){
				alert("확인용 패스워드를 입력해주세요.");
				joinForm.rePw.focus();
				return;
			}
			if(name==""){
				alert("이름을 입력해주세요.");
				joinForm.name.focus();
				return;
			}
			if(pw!=rePw){
				alert("패스워드가 일치하지 않습니다..");
				joinForm.pw.focus();
				return;
			}
			if(email == null || email ==""){
				alert("이메일 입력하세요")
				return;
			}


			
			
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				
				if(email.match(regExp) == null){
					alert("이메일 형식이 안맞습니다.");
					return;
				}
			//회원가입 요청전 비동기 통신으로  ID중복 검사 	 @동기 통신은 1:1로 응답을 기다린다. @비동기 기다리는 동안 다른것을 한다. //
			//비동기 통신으로 회원 아이디 중복검사에 걸려도 적은 정보가 남아있다. //동기 통신은 화면이 바뀐다. 
			
			//key와 value로 이루어진  map(오브젝트)이다                    ############################
			$.ajax({
				url : '<c:url value="/member/checkId.do" />',
				//URL에 보낼 데이터(파라미터)
				//       이 이름으로         아이디를 넣어 Member Controller에 보낸다.
				data : {memberId:$('#id').val()}, //{key , value} (#좌:문자열 인식 #우:문자열이면 문자열로 만들어야한다.)  구분자 (=)X  (:)O
				success : function(result, textStatus, XMLHttpRequest){
					
					//alert('값 도착');
					if(result == 0){
						
			//회원가입 요청
			joinForm.action = "/portfolio/member/join.do";
			joinForm.method = "post";
			joinForm.submit();
		
					}else {
						alert('중복된 아이디 입니다.');
						
					}
					console.log(result);
					console.log(textStatus);
					console.log(XMLHttpRequest);
				},
				//success끝
				error: function(){
				}
				//error끝
			});
			//alert('비동기 통신 호출');
		})
	});
	

	<!--
	function doJoin(){
		var joinForm = document.joinForm;
		var id = joinForm.id.value;
		var pw = joinForm.pw.value;
		var rePw = document.getElementById("rePw").value;
		var name = joinForm.name.value;
		var email = joinForm.email.value;
		
		if(id==""){
			alert("아이디를 입력해주세요.");
			joinForm.id.focus();
			return;
		}
		if(id.length<=6 || id.length>=12){
			alert("아이디는 6자 이상, 12자 이하입니다.");
			joinForm.id.focus();
			return;
		}
		if(pw==""){
			alert("패스워드를 입력해주세요.");
			joinForm.pw.focus();
			return;
		}
		if(rePw==""){
			alert("확인용 패스워드를 입력해주세요.");
			joinForm.rePw.focus();
			return;
		}
		if(name==""){
			alert("이름을 입력해주세요.");
			joinForm.name.focus();
			return;
		}
		if(pw!=rePw){
			alert("패스워드가 일치하지 않습니다..");
			joinForm.pw.focus();
			return;
		}
		
		joinForm.action = "/spring_05/member/join.do";
		joinForm.method = "post";
		joinForm.submit();
	}

	-->
</script>
</head>
<body oncopy="return false" oncut="return false" onpaste="return false">
	<!-- 디자인 출처 : http://www.blueb.co.kr/?c=2/34&where=subject%7Ctag&keyword=%EB%A1%9C%EA%B7%B8%EC%9D%B8&uid=4050 -->
	<!-- Form-->
	<div class="form">
		<div class="form-toggle"></div>
		<div class="form-panel one">
			<div class="form-header">
				<h1>로그인</h1>
					<c:if test="${ msg != null }">
						<b><font color="red">${ msg }</font></b>
					</c:if>
			</div>
			<!-- 로그인 -->
			<div class="form-content">
				<form action="/portfolio/member/login.do" method="post" name="login">
					<div class="form-group">
						<label for="username">아이디</label> 
						<input type="text" id="" name="userId" required="required" value="admin" />
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label> 
						<input type="password" id="" name="userPw" required="required" value="admin" />
					</div>
					<div class="form-group">
						<label class="form-remember"> 
							<input type="checkbox" />아이디 저장(x)
						</label>
						<a href="#" class="form-recovery">비밀번호 찾기(x)</a>
					</div>
					<div class="form-group">
						<button type="submit">로그인</button>
					</div>
				</form>
			</div>
		</div>
		
		<!-- 회원가입 -->
		<div class="form-panel two">
			<div class="form-header">
				<h1>회원가입</h1>
			</div>
			<div class="form-content">
				<form name="joinForm">
					<div class="form-group">
						<label for="username">아이디</label> 
						<input type="text" id="id" name="id" required="required" />
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label> 
						<input type="password" id="pw" name="pw" required="required" />
					</div>
					<div class="form-group">
						<label for="cpassword">비밀번호 확인</label> 
						<input type="password" id="rePw" required="required" />
					</div>
					<div class="form-group">
						<label for="name">이름</label> 
						<input type="text" id="name" name="name" required="required" />
					</div>
					<div class="form-group">
						<label for="name">닉네임</label> 
						<input type="text" id="nick" name="nick" required="required" />
					</div>
					<div class="form-group">
						<label for="name">생년월일 (yyyy-mm-dd 형식)</label> 
						<input type="text" id="birth" name="birth" required="required" />
					</div>
					<div class="form-group">
						<label for="nickname">이메일</label> 
						<input type="text" id="email" name="email" required="required" />
					</div>
					<div class="form-group">
						<button type="button" id="reg">가입</button>
					<!--	<button type="button" onclick="doJoin()">Register</button> -->
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>