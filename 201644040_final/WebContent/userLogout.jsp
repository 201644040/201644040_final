<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%
	//사용자의 세션을 파기해주는 페이지.
	session.invalidate();
%>

<script>
	location.href = 'index.jsp';
</script>

