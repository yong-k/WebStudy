<%@ page contentType="text/html; charset=UTF-8"%>
<%
/*
	// 나
	String suStr1 = request.getParameter("su1");
	String suStr2 = request.getParameter("su2");
	int width = 0, height= 0;
	String result = "";
	
	try
	{
		width = Integer.parseInt(suStr1);
		height = Integer.parseInt(suStr2);
		
		int n = 1;
		for (int i = 0; i < height; i++)
		{
			result += "<tr>";
			for (int j = 0; j < width; j++)
			{
				result += "<td>" + n++ + "</td>";
			}
			result += "</tr>";
		}
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	}
*/

	// 쌤
	// 스크립트 릿 영역 → 이전 페이지로부터 전송된 데이터 수신
	// 한글이 없으면 안해도 되기는 하지만,
	// 이거 한다고, 리소스 비용 더 많이 들고 이런거 아니기 때문에
	// 그냥 일단 나중에 filter 라는 거 쓰기 전까지는 
	// 요청 객체에 대한 인코딩 하고 시작하기!!!
	// 나중에 filter 배우면 거기에 끼워넣으면 된다 ㅎvㅎ
	request.setCharacterEncoding("UTF-8");
	
	// 데이터 수신
	String s1 = request.getParameter("su1");
	String s2 = request.getParameter("su2");
	
	int n1 = 0;
	int n2 = 0;
	
	// 테이블 안에서 1씩 증가시켜 나갈 변수 선언 및 초기화
	int n = 0;
	
	try
	{
		// 수신된 데이터 형 변환
		n1 = Integer.parseInt(s1);
		n2 = Integer.parseInt(s2);
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TableOk.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	table, td {
		border: 1px solid black;
	}
</style>
</head>
<body>

<div>
	<h1>JSP를 이용한 데이터 송수신 실습 05</h1>
	<hr>
	<p>Table.jsp ○ → TableOk.jsp ●</p>
</div>

<!-- 내가 한 거 -->
<%-- 
<div>
	<table>
		<%=result %>
	</table>
</div>
--%>


<!-- 쌤 -->
<div>
	<table border="1">
		<%
		for(int i = 0; i < n2; i++)
		{
		%>
			<tr>
			<%
			for (int j = 0; j < n1; j++)
			{
			%>
				<td style="width: 40px; text-align: right;"><%=++n %></td>
			<%
			}
			%>
			</tr>
		<%
		}
		%>
	</table>
</div>
</body>
</html>