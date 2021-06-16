<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의평가 웹사이트</title>
<meta charset="utf-8">
<!-- 반응형 페이지이기 때문에 사이즈를 적용해준다. -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">
</head>

<body>
	<%
	//세션을 위한 추가 
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();	
		return;
	}
%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>

			</button>

			<a class="navbar-brand" href="main.jsp">강의평가 시스템</a>

		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">

				<li class="active"><a href="index.jsp">메인</a></li>

			</ul>

			<%
	if(userID==null){
%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userLogin.jsp">로그인</a></li>
						<li><a href="userJoin.jsp">회원가입</a></li>
					</ul></li>
			</ul>

			<% 
	} else{
%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userLogout.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<% 

}

%>
		</div>
	</nav>

	<%--   <!--  네비게이션 바를 보여줌  -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <!-- 부트스트랩에서 로그 같은 것을 출력 하는 것  -->
      <a class="navbar-brand" href="index.jsp">강의평가 웹사이트</a>
      <!--  버튼을 생성해서 보였다가 안보였다를 구현. -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <!-- 작데기 하나를 보여줌. -->
        <span class="navbar-toggler-icon"> </span>
      </button>
		<!-- 버튼을 눌렀을 때 보여주는 내부요소 부분 /위에 버튼 태그를 눌렀을 때 id가 =navbar 인 곳이 나온다.  -->
      <div class="collapse navbar-collapse" id="navbar">
      	<!-- 리스트 내용 부분. -->
        <ul class="navbar-nav mr-auto">
        <!-- 현재 페이지 index.jsp를 나타낸다.  -->
          <li class="nav-item active">
          	<!-- a태그로 이동할 페이지를 넣어준다.  -->
            <a class="nav-link" href="index.jsp">메인</a>
          </li>
			
			<!--  눌렀을 때 아래로 나오는 기능 부분  -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
             	 인증하기
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else {
%>
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
            </div>
          </li>
        </ul>
		<!-- 검색 양식  -->
        <form  action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input type = "text" name = "search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form> 
      </div>
    </nav>
 --%>
	<!-- 본문 부분  -->
	<!--  알아서 작아지는 것에 도움을 준다. -->
	<!-- 검색창을 만들어 준다. -->
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userRegisterAction.jsp">
			<div class="form-group">
				<label>아이디</label> <input type="text" name="userID"
					class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label> <input type="password" name="userPassword"
					class="form-control">
			</div>
			<div class="form-group">
				<label>이메일</label> <input type="email" name="userEmail"
					class="form-control">
			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</form>
	</section>

	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 김동준 All Rights Reserved. </footer>

	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery-3.5.1.min.js"></script>
	<!-- Popper 자바스크립트 추가하기 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>