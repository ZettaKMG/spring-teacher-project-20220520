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
		// 암호, 암호 확인 일치 여부
		let passwordCheck = true;
		// 이메일 중복 확인 여부
		let emailCheck = true;
		// 닉네임 중복 확인 여부
		let nickNameCheck = true;
		
		// 기존 이메일 저장
		const oldEmail = $("#emailInput1").val();
		// 기존 닉네임 저장
		const oldNickName = $("#nickNameInput1").val();		
		
		// 수정버튼(modifySubmitButton1) 활성화 함수
		const enableModifyButton = function() {
			if (passwordCheck && emailCheck && nickNameCheck) {
				$("#modifySubmitButton1").removeAttr("disabled");
			} else {
				$("#modifySubmitButton1").attr("disabled", "");
			}
		};
		
		// 이메일 input 요소에 text 변경시 이메일 중복확인 버튼 활성화
		$("#emailInput1").keyup(function() {
			const newEmail = $("#emailInput1").val();
			
			// 기존 이메일과 수정 이메일이 다를 때만 중복확인 버튼 활성화
			if (oldEmail === newEmail) {
				$("#emailCheckButton1").attr("disabled", "");
				$("#emailMessage1").text("");
				emailCheck = true;
			} else {
			    $("#emailCheckButton1").removeAttr("disabled");
			    emailCheck = false;
			}	
			
			enableModifyButton();
		});
		
		// 닉네임 input 요소에 text 변경시 닉네임 중복확인 버튼 활성화
		$("#nickNameInput1").keyup(function() {
			const newNickName = $("#nickNameInput1").val();
			
			// 기존 닉네임과 수정 닉네임이 다를 때만 중복확인 버튼 활성화
			if (oldNickName === newNickName) {
				$("#nickNameCheckButton1").attr("disabled", "");
				$("#nickNameMessage1").text("");
				nickNameCheck = true;
			} else {
				$("#nickNameCheckButton1").removeAttr("disabled");
				nickNameCheck = false;				
			}
			
			enableModifyButton();
		});
		
		// 이메일 중복버튼 클릭시 ajax 요청 발생
		$("#emailCheckButton1").click(function(e) {
			e.preventDefault(); // 기존 이벤트 진행 중지
			
			const data = {email : $("#emailInput1").val()};
			
			emailCheck = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
					case "ok" :
						$("#emailMessage1").text("사용 가능한 이메일입니다.");
						emailCheck = true;
						break;
					case "notOk" :
						$("#emailMessage1").text("사용 불가능한 이메일입니다.");
						break;							
					}
				},
				error : function() {
					$("#emailMessage1").text("이메일 중복 확인 중 오류 발생, 다시 시도해주세요.");
				},
				complete : function() {
					// $("#emailMessage1").text("이메일 중복 확인 완료.");
					enableModifyButton();
				}
			});
		});				
		
		// 닉네임 중복버튼 클릭시 ajax 요청 발생
		$("#nickNameCheckButton1").click(function(e) {
			e.preventDefault(); // 기존 이벤트 진행 중지
			
			const data = {nickName : $("#nickNameInput1").val()};
			
			nickNameCheck = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
					case "ok" :
						$("#nickNameMessage1").text("사용 가능한 닉네임입니다.");
						nickNameCheck = true;
						break;
					case "notOk" :
						$("#nickNameMessage1").text("사용 불가능한 닉네임입니다.");
						break;							
					}
				},
				error : function() {
					$("#nickNameMessage1").text("닉네임 중복 확인 중 오류 발생, 다시 시도해주세요.");
				},
				complete : function() {
					// $("#nickNameMessage1").text("닉네임 중복 확인 완료.");
					enableModifyButton();
				}
			});
		});
		
		// 암호, 암호확인 요소 값 변경 시
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			if (pw1 === pw2) {
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				passwordCheck = true;
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
				passwordCheck = false;
			}
		});
		
		// 수정 submit 버튼 (modifySubmitButton2) 클릭 시 
		$("#modifySubmitButton2").click(function(e) {
			e.preventDefault(); // 기존 이벤트 중지
			const form2 = $("#form2");
			
			// input 값 옮기기
			form2.find("[name=password]").val($("#passwordInput1").val());
			form2.find("[name=email]").val($("#emailInput1").val());
			form2.find("[name=nickName]").val($("#nickNameInput1").val());
			
			// submit
			form2.submit();
		});
	});

</script>

<title>Insert title here</title>
</head>
<body>

	<my:navBar current="memberInfo"></my:navBar>

	<div>
		${message }
	</div>

	<div>
	아이디 : <input type="text" value="${member.id }" readonly /> <br />
	암호 : <input id="passwordInput1" type="text" value="" /> <br />
	암호확인 : <input id="passwordInput2" type="text" value="" /> <br />
	<p id="passwordMessage1"></p>
	 
	이메일 : <input id="emailInput1" type="email" value="${member.email }" /> <button id="emailCheckButton1" disabled>이메일 중복확인</button> <br />
	<p id="emailMessage1"></p>
	
	닉네임 : <input id="nickNameInput1" type="text" value="${member.nickName }" /> <button id="nickNameCheckButton1" disabled>닉네임 중복확인</button> <br />
	<p id="nickNameMessage1"></p>
	
	가입일시 : <input type="datetime-local" value="${member.inserted }" readonly /> <br />
	</div>

	<!-- 요구 사항
	1. 이메일 input에 변경 발생시 '이메일 중복확인 버튼 활성화'
	   -> 버튼 클릭시 ajax로 요청/응답
	2. 닉네임 input에 변경 발생시 '닉네임 중복확인 버튼 활성화'
	   -> 버튼 클릭시 ajax로 요청/응답
	
	3. 수정버튼 활성화
	   -> 암호/암호확인 일치, 이메일 중복확인 완료, 닉네임 중복확인 완료시에만 
	 -->	

	<div>
	<button id="modifySubmitButton1" data-bs-toggle="modal" data-bs-target="#modal2" disabled>수정</button>
	<button data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
	</div>

	<!-- 탈퇴 암호 확인 Modal -->
	<div class="modal fade" id="modal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<form id="form1" action="${appRoot }/member/remove" method="post">
		        <input type="hidden" value="${member.id }" name="id" />		     		
	      		암호 : <input type="password" name="password" />
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button form="form1" type="submit" class="btn btn-danger">탈퇴</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 수정(modify) 기존 암호 확인 Modal -->
	<div class="modal fade" id="modal2" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel2">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<form id="form2" action="${appRoot }/member/modify" method="post">
		        <input type="hidden" value="${member.id }" name="id" />		     		
	      		<input type="hidden" name="password" />
	      		<input type="hidden" name="email" />
	      		<input type="hidden" name="nickName" />
	      		기존 암호 : <input type="password" name="oldPassword" />
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifySubmitButton2" form="form2" type="submit" class="btn btn-warning">수정</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>