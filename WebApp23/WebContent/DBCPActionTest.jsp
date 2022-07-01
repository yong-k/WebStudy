<%@page import="java.sql.Connection"%>
<%@page import="com.util.DBCPConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	Connection conn = DBCPConn.getConnection();

	String result = "";
	
	if (conn != null)
		result = "데이터베이스 연결 성공~!!!";
	else
		result = "데이터베이스 연결 실패ㅠㅠ";
	
	DBCPConn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBCPActionTest.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

<div>
	<h1>DBCP를 활용한 데이터베이스 접속 실습</h1>
	<hr />
</div>

<div>
	<!-- 결과 확인 -->
	<!-- 원래는 스크립릿영역에서 DBconn 구성해서 null 인지 확인했었음 -->
	<h2><%=result %></h2>
</div>

</body>
</html>