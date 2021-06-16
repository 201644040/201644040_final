<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width", initial-scale="1"> -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>강의평가 시스템에 어서오세요.</title>
<link rel="icon" href="images/lecture.png">
<style>
body{
        height: 100vh;
        background-image: url('images/2.jpg');
        background-repeat : no-repeat;
        background-size : cover;

}
</style>
</head>
<body>
	<% 
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
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

	<div class="container">
		<div class="jumbotron">
			<div class="container">

				<h1>오신것을 환영합니다.</h1>

				<p>Copyright &copy; 2021 김동준 All Rights Reserved.</p>

				<p>
					<a class="btn btn-primary btn-pull" href="Info.jsp" role="button">자세히
						알아보기</a>
				</p>

			</div>
		</div>
	</div>

	<div class="container">

<div id="myCarousel" class="carousel slide" data-ride="carousel">
 <ol class="carousel-indicators">

<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
<li data-target="#myCarousel" data-slide-to="1"></li>
<li data-target="#myCarousel" data-slide-to="2"></li>

</ol>

<div class="carousel-inner">
<div class="item active">
<img src="images/itc1.jpg">

</div> 
	
<div class="item">
<img src="images/itc2.jpg">

</div>

<div class="item">
<img src="images/itc3.jpg">

</div>  

<a class="left carousel-control" href="#myCarousel" data-slide="prev">
<span class="glyphicon glyphicon-chevron-left"></span>

</a>

<a class="right carousel-control" href="#myCarousel" data-slide="next">
<span class="glyphicon glyphicon-chevron-right"></span> 
</a>

</div>
</div>
</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src=js/bootstrap.js></script>

</body>

</html>
