<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 스크립 릿 영역 → JSP 에서 JAVA 코드를 기술하는(사용하는) 영역
	
	int a = 10, b = 5, c;

	c = a + b;
	
	//-- 스크립 릿 영역에서 수행된 자바 코드의 실행 결과는
	//   표현식에 의해 HTML 브라우저 영역에 출력된다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsptest002.jsp</title>
</head>
<body>

<div>
	<h1>JSP 관찰하기</h1>
	<hr>
</div>

<div>
	<!-- 표현식 -->
	<h2>합 : <%=a %> + <%=b %> = <%=c %></h2>
</div>

<%
	// 스크립 릿 영역 → 한 군데만 있어야 하는 거 아니다.
	//   			  → 이 안에서만큼은 <body> 태그 안에 있더라도 
	//  				 HTML 의 문법 적용되는 공간 아니다.
	
	// ※ 『out』은 내장 객체로서 출력 스트림이다.
	//-- 스크립 릿 영역에서 out.print(); 하면 그 내용도 브라우저로 출력된다.
	out.print("합: " + a + " + " + b + " = " + c);
	out.println("합: " + a + " + " + b + " = " + c);
	out.println("합: " + a + " + " + b + " = " + c);
	//-- println(); 써도 개행 안된다.
	
	out.print("<br><br>");
	//-- <br> 태그를 써야 개행된다.
	
	out.println("합: " + a + " + " + b + " = " + c + "<br>");
	out.println("합: " + a + " + " + b + " = " + c);
	
	out.println("<br><br>");
	
	String str = String.format("합 : %d + %d = %d", a, b, c);
	out.print(str);
	out.print(str);
	//--==>> 합 : 10 + 5 = 15합 : 10 + 5 = 15
	
	out.println("<br><br>");
	
	str = String.format("합 : %d + %d = %d\n", a, b, c);
	out.print(str);
	out.print(str);
	//--==>> 합 : 10 + 5 = 15 합 : 10 + 5 = 15
	//--     위의 코드와 비교했을 때, 『공백 한 칸』 들어갔다.
	
	out.println("<br><br>");
	
	str = String.format("합 : %d + %d = %d<br>", a, b, c);
	out.print(str);
	out.print(str);
	//--==>> 합 : 10 + 5 = 15
	//       합 : 10 + 5 = 15
	
	out.println("<br><br>");
	
%>

</body>
</html>