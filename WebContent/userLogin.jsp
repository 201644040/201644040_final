<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, inital-scale=1, shrink-to-fit=no">
<title>강의평가 웹 사이트</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/custom.css">

</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		
			userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	

%>



	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 시스템</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdown"
					data-toggle="dropdown" href="#"> 회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">

						<% if(userID == null) { %>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> <a
							class="dropdown-item" href="userJoin.jsp">회원가입</a>

						<% } %><%-- else {  %>
							
							class="dropdown-item" href="userLogout.jsp">로그아웃</a>

						<% }  %> --%>

					</div></li>
			</ul>
			<form action="./index.jsp" method="get"
				class="form-inline my-2 my-lg0">
				<!-- <input type="text" class="form-control mr-sm-2" name="search"
					placeholder="내용을 입력하세요." aria-label="search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button> -->
			</form>

		</div>

	</nav>

	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userLoginAction.jsp">
			<div class="form-group">

				<label>아이디</label> <input type="text" name="userID"
					class="form-control">

			</div>

			<div class="form-group">

				<label>비밀번호</label> <input type="password" name="userPassword"
					class="form-control">

			</div>
			<button type="submit" class="btn btn-primary">로그인</button>

		</form>

	</section>




	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 김동준 All Rights Reserves. </footer>



	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>



</body>
</html>