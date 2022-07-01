<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 데이터 수신
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName");
	String userTel = request.getParameter("userTel");
	String userGender = request.getParameter("userGender");
	String userCity = request.getParameter("userCity");
	//String userSubject = request.getParameter("userSubject");
	
	// check~!!!
	String[] userSubjectArr = request.getParameterValues("userSubject");
	
	// 데이터 처리	
	String subjectStr = "";
	if (userSubjectArr != null)
	{
		for (int i = 0; i < userSubjectArr.length; i++)
			subjectStr += " [" + userSubjectArr[i].toString() + "]";
	}
	
	// ※ 추후에는 수신된 데이터를... 쿼리문을 통해 DB에 입력하는
	//    처리 과정 등이 포함될 것임을 염두하며 작업을 진행할 수 있도록 하자.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive04.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>데이터 송수신 실습 04</h1>
	<hr>
</div>

<div>	
	<h2>회원정보 확인</h2>
			<table class="table">
			<tr>
				<th>아이디(*)</th>
				<td><%=userId %></td>
			</tr>
			<tr>
				<th>패스워드(*)</th>
				<td><%=userPw %></td>			
			</tr>
			<tr>
				<th>이름(*)</th>
				<td><%=userName %></td>			
			</tr>
			<tr>
				<th>전화번호(*)</th>
				<td><%=userTel %></td>			
			</tr>
			<tr>
				<th>성별</th>
				<td><%=userGender %></td>
			</tr>
			<tr>
				<th>지역</th>
				<td><%=userCity %></td>
			</tr>
			<tr>
				<th>수강과목</th>
				<td><%=subjectStr %></td>
			</tr>
		</table>
</div>


</body>
</html>