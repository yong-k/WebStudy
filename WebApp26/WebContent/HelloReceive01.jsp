<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HelloReceive01.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>
	<div>
		<h1>결과 수신 페이지</h1>
		<h2>HelloReceive.jsp</h2>
		<hr />
	</div>
	
	<div>
		<ul>
			<p>『request.getParameter()』 사용</p>
			<li><b>First Name : </b><%=firstName %></li>
			<li><b>Last Name : </b><%=lastName %></li>
			
			<br />
			
			<p>『param.』 사용</p>
			<li><b>First Name : </b>${param.firstName }</li>
			<li><b>Last Name : </b>${param.lastName }</li>
		</ul>
	</div>
</body>
</html>