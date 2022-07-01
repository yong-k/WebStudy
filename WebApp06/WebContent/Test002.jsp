<!-- ↓ 페이지 디렉티브 -->
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test002.jsp</title>
</head>
<body>

<div>
	<h1>include 디렉티브 실습</h1>
	<hr>
</div>

<!-- include 디렉티브 -->
<%@ include file="Test003.jsp" %>
<!-- Test002.jsp 를 불러왔는데, Test003.jsp 의 내용이 보여진다. -->

<!-- Test002 에는 str 라는 변수도 name이라는 변수도 없는데..! -->
<div>
	<h2><%=str %></h2>
	<h2><%=name %></h2>
</div>
<!-- Test003.jsp 의 변수 값들도 Test002.jsp 에서 처리가능하다!! -->

</body>
</html>