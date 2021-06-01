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
</head>
<body>
	<% 
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
}
	%>
		<% 
	//항상사용자가 어떠한 게시물을 검색햇는지 처리해야한다.
  	request.setCharacterEncoding("UTF-8");
  	String lectureDivide = "전체";
  	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	// 사용자가 어떤 검색으로 시도했는지 처리한다.
	if(request.getParameter("lectureDivide") != null) {
		//사용자가 요청한 값이 들어가도록 해준다.
		lectureDivide = request.getParameter("lectureDivide");
	}

	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}

	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}

	if(request.getParameter("pageNumber") != null) {
		try {
			//정수형으로 변환해준다.
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
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


			<form action="./index.jsp" method="get"
				class="form-inline my2 my-lg-0">
			</form>

	</nav>
	
	<section class="container">
	
 		<form method="get" action="./index.jsp" class="form-inline mt-3">

				<select name="searchType" class="form-control mx-1 mt-2">
				<option value="이름순">이름순</option>
				<option value="가입일순"
					<% if(lectureDivide.equals("가입일순")) out.print("selected"); %>>가입일순</option>

			</select> <input type="text" name="search" class="form-control mx-1 mt-2"
				placeholder="내용을 입력하세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>

		</form>



		<div class="card bg-light mt-3">

			<div class="card-header bg-light">
				<div class="row">


					</div>
				</div>

			</div>

		</div>


	</section>


	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">


		</li>

		<li>

		</li>

	</ul>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src=js/bootstrap.js></script>

</body>

</html>
