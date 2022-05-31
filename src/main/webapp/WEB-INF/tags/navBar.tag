<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="current" %>

<c:url value="/board/list" var="listUrl"></c:url>
<c:url value="/board/insert" var="insertUrl"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/member/list" var="memberListUrl"></c:url>
<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/initpw" var="initPasswordUrl"></c:url>

<%-- 회원정보 링크 --%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
		<c:url value="/member/get" var="memberInfoUrl">
			<c:param name="id" value="${principal.username }" />
		</c:url>
</sec:authorize>

<nav class="navbar navbar-expand-md navbar-light bg-light mb-3">
  <div class="container">
    <a class="navbar-brand" href="${listUrl }"><i class="fa-solid fa-house"></i></a>
    
    <!-- button.navbar-toggler>span.navbar-toggler-icon -->
    <button class="navbar-toggler" 
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">
    	<span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link ${current == 'list' ? 'active' : '' }" href="${listUrl }">목록보기</a>
        </li>
        
        <sec:authorize access="isAuthenticated()">
	        <li class="nav-item">
	          <a class="nav-link ${current == 'insert' ? 'active' : '' }" href="${insertUrl }">글쓰기</a>
	        </li>
        </sec:authorize>
        
        
        <!-- li.nav-item>a.nav-link{회원가입} -->
        <li class="nav-item">
        	<a href="${signupUrl }" class="nav-link ${current == 'signup' ? 'active' : '' }">회원가입</a>
        </li>
        
        <sec:authorize access="isAuthenticated()">
        	<!-- li.nav-item>a{회원정보} -->
        	<li class="nav-item">
        		<a href="${memberInfoUrl }" class="nav-link ${current == 'memberInfo' ? 'active' : '' }">회원정보</a>
        	</li>
        </sec:authorize>
        
        <sec:authorize access="hasRole('ADMIN')"> <!-- admin 권한 있는 유저만 회원목록 보이게 하기 -->
	        <li class="nav-item">
	        	<a href="${memberListUrl }" class="nav-link ${current == 'memberList' ? 'active' : '' }">회원목록</a>
	        </li>    
	        <!-- .nav-item>a.nav-link{암호초기화} -->
	        <div class="nav-item">
	        	<a href="${initPasswordUrl }" class="nav-link">암호초기화</a>
	        </div>    
        </sec:authorize>        
        
        <!-- li.nav-item>a.nav-link{로그인} -->
        <sec:authorize access="not isAuthenticated()"> <!-- 로그아웃 상태에서만 로그인 버튼 보이기 -->
	        <li class="nav-item">
	        	<a href="${loginUrl }" class="nav-link">로그인</a>
	        </li>
        </sec:authorize>        
        
        <!-- li.nav-item>button.nav-link{로그아웃} -->
        <sec:authorize access="isAuthenticated()"> <!-- 로그인 상태에서만 로그아웃 버튼 보이기 -->
	        <li class="nav-item">
	        	<button class="nav-link" type="submit" form="logoutForm1">로그아웃</button>
	        </li>
	    </sec:authorize>
      </ul>
      
      <div class="d-none">
      	<form action="${logoutUrl }" id="logoutForm1" method="post"></form>
      </div>
      
      <!-- form.d-flex>input.form-control.me-2[type=search]+button.btn.btn-outline-success -->
      
      <form action="${listUrl }" class="d-flex">
      	<!-- select.form-select>option*3 -->
      	<select name="type" id="" class="form-select">
      		<option value="all" ${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
      		<option value="title" ${param.type == 'title' ? 'selected' : '' }>제목</option>
      		<option value="body" ${param.type == 'body' ? 'selected' : ''}>본문</option>
      	</select>
      
      	<input type="search" class="form-control me-2" name="keyword"/>
      	<button class="btn btn-outline-success"><i class="fa-solid fa-magnifying-glass"></i></button>
      </form>
    </div>
  </div>
</nav>