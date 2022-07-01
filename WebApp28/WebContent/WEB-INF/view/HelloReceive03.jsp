<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HelloReceive03.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>
<!-- 
	앞에 HelloSend03.html은 html파일로 만들었는데 얘는 왜 jsp파일로 만들까?
  	→ 얘는 컨트롤러로부터 뭘 받아야 하기 때문에 .jsp 파일로 만든다.
 -->  	
 
	<div>
		<h1>결과 수신 페이지</h1>
		<h2>HelloReceive03.jsp</h2>
		<hr />
	</div>
	
	<div>
		<ul>
			<!-- setAttribute() 로 넘긴거 꺼내옴 -->
			<li><b>First Name : </b>${firstName }</li>
			<li><b>Last Name : </b>${lastName }</li>
		</ul>
	</div>  	
</body>
</html>