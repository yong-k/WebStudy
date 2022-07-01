<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String password = request.getParameter("password");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginReceive.jsp</title>
<link rel="stylesheet" type="text/css" href="myStyles.css">
<link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<style type="text/css">
	p {
		font-weight: bold;
		padding: 20px;
	}
	span {
		font-size: 24px;
		color: #2f2a30;
	}
</style>
</head>
<body>

<div>
	<h1> 아이디/비밀번호 확인 창</h1>
	<hr>
	<p>귀하의 아이디는 <span><%=email %></span><br> 
	비밀번호는 <span><%=password %></span> 입니다.</p>
</div>

</body>
</html>