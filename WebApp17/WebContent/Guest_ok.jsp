<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 액션태그에서는 설정 불가하므로, 아래 인코딩처리!
	request.setCharacterEncoding("UTF-8");
%>
<!-- ┌→ scope 생략되어 있으면 scope="page" 다. -->
<jsp:useBean id="guest" class="com.test.GuestDTO"></jsp:useBean>
<jsp:setProperty property="*" name="guest"></jsp:setProperty>
<!-- └→ ※ getProperty 랑 헷갈리면 안된다 !! 
		     이전 페이지로부터 property를 get하는게 아니라,
		     생성된 객체에 값을 set 하는 것이다. -->

<!-- 이렇게 하면 Guest.jsp 에서 값 getParameter()로 받아서 확인 가능함 -->
<%-- 
<jsp:forward page="Guest.jsp">
	<jsp:param name="userName" value="<%=guest.getUserName() %>" />
	<jsp:param name="subject" value="<%=guest.getSubject() %>" />
	<jsp:param name="content" value="<%=guest.getContent() %>" />
</jsp:forward>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Guest_ok.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	.table td {
		text-align: center;
	}
</style>
</head>
<body>

<!-- 작성해서 넘긴 내용 확인 -->
<!-- 이름, 제목, 내용 -->
<%-- 
<%=guest.getUserName() %> <br />
<%=guest.getSubject() %> <br />
<%=guest.getContent() %> <br /> 
--%>

<div>
	<h1>간단한 기본 방명록 작성 실습</h1>
	<hr />
</div>

<div>
	<h2>작성된 내용 확인</h2>
	<table class="table">
		<tr>
			<th>이름</th>
			<th>제목</th>
			<th>내용</th>
		</tr>
		<tr>
			<td><%=guest.getUserName() %></td>
			<td><%=guest.getSubject() %></td>
			<!-- ★★★ textarea로 컨트롤해서 받아서 넘긴거는 한 번 꼭 확인해보자! 
				 	    그대로 문자열로 찍으면 개행이 안된다.
				 		replaceAll() 해서 "\n", br로 바꾸는 코드 있어야 한다. ★★★ -->
			<td><%=guest.getContent().replaceAll("\n", "<br>") %></td>
		</tr>
	</table>
</div>
</body>
</html>