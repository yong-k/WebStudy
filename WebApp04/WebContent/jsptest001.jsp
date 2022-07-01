<!-- ┌→ 페이지 디렉티브 -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 스크립트 릿(Scriptlet) 영역 (자바코드 작성하는 곳)
	String name = "이호석";
	name += "은 홍길동이 아니다.";
	
	int result;
	result = 10 + 20;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsptest001.jsp</title>
</head>
<body>

<div>
	<h1>JSP 관찰하기</h1>
	<hr>
</div>

<div>
	<!-- 이렇게 쓰면 그냥 『name』 이라고 영어 출력된다. -->
	<h2>name</h2>
	
	<%-- HTML 문서 결과값에 포함시키고자 할 때 사용
         <%=  %> (즉, 브라우저에 등장시킬 수 있는 영역) --%>
    <h2><%=name %></h2>
    <h2><%=result %></h2>
</div>

</body>
</html>