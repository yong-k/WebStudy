<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test2.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>서블릿에서 데이터 흐름</h1>
	<hr />
</div>

<div>
	<!-- form 에 저 요청 들어가면 web.xml 이 움찔한다 -->
	<!-- 여기서 submit 하고 있는 name과 age를 Test.2java에서 받아낼 수 있는 구조가 된다. -->
	<form action="<%=cp%>/test2" method="post">
		이름 <input type="text" name="name" class="txt" /><br />
		나이 <input type="text" name="age" class="txt" /><br />
		<button type="submit" class="btn">확인</button>
		<!-- 이름, 나이 입력하고서 확인 버튼 누르면
			 jsp가 이름, 나이 넘긴걸 Test2.java의 doGetPost() 메소드가 받도록 할 계획이다. -->
	</form>
</div>


</body>
</html>