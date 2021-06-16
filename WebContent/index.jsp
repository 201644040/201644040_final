<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>

<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
<head>
<title>강의평가</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">
</head>

<body>
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
	
	//로그인 및 로그아웃을 위한 세션 추가
	String userID = null;
if(session.getAttribute("userID")!=null) {
	userID = (String) session.getAttribute("userID");
}
if(userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.');");
	script.println("location.href = 'main.jsp'");
	script.println("</script>");
	script.close();
}

	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>

	<nav class="navbar navbar-expan-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbar">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdown"
					data-toggle="dropdown" href="#"> 회원 관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">

						<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> <a
							class="dropdown-item" href="userJoin.jsp">회원가입</a>
						<%
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
						<% } %>
					</div></li>
			</ul>

			<form action="./index.jsp" method="get"
				class="form-inline my2 my-lg-0">
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="LectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공"
					<% if(lectureDivide.equals("전공")) out.print("selected"); %>>전공</option>
				<option value="교양"
					<% if(lectureDivide.equals("교양")) out.print("selected"); %>>교양</option>
				<option value="기타"
					<% if(lectureDivide.equals("기타")) out.print("selected"); %>>기타</option>

			</select> <select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순"
					<% if(lectureDivide.equals("추천순")) out.print("selected"); %>>추천순</option>

			</select> <input type="text" name="search" class="form-control mx-1 mt-2"
				placeholder="내용을 입력하세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">신고</a>
		</form>


		<%

	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
		for(int i = 0; i <evaluationList.size(); i++){
			if(i==5) break;
			EvaluationDTO evaluation = evaluationList.get(i);
		
%>


		<div class="card bg-light mt-3">

			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= evaluation.getLectureName() %>
						&nbsp;<small><%= evaluation.getProfessorName() %></small>
					</div>
					<div class="col-4 text-right">
						종합<span style="color: red;"><%= evaluation.getTotalScore() %></span>
					</div>

				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getLectureYear() %>
						<%= evaluation.getSemesterDivide() %> )
					</small>
				</h5>
				<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
				<div class="row">
					<div class="col-9 text-left">
						성적<span style="color: red;"><%= evaluation.getCreditScore() %></span>
						분위기<span style="color: red;"><%= evaluation.getComfortableScore() %></span>
						강의력<span style="color: red;"><%= evaluation.getLectureScore() %></span>
						<span style="color: green;">(추천 : <%= evaluation.getLikeCount() %>)
						</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')"
							href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">추천&nbsp;</a>
						<a onclick="return confirm('삭제하시겠습니까?')"
							href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">삭제</a>

					</div>
				</div>

			</div>

		</div>

		<%
		}
	
%>



	</section>


	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
			<%
			if(pageNumber <= 0) {
		%> <a class="page-link disabled">이전</a> <%
			} else {
			
		%> <a class="page-link"
			href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchTyp=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
			<%=pageNumber -1 %>">이전</a>

			<%
			}
		%>

		</li>

		<li>
			<%
		if(evaluationList.size() < 6 ) {
		%> <a class="page-link disabled">다음</a> <%
			} else {
			
		%> <a class="page-link"
			href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchTyp=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
			<%=pageNumber  + 1 %>">다음</a>

			<%
			}
		%>


		</li>

	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label> <input type="text" name="lectureName"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label> <input type="text" name="professorName"
									class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label> <select name="lectureYear"
									class="form-control">

									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021" selected>2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label> <select name="semesterDivide"
									class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label> <select name="lectureDivide"
									class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label> <input type="text" name="evaluationTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label> <select name="totalScore" class="form-control">
									<option value=null disabled selected> </option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성적</label> <select name="creditScore"
									class="form-control">
									<option value=null disabled selected> </option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>분위기</label> <select name="comfortableScore"
									class="form-control">
									<option value=null disabled selected> </option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>강의력</label> <select name="lectureScore"
									class="form-control">
									<option value=null disabled selected> </option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고 제목</label> <input type="text" name="reportTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 김동준 All Rights Reserved. </footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery-3.5.1.min.js"></script>
	<!-- js파일의 제이쿼리 버전 확인할것 -기능 동작 안하는 현상 발생 -->
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>