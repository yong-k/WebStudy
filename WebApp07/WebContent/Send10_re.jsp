<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지로(Send10.jsp)부터 데이터(userName)수신
	// ①
	request.setCharacterEncoding("UTF-8");

	String userName = request.getParameter("userName");
	
	// 이 페이지에서 수행한 추가 작업
	// ②
	request.setAttribute("message", "반갑습니다.");
	//-- request 객체의 key(message)의 값 안에
	//   "반갑습니다."를 value 로 넣는 작업 수행한 것이다.
	//-- form 에서 넘어온건 다 parameter 값으로 처리되고,
	//   setAttribute로 넘긴 건, getAttribute 로 받으면된다.
	//   request.getParameter()는 문자열로 넘기고, 문자열로 쓴다.
	//   setAttribute(), getAttribute() 는 Object 형태로 건네고, 사용한다!
	
	// ※ 리다이렉트
	// ③
	response.sendRedirect("Receive10.jsp");
	//-- 클라이언트 손에 쪽지를 쥐어주는데, 
	//   그 쪽지에 『Receive10.jsp』 라고 적혀있는 것이다.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send10_re.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h2>데이터 송수신 실습 10</h2>
</div>

<div>
	<h2>리다이렉트</h2>
</div>

<div>
	<!-- <p>이름 : 이호석</p> -->
	<p>이름 : <%=userName %></p>
</div>

</body>
</html>