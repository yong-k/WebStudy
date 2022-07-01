<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	// 이전 페이지로(Send09.jsp)부터 데이터(gugudan) 수신
	String gugudanStr = request.getParameter("gugudan");
	int gugudan = 0;
	String result = "";
	
	try
	{
		gugudan = Integer.parseInt(gugudanStr);
		for (int i = 1; i <= 9; i++)
			result += String.format("%d * %d = %d<br>", gugudan, i, (gugudan*i));
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
<title>Receiver09.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>데이터 송수신 실습09</h1>
	<hr>
</div>

<div>
	<h2>수신된 데이터 : <%=gugudanStr %></h2>
	<%=result %>
</div>

</body>
</html>