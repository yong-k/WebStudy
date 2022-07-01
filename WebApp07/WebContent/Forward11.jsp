<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// Forward11.jsp
	
	// 이전 페이지(Send11.html)로부터 데이터(num1, calResult, num2) 수신
	
	String num1Str = request.getParameter("num1");
	String num2Str = request.getParameter("num2");
	String calResult = request.getParameter("calResult");
	
	int num1 = 0;
	int num2 = 0;
	String result = "";
	
	try
	{
		num1 = Integer.parseInt(num1Str);
		num2 = Integer.parseInt(num2Str);
		
		if (calResult.equals("1"))			// 더하기
			result = String.format("%d + %d = %d", num1, num2, (num1+num2));
		else if (calResult.equals("2"))		// 빼기
			result = String.format("%d - %d = %d", num1, num2, (num1-num2));
		else if (calResult.equals("3"))		// 곱하기
			result = String.format("%d * %d = %d", num1, num2, (num1*num2));
		else if (calResult.equals("4"))		// 나누기
			result = String.format("%d / %d = %.1f", num1, num2, (num1/(double)num2));
		
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	
	request.setAttribute("resultStr", result);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forward11.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<jsp:forward page="Receive11.jsp"></jsp:forward>
<!-- 이거까지 나중에 처리해서 위로 올리면,
	 Forward11.jsp 있을 필요 없음 → 자바로 작성하면 된다.
	 이제는 Forward11.jsp 의 역할은 온전히 Servlet이 하도록 바꿀 것이다. -->

</body>
</html>