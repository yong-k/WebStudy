<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 데이터 수신
	String danStr = request.getParameter("selectDan");
	int dan = 0;
	String result = "";
	
	try
	{
		dan = Integer.parseInt(danStr);
		
		for (int i = 1; i <= 9; i++)
			result += String.format("%d x %d = %d<br>", dan, i, dan*i);
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive05.jsp</title>
<style type="text/css">
	.box {
		border: 3px solid #78968c;
		padding: 20px;
		width: 200px;
	}
</style>
</head>
<body>

<div>
	<h1>데이터 송수신 실습 05</h1>
	<hr>
</div>

<div class="box">
	<h2><%=dan %>단</h2>
	<%=result %>
</div>

</body>
</html>