<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	public String printCalendar(int year, int month)
	{
		Calendar cal = Calendar.getInstance();
		String calendar = "";
		
		cal.set(Calendar.YEAR, year);		//-- 입력받은 연도로 세팅
		cal.set(Calendar.MONTH, month);		//-- 입력받은 월로 세팅
		cal.set(year, month-1, 1);			//-- 입력받은 월의 1일로 세팅
		
		// 해당 월의 마지막 날짜
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		
		// 해당 날짜의 요일 (1=일요일)
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);	
		
		calendar += "============[ " + year + "년 " + month + "월 ]============<br><br>";
		calendar += "   일   월   화   수   목   금   토<br>";
		
		// 시작 전 공백 추가
		for (int i = 1; i < dayOfWeek; i++)
		{
			calendar += "    ";
			dayOfWeek++;
		}
		
		// 달력 출력
		for (int i = 1; i <= lastDay; i++)
		{
			if (i == 1)
			{
				// 시작 전 공백 추가
				for (int j = 1; j < dayOfWeek; j++)
					calendar += "     ";
			}
			
			calendar += String.format("%5d", i);
			
			// 일요일이면 개행
			if (dayOfWeek % 7 == 0)
				calendar += "<br>";
			
			dayOfWeek++;
		}
		
		calendar += "==============================================";
		
		return calendar;
	}
%>
<%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	String optionYear = "";
	String optionMonth = "";
	
	// 연도 selectBox 구성
	String firstOptionYear = "<option>----</option>";
	for (int i = -10; i <= 10; i++)
		optionYear += "<option value=\"" + (year+i) + "\">" + (year+i) + "</option>";
		
	// 월 selectBox 구성
	String firstOptionMonth = "<option>----</option>";
	for (int i = 1; i <= 12; i++)
		optionMonth += "<option value=\"" + i + "\">" + i + "</option>";
	
		
	request.setCharacterEncoding("UTF-8");
	String userYearStr = request.getParameter("year");
	String userMonthStr = request.getParameter("month");
	int userYear = 0;
	int userMonth = 0;
	String calendar = "";
	
	try
	{
		userYear = Integer.parseInt(userYearStr);
		userMonth = Integer.parseInt(userMonthStr);
		
		calendar = printCalendar(userYear, userMonth);
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
<title>SendAndReceive07.jsp</title>
<style type="text/css">

</style>
<script type="text/javascript">

	function formCalendar(obj)
	{
		var year = document.getElementById("year");
		var month = document.getElementById("month");
		
		if (year.value != "----" && month.value != "----")
			obj.submit(); 
	}
</script>
</head>
<body>

<!--  
	○ 데이터 송수신 실습 07
	   - 달력을 출력하는 JSP 페이지를 구성한다.
	   - 연도와 월을 입력받아 화면에 출력해주는 형태의 페이지로 구성한다.
	   - 단, submit 버튼 없이 이벤트 처리를 할 수 있도록 한다.
	   - 전송한 내용을 수신해서 출력해주는 형태의 페이지로 구성한다.
	   - 연도 구성은 현재의 연도를 기준으로 이전 10년, 이후 10년으로 구성한다.
	   - 월 구성은 1월 부터 12월 까지로 구성한다.
	      
	     [ 2022 ▼ ] 년   [ 4 ▼ ] 월
	     
	     --------------------------------
	     --------------------------------
	     --------------------------------
	     --------------------------------
	     
	   - 연도 select 나 월 select 의 내용이 변화되면
	     해당 연 월의 달력을 출력해주는 형태의 페이지로 구성한다.
	     
	   - 사용자의 최초 요청 주소는
		 http://localhost:8090/WebApp07/SendAndReceive07.jsp 로 한다.

	○ SendAndReceive07.jsp
	
	<option value="연도">연도</option>       
-->


<div>
	<form method="get">
		<select id=year" name="year" onchange="formCalendar(this.form)"><%=firstOptionYear%><%=optionYear %></select> 년
		<select id="month" name="month" onchange="formCalendar(this.form)"><%=firstOptionMonth%><%=optionMonth %></select> 월
	</form>
</div>

<div>
<%=userYear %><%=userMonth %>
<%=calendar %>
</div>


</body>
</html>