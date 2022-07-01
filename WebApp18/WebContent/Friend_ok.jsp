<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="friend" class="com.test.FriendDTO"></jsp:useBean>
<jsp:setProperty property="*" name="friend"></jsp:setProperty>
 
 <!-- 반복문 필요(다중 선택으로 넘어온 결과값을 출력하기 위한 처리) -->
<%
	String idelType = "";
	if (friend.getIdelType() != null)
	{
		for (int i = 0; i < friend.getIdelType().length; i++)
			idelType += "[" + friend.getIdelType()[i] + "] ";
	}
%> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Friend_ok.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	div#result {
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 24px;
	}
</style>
</head>
<body>
	<div>
		<h1>입력 결과 확인</h1>
		<hr />
	</div>
	<div id="result">
		이름 : <%=friend.getName() %> <br />
		나이 : <%=friend.getAge() %> <br />
		성별 : <%=friend.getGender() %> <br />
		이상형 : <%=idelType %> <br /> 
	</div>
</body>
</html>