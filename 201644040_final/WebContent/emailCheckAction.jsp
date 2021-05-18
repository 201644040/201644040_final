<%@page import="java.io.PrintWriter"%>
<%@page import="util.SHA256"%>
<%@page import="user.UserDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");
	//사용자로부터 코드를 받는다.
	String code = request.getParameter("code");

	UserDAO userDAO = new UserDAO();
	//사용자로부터 아이디를 받는다.
	String userID = null;
	//사용자가 로그인 한 상태라면.
	if(session.getAttribute("userID") != null) {
		//변수를 초기화준다. 세션 값은 오브젝트 값으로 반환하기 때문에 String으로 형변환을 시켜줘야한다.
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
	
	//현재 사용자의 이메일 주소를 받는다.
	String userEmail = userDAO.getUserEmail(userID);
	//현재 사용자가 보낸 코드가 실제 코드와 같는지 일치하는지 확인한다.
	boolean rightCode = (new SHA256().getSHA256(userEmail).equals(code))? true:false;
	//일치 한다면.
	if(rightCode == true) {

		userDAO.setUserEmailChecked(userID);

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		

	} else {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.println(userID + "<br>"); 
		script.println(code + "<br>");
		script.println(new SHA256().getSHA256(userEmail) + "<br>");
		script.close();		

		return;

	}
 %>

