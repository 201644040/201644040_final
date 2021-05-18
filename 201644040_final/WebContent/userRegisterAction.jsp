<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<!-- 특정한 스크립트 구문을 설정할 때 사용한다.  -->
<%@ page import="java.io.PrintWriter"%>



<%
	//회원가입을 처리합니다. 사용자 정보를 데이터베이스에 등록한 이후에, 자동으로 사용자의 이메일로 이메일을 전송하고 인증을 기다린다.
	
	
	//사용자로 입력받은 값을 UTF-8로 설정한다.
	request.setCharacterEncoding("UTF-8");

	//사용자가 입력하는 3가지 값.
	String userID = null;
	
	
		//세션을 위한 추가 
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
	
	String userPassword = null;
	String userEmail = null;
	
	//사용자가 userID값을 입력했다면, 
	if(request.getParameter("userID") != null) {
		//userID에 데이터를 담아준다.
		userID = (String) request.getParameter("userID");
	}

	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}

	if(request.getParameter("userEmail") != null) {
		userEmail = (String) request.getParameter("userEmail");
	}

	
	//사용자가 정상적으로 입력하지 않았다면,
	if (userID == null || userPassword == null || userEmail == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");

		script.close();
	} else { //사용자가 재대로 입력을 했다면, 

		UserDAO userDAO = new UserDAO();
		//모든 결과값을 result에 넣어준다. (한명의 사용자객체를 회원가입을 시켜준다.)
		int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));

		if (result == -1) { 

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back();");
			script.println("</script>");

			script.close();

		} else {
			//로그인을 시켜준다.
			session.setAttribute("userID", userID);

			PrintWriter script = response.getWriter();

			script.println("<script>");
			//이메일 인증 페이지로 보낸다.
			script.println("location.href = 'emailSendAction.jsp';");
			script.println("</script>");

			script.close();

		}

	}

%>
