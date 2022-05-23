<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		$("#button1").click(function() {
			$.ajax({url : "/spr2/ex03/sub03"});			
		});
		
		$("#button2").click(function() {
			$.ajax({url : "/spr2/ex03/sub04"});
		});
		
		$("#button3").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub05", 
				type : "get"
			});
		});
		
		$("#button4").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub06",
				type : "post"
			});
		});
		
		$("#button5").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub07",
				type : "delete"
			});
		});
		
		$("#button6").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub08",
				type : "put"
			});
		});
		
		$("#button7").click(function(){
			$.ajax({
				url : "/spr2/ex03/sub09",
				type : "get", // type의 기본값은 get이므로 생략 가능
				data : {
					title : "epl",
					writer : "son"
				}
			});
		});
		
		$("#button8").click(function(){
			$.ajax({
				url : "/spr2/ex03/sub10",
				type : "post",
				data : {
					name : "ninave",
					address : "elgasia"
				}
			});
		});
		
		$("#button9").click(function(){
			$.ajax({
				url : "/spr2/ex03/sub11",
				type : "post",
				data : {
					title : "득점왕 되기",
					writer : "손"
				}
			});
		});
		
		$("#button10").click(function(){
			$.ajax({
				url : "/spr2/ex03/sub10",
				type : "post",
				data : "name=ninave&address=elgasia" 
			});
		});
		
		$("#button11").click(function(){
			$.ajax({
				url : "/spr2/ex03/sub11",
				type : "post",
				data : "title=lostark&writer=smilegate" 
			});
		});
		
		$("#button12").click(function(e) {
			e.preventDefault();
			
			const dataString = $("#form1").serialize();
			
			$.ajax({
					url : "/spr2/ex03/sub10",
					type : "post",
					data : dataString
			});
		});
		
		$("#button13").click(function(e) {
			e.preventDefault();
			
			const data = $("#form2").serialize();
			
			$.ajax({
					url : "/spr2/ex03/sub11",
					type : "post",
					data : data
			});
		});
		
		$("#button14").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub12",
				type : "post",
				success : function(data) { // data : 응답 받은 data
					console.log("요청 성공!!!");
					console.log("받은 데이터", data);
				}
			});			
		});
		
		$("#button15").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub13",
				type : "get",
				success : function(lotto) {
					// console.log(data);
					$("#result1").text(lotto);
				}
			});
		});		
		
		$("#button16").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub14",
				type : "get",
				success : function(book) {
				 /* console.log(book);
					console.log(book.title);
					console.log(book.writer); */
					$("#result2").text(book.title);
					$("#result3").text(book.writer);
				}
			});			
		});
		
		$("#button17").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub15",
				success : function(data) {
					console.log(data);
				}
			});
		});
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<button id="button1">ajax 요청 보내기</button> <br />
	
	<%-- 이 버튼을 클릭하면 /spr2/ex03/sub04로 ajax 요청 보내기 --%>
	<%-- 콘트롤러에도 해당경로 요청에 일하는 메소드 추가 --%>
	<button id="button2">ajax 요청 보내기2</button> <br />
	
	<%-- /spr2/ex03/sub05 get 방식 요청 보내기 --%>
	<button id="button3">get 방식 요청 보내기</button>
	
	<%-- /spr2/ex03/sub06 post 방식 요청 보내기 --%>
	<button id="button4">post 방식 요청 보내기</button>
	
	<%-- /spr2/ex03/sub07 delete 방식 요청 보내기 --%>
	<button id="button5">delete 방식 요청 보내기</button>
	
	<%-- /spr2/ex03/sub08 put 방식 요청 보내기 --%>
	<button id="button6">put 방식 요청 보내기</button>
	
	<hr />
	<p>서버로 데이터 보내기</p>
	
	<%-- /spr2/ex03/sub09 get 방식 데이터 보내기 --%>
	<button id="button07">get 방식 데이터 보내기</button>
	
	<%-- /spr2/ex03/sub10 post 방식으로 데이터 보내기 --%>
	<%-- 전송될 데어터는 name, address --%>
	<button id="button08">post 방식 데이터 보내기</button>
	
	<%-- /spr2/ex03/sub11 post 방식으로 데이터 보내기 --%>
	<%-- 전송될 데어터는 title, writer --%>
	<button id="button09">post 방식 데이터 보내기2</button>
	
	<%-- /spr2/ex03/sub10 post 방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 name, address --%>
	<button id="button10">post 방식 데이터 보내기 (encoded string)</button>
	
	<%-- /spr2/ex03/sub11 post 방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 title, writer --%>
	<button id="button11">post 방식 데이터 보내기2 (encoded string)</button>
	
	<hr />
	
	<p>폼 데이터 보내기</p>
	<form action="/spr2/ex03/sub14" id="form1" method="post">
		name : <input type="text" name="name" /> <br />
		address : <input type="text" name="address" /> <br />
		<input id="button12" type="submit" value="전송" />
	</form>
	
	<%-- #button13이 클릭되면 --%>
	<%-- /spr2/ex03/sub15 --%>
	<form action="/spr2/ex03/sub15" id="form2" method="post">
		title : <input type="text" name="title" /> <br />
		writer : <input type="text" name="writer" /> <br />
		<input id="button13" type="submit" value="전송" />
	</form>
	
	<hr />
	
	<p>응답 처리 하기</p>
	
	<%-- url : /spr2/ex03/sub12, type : post --%>
	<button id="button14">응답 처리1</button> <br />
		
	<button id="button15">로또번호 받기</button>
	<p>받은 번호 : <span id="result1"></span></p>
	
	<button id="button16">json 데이터 받기</button>
	<p>책 제목 : <span id="result2"></span></p>
	<p>책 저자 : <span id="result3"></span></p>
	
	
	<button id="button17">map to json</button>
</body>
</html>