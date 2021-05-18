<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%
	// 로그인 요청을 처리해주는 액션 페이지
	
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	String userPassword = null;

	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}

	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}

	UserDAO userDAO = new UserDAO();
	//login함수를 이용해서 두 개의 값을 받아준다.
	int result = userDAO.login(userID, userPassword);
	//정상적으로 로그인에 성공한다면,
	if (result == 1) {

		session.setAttribute("userID", userID);

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");

		script.close();

	} else if (result == 0) { // 비밀번호가 틀렸을 때 0값을 반환하게 만들었다.(DAO부분)

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");

		script.close();

	} else if (result == -1) { 

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");

		script.close();

	} else if (result == -2) {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");

		script.close();

	}

%>