<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		// 아이디 중복 체크 버튼 클릭 이벤트
		$("#checkIdButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					id : $("#form1").find("[name=id]").val()					
			};		
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#idMessage1").text("사용 가능한 아이디입니다.");
							break;
						case "notOk" :
							$("#idMessage1").text("사용 불가능한 아이디입니다.");
							break;
					}
				},
				error : function() {
					$("#idMessage1").text("중복 확인 중 문제 발생, 다시 시도해주세요.");
				},
				complete : function() {
					$("#checkIdButton1").removeAttr("disabled");
				}
			});
		});
			
		// 이메일 중복 체크 버튼 클릭 이벤트
		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					email : $("#form1").find("[name=email]").val()
			};
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#emailMessage1").text("사용 가능한 이메일입니다.");
							break;
						case "notOk" :
							$("#emailMessage1").text("사용 불가능한 이메일입니다.");
							break;
					}
				},
				error : function() {
					$("#emailMessage1").text("중복 확인 중 문제 발생, 다시 시도해주세요.");
				},
				complete : function() {
					$("#checkEmailButton1").removeAttr("disabled");
				}
			});			
		});	
		
		// 닉네임 중복 체크 버튼 클릭 이벤트
		$("#checkNickNameButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					nickName : $("#form1").find("[name=nickName]").val()
			};
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#nickNameMessage1").text("사용 가능한 닉네임입니다.");
							break;
						case "notOk" :
							$("#nickNameMessage1").text("사용 불가능한 닉네임입니다.");
							break;
					}
				},
				error : function() {
					$("#nickNameMessage1").text("중복 확인 중 문제 발생, 다시 시도해주세요.");
				},
				complete : function() {
					$("#checkNickNameButton1").removeAttr("disabled");
				}
			});			
		});	
	});
</script>

<title>Insert title here</title>
</head>
<body>

<my:navBar current="signup"></my:navBar>

<form id="form1" action="${appRoot }/member/signup" method="post">
	아이디 : <input type="text" name="id" /> 
	<button id="checkIdButton1" type="button">아이디 중복 확인</button>
	<p id="idMessage1"></p> <br />
	비밀번호 : <input type="password" name="password" /> <br />
	이메일 : <input type="email" name="email" /> 
	<button id="checkEmailButton1" type="button">이메일 중복 확인</button> 
	<p id="emailMessage1"></p> <br />
	닉네임 : <input type="text" name="nickName" /> 
	<button id="checkNickNameButton1" type="button">닉네임 중복 확인</button>
	<p id="nickNameMessage1"></p> <br />
	
	<button>회원가입</button>
</form>


</body>
</html>