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
	request.setCharacterEncoding("UTF-8");

	// 이미 하나 선택되고 다시 부르는 것일 수도 있으니, 
	// 먼저
	// 자기 자신 페이지로부터 데이터 수신
	String sYear = request.getParameter("year");
	String sMonth = request.getParameter("month");
	

	// Calendar 객체 구성
	Calendar cal = Calendar.getInstance();
	//--위에 import 구문 안 쓰려면,
	//java.util.Calendar cal = java.util.Calendar.getInstance();
	
	// 현재 년, 월, 일 확인
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	// 표시할 달력의 년, 월 구성 → 페이지 최초 요청을 감안한 코드
	int selectYear = nowYear;
	int selectMonth = nowMonth;
	
	
	// 페이지 요청이 최초일 때는 위에처럼 하기로 했는데,
	// 페이지 요청이 최초가 아니라면, 이전페이지로부터 데이터 넘어온거라면
	// 이 시점에서는, 뭘 보고 판단해야 할까?
	// → sYear, sMonth 이 null 인지 아닌지를 보고 판단하면 된다.
	
	// 페이지에 대한 요청이 최초 요청이 아닐 경우
	// → Line 9, 10 을 통해 수신한 데이터로 표시할 달력의 년, 월 구성
	if (sYear != null || sMonth != null)
	{
		selectYear = Integer.parseInt(sYear);
		selectMonth = Integer.parseInt(sMonth);
	}

	// 확인할 날짜로 년도 select option 구성 -------------------------------------------
	String yOptions = "";
	for(int year = (selectYear-10); year <=(selectYear+10); year++)	// 2022년 고르면 → 2012 ~ 2032
	{
		// 상황1. 페이지 최초 요청일 때    → sYear 는 null / 현재 년도와 옵션이 같을 때 → selected 들어가야 한다.(○)
		// 상황2. 페이지 최초 요청 아닐 때 → sYear 는 null 아님 / 선택된 년도(selectYear)와 옵션이 같을 때 → selected 들어가야 한다.(○)
		// 상황3. 나머지 → selected(Ⅹ)
		if (sYear==null && year==nowYear)
			yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		else if (sYear!=null && Integer.parseInt(sYear)==year)
			yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		else	//-- 상황3. selected 없이 option 만 구성한다.
			yOptions += "<option value='" + year + "'>" + year + "</option>";
	
		//-- 이제 최초요청일 때는, 현재년도인 2022년 골라져있고,
		//   한번 선택한 상황 이후에는, 다 사용자가 선택한 년도가 selected 되어있다.
		
	}	
	//--------------------------------------------- 확인할 날짜로 년도 select option 구성
	
	
	// 확인할 날짜로 월 select option 구성 ----------------------------------------------
	
	// 상황1. 페이지 최초 요청일 때    → sMonth 는 null / 현재 월과 옵션이 같을 때 → selected 들어가야 한다.(○)
	// 상황2. 페이지 최초 요청 아닐 때 → sMonth 는 null 아님 / 선택된 월(selectMonth)와 옵션이 같을 때 → selected 들어가야 한다.(○)
	// 상황3. 나머지 → selected(Ⅹ)
	String mOptions = "";
	for(int month = 1; month <= 12; month++)
	{
		if (sMonth==null && month==nowMonth)
			mOptions += "<option value='" + month + "' selected='selected'>" + month + "</option>";
		else if (sMonth!=null && Integer.parseInt(sMonth)==month)
			mOptions += "<option value='" + month + "' selected='selected'>" + month + "</option>";
		else
			mOptions += "<option value='" + month + "'>" + month + "</option>";
	}
	
	//----------------------------------------------- 확인할 날짜로 월 select option 구성
	
	String calendar = "";
	if (sYear != null && sMonth != null)
		calendar = printCalendar(selectYear, selectMonth);
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
		// 유효성 검사가 필요할 경우 삽입할 수 있는 영역~!!!
		
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
	<form action="" method="get">
		<select id="year" name="year" onchange="formCalendar(this.form)">
			<%=yOptions %>
		</select> 년
		<select id="month" name="month" onchange="formCalendar(this.form)">
			<%=mOptions %>
		</select> 월
	</form>
</div>

<div>
	<%=calendar %>
</div>


</body>
</html>