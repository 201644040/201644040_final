<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%!
// 해당사이트에 접속한 아이피 주소를 알아내는 함수 
public static String getClientIP(HttpServletRequest request) {

    String ip = request.getHeader("X-FORWARDED-FOR"); 
	//프록시 서버를 사용한 사용자라도 아이피를 가져올 수 있게 만들어준다.
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }
	
    if (ip == null || ip.length() == 0) {
    	// 아이피 주소를 가져온다.
        ip = request.getRemoteAddr() ;
    }
    return ip;
}

%>

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

	

	}

	request.setCharacterEncoding("UTF-8");

	String evaluationID = null;

	if(request.getParameter("evaluationID") != null) {

		evaluationID = (String) request.getParameter("evaluationID");

	}

	EvaluationDAO evaluationDAO = new EvaluationDAO();

	LikeyDAO likeyDAO = new LikeyDAO();
	
	//라이크 함수를 실행시킬 수 있도록 한다. 아이피 주소 까지 담아준다.
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));

	if (result == 1) {

		result = evaluationDAO.like(evaluationID);

		if (result == 1) {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.');");
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
			return;
		}

	} else {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('이미 추천을 누른 글입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;

	}

%>