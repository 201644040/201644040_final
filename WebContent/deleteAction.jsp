<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");

		script.close();

		return;

	}

	request.setCharacterEncoding("UTF-8");

	String evaluationID = null;

	if(request.getParameter("evaluationID") != null) {
		evaluationID = (String) request.getParameter("evaluationID");
	}

	EvaluationDAO evaluationDAO = new EvaluationDAO();
	//만약에 게시글을 삭제하려는 사용자가 본인이라면,
	if(userID.equals(evaluationDAO.getUserID(evaluationID))) {
		//아이디를 삭제 할 수 있도록 한다.
		int result = new EvaluationDAO().delete(evaluationID);

		if (result == 1) {

			session.setAttribute("userID", userID);

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('삭제가 완료되었습니다.');");
			script.println("location.href='index.jsp'");
			script.println("</script>");

			script.close();

			return;

		} else {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();


		}
	} else {
		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
		script.println("history.back();");
		script.println("</script>");

		script.close();

		return;
	}

%>