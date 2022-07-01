<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 스크립트 릿 영역 → 이전페이지(Gugudan.jsp)로부터 데이터 수신(dan)
	
	// ★ 받기 전에 한글이 포함되어 있는지 먼저 봐야한다!!!
	//    한글있다면, 처리해줘야 한다.
	
	String danStr = request.getParameter("dan");
	String result = "";
	int n = 0;
	
	try 
	{
		n = Integer.parseInt(danStr);	
		
		// 일반적으로 여기서 처리 다 하고 아래에서 결과 출력하기는 함
		// 그렇지만, 스크립트 릿 영역은 한 번만 써야하는 거 아니고,
		// 여기서 한 번에 다 처리해야 할 필요도 없다.
		// ==> 쌤 → 아래에서 한 번 처리해보자
		// 나 → 여기서 다 처리해서 아래에서 결과 출력
		/*
		for (int i = 1; i <= 9; i++)
			result += String.format("%d x %d = %d<br>", n, i, n * i);
		*/
		
	} catch (Exception e)
	{
		System.out.println(e.toString());
		getServletContext().log("오류 : " + e.toString());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GugudanOk.jsp</title>
</head>
<body>

<div>
	<h1>JSP를 이용한 데이터 송수신 실습 02</h1>
	<hr>
	<p>Gugudan.jsp ○ → GugudanOk.jsp ●</p>
</div>

<div>
<!-- html 주석문 -->
<%-- jsp  주석문 → 그냥 html 주석문으로 처리하면 안된다. 
				 → 이 문서 바로 클라이언트한테 가는 거 아니라, servlet container 한테 간다.
				    그럼 servlet container 가 클라이언트한테 줄 형식으로 랜더링한다.
				    그 일꾼한테 안보이게 하는게 jsp 주석문!!
				    html 주석문은 소스코드 볼 때 보인다. 
				    jsp 주석문은?? → 안보인다!!
				    servlet container 가 랜더링할 때, 일꾼 눈에 html 주석문은 보이니까 그리지만,
				                                                jsp 주석문은 안보이니까 그리지 않는다. 
--%>

<%-- 내가 한 거 
	<h2><%=danStr %>단</h2>
	<%=result %> 
--%>

<%-- 
<% 
	// 쌤_ 방법 ①
	for(int i = 1; i <= 9; i++)
		 out.print(n + " * " + i + " = " + (n*i) + "<br>");
%> 
--%>

<% 
	// 쌤_ 방법 ②
	for(int i = 1; i <= 9; i++)
	{
%>
		<!-- html 영역 -->
		<%=n %> * <%=i %> = <%=(n*i) %> <br>
<% 
	}
%>
	
</div>

</body>
</html>