<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지(TestSession02.jsp)로부터 데이터(id, pw) 수신
	request.setCharacterEncoding("UTF-8");
	
	String pw = request.getParameter("pw");
	String id = request.getParameter("id");
	
	String name = (String)session.getAttribute("name");
	String tel = (String)session.getAttribute("tel");
	
	// 이미 변수에 옮겨 담았으면 더 이상 session 필요 없으니
	// session 에 들어있는 키값들 제거해도 상관없다.
	session.removeAttribute("name");
	session.removeAttribute("tel");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestSession03.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h4>이름     : <%=name %></h4> 
	<h4>전화번호 : <%=tel %></h4>
	<h4>아이디   : <%=id %></h4> 
	<h4>비밀번호 : <%=pw %></h4>
</div>

</body>
</html>