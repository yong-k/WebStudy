<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// Send01.html 로 부터 데이터 수신 → 스크립트 릿 영역
	
	// 한글 수신을 위한 인코딩 방식 지정
	//-- 웹은 UTF-8 을 기본 인코딩 방식으로 삼고 있음.
	//   그러므로 기본 설정은 UTF-8 로 구성하는 것이 좋다.
	//   (하지만, 데이터를 전송하는 페이지에서 EUC-KR 과 같이 다른 인코딩 방식으로
	//    처리하고 있는 상황이라면... 그에 따른 인코딩 방식이 지정되어야 한글이 깨지지 않는다.
	//    또한, 지금 하고 있는 이 처리는... 
	//    데이터를 수신하는 처리보다 먼저 수행되어야 한글이 깨지지 않은 상태로 수신할 수 있다.)
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("name"); 
	String tel = request.getParameter("tel");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive01.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>데이터 송수신 실습 01</h1>
	<hr>
</div>

<div>
	<h2>가입 확인</h2>
	<span style="color: blue;"><%=name %></span>님, 
	회원가입이 완료되었습니다.<br>
	회원님께서 등록하신 전화번호는 
	<span style="color: red;"><%=tel %></span> 입니다.<br>
</div>
</body>
</html>