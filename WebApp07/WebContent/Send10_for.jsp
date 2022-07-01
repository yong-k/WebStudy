<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지(Send10.jsp)로부터 데이터(userName) 수신
	// ①
	request.setCharacterEncoding("UTF-8");

	String userName = request.getParameter("userName");
	
	// 이 페이지에서 수행한 추가 작업
	// ②
	request.setAttribute("message", "안녕하세요.");
	//-- request 객체의 key(message)의 값 안에
	//   "안녕하세요."를 value 로 넣는 작업 수행한 것이다.
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send10_for.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h2>데이터 송수신 실습 10</h2>
</div>

<div>
	<h2>포워드</h2>
</div>

<div>
	<!-- <p>이름 : 이호석</p> -->
	<p>이름 : <%=userName %></p>
</div>
	
	<!-- ※ 포워드 -->
	<!-- ③ -->
	<jsp:forward page="Receive10.jsp"></jsp:forward>
	<!-- 이거 한 줄로 포워딩 처리 이루어진다. -->
	<!-- jsp에서 지원하는 문법이다.
		 jsp: 이렇게 들어가는 걸 jsp action 태그라고 한다.
		 html 에서는 지원 안되고, jsp에서만 지원된다. -->




</body>
</html>