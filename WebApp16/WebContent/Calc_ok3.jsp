<%@page import="com.test.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!-- Calc_ok2.jsp 코드 주석처리! 비교해보자 -->
<%-- 
<jsp:useBean id="ob" class="com.test.Calc" ></jsp:useBean>
<jsp:setProperty property="su1" name="ob"/>	
<jsp:setProperty property="su2" name="ob" />
<jsp:setProperty property="op" name="ob" />
--%>

<jsp:useBean id="ob" class="com.test.Calc"></jsp:useBean>
<!-- 야 ob 객체 만들어진거 있잖아
	 거기에 모든 속성값들 다 set 해줘 -->
<jsp:setProperty property="*" name ="ob"/>
<!-- 위에 2줄로 끝난다.
	 형변환 이런거 다 자기가 해준다. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calc_ok3.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>세 번째 방법 처리 결과</h1>
	<hr />
</div>

<div>
	<!-- 결과 -->
	<h2><%=ob.result() %></h2>
</div>

</body>
</html>