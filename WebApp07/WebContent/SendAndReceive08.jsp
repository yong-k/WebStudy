<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	public String printCalendar(int year, int month)
	{
		Calendar cal = Calendar.getInstance();
		
		// 현재 year/month/day 확인 (달력 CSS 적용)
		int nowYear = cal.get(Calendar.YEAR);
		int nowMonth = cal.get(Calendar.MONTH) + 1;
		int nowDay = cal.get(Calendar.DAY_OF_MONTH);
		
		// 매개변수로 받은 month 의 1일로 세팅
		cal.set(year, month-1, 1);
	
		// month 의 마지막 날짜
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		
		// month 의 시작 요일 : (1:일요일) - 1  → (0:일요일)
		int startWeek = cal.get(Calendar.DAY_OF_WEEK) - 1;
		
		// 달력 그리기
		String calendar = "";
		calendar += "<table class='calendar' border='1'>";
		
		// 요일 출력
		String[] weekNames = { "일", "월", "화", "수", "목", "금", "토" };
		
		calendar += "<tr>";
		for (int i = 0; i < weekNames.length; i++)
		{
			if (i == 0)			//-- 일요일
				calendar += "<th style='color: #bf0b0b;'>" + weekNames[i] + "</th>";
			else if (i == 6)	//-- 토요일
				calendar += "<th style='color: #2065d4;'>" + weekNames[i] + "</th>";
			else				//-- 평일
				calendar += "<th>" + weekNames[i] + "</th>";
		}
		calendar += "</tr>";
		
		// 공백 <td> 추가
		calendar += "<tr>";
		for (int i = 1; i <= startWeek; i++)
			calendar += "<td></td>";
			
		// 날짜 <td> 추가
		for (int i = 1; i <= lastDay; i++)
		{
			// 날짜 출력하면서 요일도 1씩 증가
			startWeek++;	
			
			// 각각 CSS 다르게 줄거라서
			// 오늘(토요일/일요일/평일), 그냥(토요일/일요일/평일) 로 나눠서 진행
			/* Date input = new Date(year, month, i);
			Date today = new Date(nowYear, nowMonth, nowDay); */
			
			// nowSat(토요일인 오늘)
			if (year==nowYear && month==nowMonth && i==nowDay && startWeek%7==0)
				calendar += "<td class='nowSat'>" + i + "</td>";
			// nowSun(일요일인 오늘)
			else if (year==nowYear && month==nowMonth && i==nowDay && startWeek%7==1)
				calendar += "<td class='nowSun'>" + i + "</td>";
			// 평일인 오늘
			else if (year==nowYear && month==nowMonth && i==nowDay)
				calendar += "<td class='now'>" + i + "</td>";
			// 오늘이 아닌 토요일
			else if (startWeek%7==0)			
				calendar += "<td class='sat'>" + i + "</td>";
			// 오늘이 아닌 일요일
			else if (startWeek%7==1)			
				calendar += "<td class='sun'>" + i + "</td>";
			// 오늘이 아닌 평일
			else
				calendar += "<td>" + i + "</td>";
				
				
			if (startWeek % 7 == 0)
				calendar += "</tr><tr>";
		}
		
		
		// 공백 <td> 추가
		for (int i = 0; i <= startWeek; i++, startWeek++)
		{
			if (startWeek % 7 == 0)
				break;
			
			calendar += "<td></td>";
		}
		
		if (startWeek % 7 != 0)
			calendar += "</tr>";
			
		calendar += "</table>";			
			
		return calendar;	
	}
%>
<% 
	
	request.setCharacterEncoding("UTF-8");
	
	String yearStr = request.getParameter("year");
	String monthStr = request.getParameter("month");
	//out.print(yearStr + " " + monthStr);
	
	int year = 0;
	int month = 0;
	String calender = "";
	
	if (yearStr == null || monthStr == null)
	{
		Calendar cal = Calendar.getInstance();

		int nowYear = cal.get(Calendar.YEAR);
		int nowMonth = cal.get(Calendar.MONTH) + 1;
		
		year = nowYear;
		month = nowMonth; 
		
		calender = printCalendar(year, month);
	}
	else
	{
		try 
		{
			year = Integer.parseInt(yearStr);
			month = Integer.parseInt(monthStr);
			
			
			// month 가  0이면 → year-1, month = 12
			if (month == 0)
			{
				year -= 1;
				month = 12;
			}
			// month 가 13이면 → year+1, month = 1
			else if (month == 13)
			{
				year += 1;
				month = 1;
			}
			
			calender = printCalendar(year, month);
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		} 
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SendAndReceive08.jsp</title>
<!-- <link rel="stylesheet" type="text/css" href="css/main.css"> -->
<style type="text/css">
	body {
		background-color: #f7f5f5;
		font-family: 맑은고딕;
		color: #272729;
	}
	h1 {
		text-align: center;
	}
	a {
		text-decoration: none;
		color: #474545;
	}		
	span {
		font-weight: bold;
		color: #272729;
	}
	table {
		margin-left: auto;
		margin-right: auto;
		text-align: center;
	}
	.container {
		margin-top: 40px;
	}
	.box1 {
		margin-top: 30px;
		text-align: center;
	}
	.box2 {
		font-weight: bold;
	}
	.calendar {
		width: 280px;
		height: 200px;
	}
	th { 
		background-color: #2a2d33; 
		color: #cfcfc8;	
	}
	td.now { background-color: #e6df67; font-weight: bold; }
	td.sat { color: #2065d4; }
	td.sun { color: #bf0b0b; }
	td.nowSat { background-color: #e6df67; font-weight: bold; color: #2065d4; }
	td.nowSun { background-color: #e6df67; font-weight: bold; color: #d40000; }
	
</style>

</head>
<body>

<!--  
	○ 데이터 송수신 실습 08
	   - 달력을 출력하는 JSP 페이지를 구성한다. (캘린더 객체 활용해서)
	   - 연도와 월을 입력받아 화면에 출력해주는 형태의 페이지로 구성한다.
	   - 단, submit 버튼 없이 이벤트 처리를 한다.
	   - 전송한 내용을 수신해서 출력해주는 형태의 단독 페이지로 구성한다.
	   
	     ◀ 2022년 4월 ▶
	     
	     ----------------------------
	     ----------------------------
	     ----------------------------
	     ----------------------------
	     
	     	 	
	     	 	<a>로 link 걸어서
	       ┌─────┐
	   - 『◀』 이나 『▶』 클릭 시
	     해당 년 월의 달력을 출력해주는 형태의 페이지로 구현한다.
	     
	     ※ 2022년  1월까지 가고 『◀』 누르면 2021년 12월로 가고,
	        2022년 12월까지 가고 『▶』 누르면 2023년  1월로 가야한다.
	     
	   - 사용자 최초 요청 주소는
	     http://localhost:8090/WebApp07/SendAndReceive08.jsp 로 한다.
	     
	○ SendAndReceive08.jsp	     
-->

<div>
	<h1>데이터 송수신 실습 08</h1>
	<hr>
</div>

<div class="container">
	<div class="box1">
		<form method="get">
			<a href="SendAndReceive08.jsp?year=<%=year %>&month=<%=month-1 %>" name="pre"> ◀</a>
			<span><%=year %>년 <%=month %>월</span>
			<a href="SendAndReceive08.jsp?year=<%=year %>&month=<%=month+1 %>" name="next"> ▶</a>
		</form>
	</div>
	<br>
	<div class="box2">
		<%=calender %>
	</div>
</div>



</body>
</html>