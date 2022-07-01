<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	String str = "<option>선택</option>";
	
	for (int i=year-10; i<=year+10; i++)
	{
		str += "<option>" + i + "</option>";
	} 
	
	String strMonth = "<option>선택</option>";
	for (int i=1; i<=12; i++)
	{
		strMonth += "<option>" + i + "</option>";
	} 
	
%>

<%
	String str1 = request.getParameter("year");
	String str2 = request.getParameter("month");
	int userYear = 0;
	int userMonth = 0;
	int sumDay = 0;
	String tableNode = "";
	String userCal = "";
	
	try
	{
		userYear = Integer.parseInt(str1);
		userMonth = Integer.parseInt(str2);
		
		userCal = userYear + "년 " + userMonth + "월 달력";
		
		if (userYear != 0 && userMonth != 0)
		{
			str = "<option>선택</option>";
			for (int i=year-10; i<=year+10; i++)
			{	
				if (i == userYear)
				{
					str += "<option selected=\"selected\">" + i + "</option>";
				}
				str += "<option>" + i + "</option>";
			} 
			
			strMonth = "<option>선택</option>";
			for (int i=1; i<=12; i++)
			{	
				if (i == userMonth)
				{
					strMonth += "<option selected=\"selected\">" + i + "</option>";
				}
				strMonth += "<option>" + i + "</option>";
			} 
		}
		
		int[] monthDay = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
		
		// 연도별 날 수 구하기
		for (int i=1; i<userYear; i++)
		{
			if (i%4 == 0 && i%100 != 0 || i%400 == 0)
				sumDay += 366;
			else
				sumDay += 365;
		}
		
		// 달별 날 수 구하기
		if (userYear%4 == 0 && userYear%100 != 0 || userYear%400 == 0)
		{
				monthDay[1] = 29;
		}
		
		for (int i=1; i<userMonth; i++)
		{
			sumDay += monthDay[i-1];
		}
		
		sumDay++; 
		
		
		/* 
		sumDay%7 == 1 --> 월	1
		sumDay%7 == 2 --> 화	2
					3     수	3
					4	  목	4
					5     금	
					6     토
					7     일
		*/
		
		int blank = sumDay%7;
		int br = 0;
		tableNode = "<table border=\"1\"><tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr><tr>";
		
		for (int i=0; i<blank; i++)
		{
			tableNode += "<td>　</td>";
			br++;
		}
		
		for (int i=1; i<=monthDay[userMonth-1]; i++)
		{
			tableNode += "<td>" + i + "</td>";
			br++;
			if (br%7 == 0)
				tableNode += "</tr><tr>";
		}
		
		for (int i=0; i<7-(br%7); i++)
		{
			if (br%7 == 0)
				break;
			tableNode += "<td>　</td>";
		}
		
		tableNode += "</tr></table>";
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
<title>SendAndReceive07.jsp</title>

<script type="text/javascript"> 


	function formChange(obj)
	{ 
		var userYear = document.getElementById("userYear");
		var userMonth = document.getElementById("userMonth");
		var dt = document.getElementById("drawTable");
		
		
		if (userYear.value != "선택" && userMonth.value != "선택")
		{
			obj.submit();
		}
	}
	
</script>

<style type="text/css">
	/*#drawTable
	{
		display: none;
	}*/
</style>
</head>
<body>

<!-- 
	○ 데이터 송수신 실습 07
	   - 달력을 출력하는 JSP 페이지를 구성한다.
	   - 연도와 월을 입력받아 화면에 출력해주는 형태의 페이지로 구성한다.
	   - 단, submit 버튼 없이 이벤트 처리를 할 수 있도록 한다.
	   - 전송한 내용을 수신해서 출력해주는 형태의 페이지로 구성한다.
	   - 연도 구성은 현재의 연도를 기준으로 이전 10년, 이후 10년으로 구성한다.
	     (기본적으로 만년달력을 구성하는데 현재의 연, 월 은 달력 객체로부터 확인할 수 있도록 한다.
	   - 월 구성은 1월 부터 12월 까지로 구성한다.
	   
	   
	     [ 2022 ▼ ] 년   [  1 ▼ ] 월
	     
	     -----------------------------
	     -----------------------------
	     -----------------------------
	     -----------------------------
	     
	     
	   - 연도 select 나 월 select 의 내용이 변화되면
	     해당 연 월의 달력을 출력해주는 형태의 페이지로 구성한다.
	     
	   - 사용자 최초 요청 주소는
	     http://localhost:8090/WebApp07/SendAndReceive07.jsp 로 한다.
	     
	 ○ SendAndReceive07.jsp
	 
 -->
 
 <div>
 	<form method="post">
 		<select name="year" id="userYear" onchange="formChange(this.form)">
 			<%=str %>
 		</select> 년 
 		
 		<select name="month" id="userMonth" onchange="formChange(this.form)">
 			<%=strMonth %>
 		</select> 월
 	</form>
 	
 </div>

<div id="drawTable">
	<h3><%=userCal %></h3>
	<%=tableNode %>
</div>

</body>
</html>







