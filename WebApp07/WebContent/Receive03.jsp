<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String numStr1 = request.getParameter("num1");
	String numStr2 = request.getParameter("num2");
	String op = request.getParameter("op");
	int num1 = 0, num2 = 0;
	double result = 0;
	
	try 
	{
		num1 = Integer.parseInt(numStr1);
		num2 = Integer.parseInt(numStr2);
		
		switch(op)
		{
			case "+":
				result = num1 + num2;
				break;
			case "-":
				result = num1 - num2;
				break;
			case "*":
				result = num1 * num2;
				break;
			case "/":
				result = Double.parseDouble(String.format("%.2f", num1 / (double)num2));
				break;
		}
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
<title>Receive03.jsp</title>
<style type="text/css">
	* { 
		box-sizing: border-box; 
	}
	div#msg {
		width: 500px;
		height: 100px;
		background-color: #e6e8ed;
		border: 5px solid #4b6da3;
		border-radius: 10px;
		text-align: center;
		padding-top: 30px;
	}
	span { 
		font-size: 28px;
		font-weight: bold;
		color: teal;
		font-family: 메이플스토리;
	}
</style>
</head>
<body>

<div>
	<h1>데이터 송수신 실습 03</h1>
	<hr>
</div>

<div id="msg">
	입력하신 <span><%=num1 %></span>와(과) <span><%=num2 %></span>의 연산 결과는 <span><%=result %></span> 입니다.
</div>

</body>
</html>