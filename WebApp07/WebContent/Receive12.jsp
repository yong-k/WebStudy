<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지(Redirect12.jsp)로부터 데이터(num1, num2, op, str) 수신
	// → "Receive12.jsp?num1="+num1+"&num2="+num2+"&op="+op+"&str="+str
	//    클라이언트가 새로 요청한 것이다.
	//    Redirect12.jsp로부터 저렇게 넘겨받은 거 아님!!!!
	
	//   check~!!!
	//-- 직접 Redirect12.jsp 로 부터 데이터를 넘겨받는 것이 아니라
	//   클라이언트가 새로운 요청을 하는 과정에서 넘긴 값을 수신하게 되는 개념
	
	String num1 = request.getParameter("num1");
	String num2 = request.getParameter("num2");
	String op = request.getParameter("op");
	String str = request.getParameter("str");
	
	if (op.equals("1"))
		op = "+";
	else if (op.equals("2"))
		op = "-";
	else if (op.equals("3"))
		op = "*";
	else if (op.equals("4"))
		op = "/";
	
	String strResult = String.format("%s %s %s = %s", num1, op, num2, str);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive12.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>데이터 송수신 실습 12</h1>
	<hr>
</div>

<div>
	<h2>연산 결과 : <%=strResult %></h2>
</div>

</body>
</html>