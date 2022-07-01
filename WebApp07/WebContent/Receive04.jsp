<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 데이터 수신
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String genderEng = request.getParameter("gender");
	String city = request.getParameter("city");
	String[] courseArr = request.getParameterValues("course");
	
	// 데이터 처리
	String gender = "";
	
	// .equals() 쓸 때 호출하는 대상이 null 이면
	// NullPointException 발생하므로 먼저 값이 null 인지 체크해본다.
	if (genderEng != null)
	{
		if (genderEng.equals("M"))
			gender = "남자";
		else if (genderEng.equals("F"))
			gender = "여자";
	}
	else
		gender = "확인불가";
	/*
	try
	{	
		if (genderEng.equals("M"))
			gender = "남자";
		else if (genderEng.equals("F"))
			gender = "여자";
		else
			gender = "확인불가";	
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	*/
	
	String course = "";
	if (courseArr != null)
	{
		for (String item : courseArr)
			course += " [" + item + "]";
	}
	
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
				<td><%=id %></td>
			</tr>
			<tr>
				<th>패스워드(*)</th>
				<td><%=password %></td>			
			</tr>
			<tr>
				<th>이름(*)</th>
				<td><%=name %></td>			
			</tr>
			<tr>
				<th>전화번호(*)</th>
				<td><%=tel %></td>			
			</tr>
			<tr>
				<th>성별</th>
				<td><%=gender %></td>
			</tr>
			<tr>
				<th>지역</th>
				<td><%=city %></td>
			</tr>
			<tr>
				<th>수강과목</th>
				<td><%=course %></td>
			</tr>
		</table>
</div>


</body>
</html>