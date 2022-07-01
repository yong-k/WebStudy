<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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

	// 테스트
	//out.print("<h1>selectYear : " + selectYear + "</h1>");
	//out.print("<h1>selectMonth : " + selectMonth + "</h1>");
	
	// 확인할 날짜로 년도 select option 구성 -------------------------------------------
	//<option value="2012">2012</option>
	//<option value="2013">2013</option>
	//<option value="2014">2014</option>
	//						:
	//<option value="2022" selected="selected">2022</option> 	→ 지금 2022년이니까 2022년에 selected 속성 부여
	//						:
	//<option value="2030">2030</option>
	//<option value="2031">2031</option>
	//<option value="2032">2032</option>
	
	String yOptions = "";
	for(int year = (selectYear-10); year <=(selectYear+10); year++)	// 2022년 고르면 → 2012 ~ 2032
	{
/* 		스크립트 릿 영역에서는 
		큰따옴표로   구성된 영역에서 작은따옴표로 별도의 영역 구성 가능하고,
		작은따옴표로 구성된 영역에서는 큰따옴표로 별도의 영역 구성이 가능하다!! */
		
		// 관찰1.
		//yOptions += "<option value='" + year + "'>" + year + "</option>";
		
		//-- 지금 이대로하면 내가 2015년 선택하면 10년전인 2005년이 선택박스 초깃값으로 들어가버린다.
		//   내가 선택한 값으로 뜨게 해야한다. 
		
		// 관찰2.
		//if (year==nowYear)
		//	yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		//else
		//	yOptions += "<option value='" + year + "'>" + year + "</option>";
			
		//-- 이렇게 하면 현재 년도가 초깃값이 된다.
		
		
		// 					 이전페이지로부터 데이터 가져오라고 위에서 하는데, 
		// 				┌→ 그 값이 없으면/null 이면 이전페이지로 받은 게 아니라 처음 요청한 게 된다.
		//           최초 요청 어떻게 확인?
		//		  ----------------
		// 상황1. 페이지 최초 요청일 때    → sYear 는 null / 현재 년도와 옵션이 같을 때 → selected 들어가야 한다.(○)
		//		  → 현재년도에 selected 걸어주면 된다.
		// 상황2. 페이지 최초 요청 아닐 때 → sYear 는 null 아님 / 선택된 년도(selectYear)와 옵션이 같을 때 → selected 들어가야 한다.(○)
		//        → 이미 선택한 년도에 selected 걸어주면 된다.
		// 상황3. 나머지 → selected(Ⅹ)
		
		if (sYear==null && year==nowYear)
			yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		else if (sYear!=null && Integer.parseInt(sYear)==year)
			yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		else	//-- 상황3. selected 없이 option 만 구성한다.
			yOptions += "<option value='" + year + "'>" + year + "</option>";
		
		/*
		// 아린 → 최초 요청일 때는 selectYear가 nowYear이고, 
		// 		   최초 요청 아닐 때는 selectYear가 sYear 되는거라 아래처럼 구성해도 잘 될 듯
		if (selectYear==year)
			yOptions += "<option value='" + year + "' selected='selected'>" + year + "</option>";
		else	
			yOptions += "<option value='" + year + "'>" + year + "</option>";
		*/
		//-- 이제 최초요청일 때는, 현재년도인 2022년 골라져있고,
		//   한번 선택한 상황 이후에는, 다 사용자가 선택한 년도가 selected 되어있다.
		
		
		// --------------------------------↑↑↑------------------------------
		// 연도, 월 코드에서 
		// Integer.parseInt(sYear), Integer.parseInt(sMonth)
		// 이거 selectYear, selectMonth 로 바꿔서 코드 구성해도 상관없다!
		// --------------------------------↓↓↓------------------------------
		
	}	
	//--------------------------------------------- 확인할 날짜로 년도 select option 구성
	
	
	// 확인할 날짜로 월 select option 구성 ----------------------------------------------
	//<option value="1">1</option>
	//<option value="2">2</option>
	//<option value="3">3</option>
	//						:
	//<option value="4" selected="selected">4</option> 	→ 지금 4월이니까 4월에 selected 속성 부여
	//						:
	//<option value="10">10</option>
	//<option value="11">11</option>
	//<option value="12">12</option>
	
	
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
		
	
	// 그려야 할 달력의 1일이 무슨 요일인지 확인 필요
	// (만년달력)
	
	// 여기는 자바스크립트 영역 아니라, 배열 구성 [] 이렇게 하면 안된다.
	// 자바영역!! {} 이렇게 해야 한다!!
	
	int[] months = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	
	if (selectYear%4==0 && selectYear%100!=0 || selectYear%400==0)
		months[1] = 29;
	
	// 총 날 수 누적 변수
	int nalsu;
	
	// 요일 항목 배열 구성
	String[] weekNames = { "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" };
	
	// 현재 년도 → 입력받은 년도 이전 년도까지의 날 수 계산
	nalsu = (selectYear-1)*365 + (selectYear-1)/4 - (selectYear-1)/100 + (selectYear-1)/400;
	
	// 현재 월 → 입력받은 월의 이전 월까지의 날 수 추가
	for (int i = 0; i < selectMonth-1; i++)
		nalsu += months[i];
	
	nalsu++;		// + 1
	
	int week = nalsu % 7;					//-- 요일 변수
	int lastDay = months[selectMonth-1];	//-- 마지막 날짜 변수
	
	
	// 달력 그리기 ----------------------------------------------------------------------------------
	String calStr = "";
	calStr += "<table border='1'>";
	
	// 요일 이름 발생
	calStr += "<tr>";
	for (int i = 0; i < weekNames.length; i++)
	{
		if (i == 0)			//-- 일요일
			calStr += "<th style='color: red;'>" + weekNames[i] + "</th>";
		else if (i == 6)	//-- 토요일
			calStr += "<th style='color: blue;'>" + weekNames[i] + "</th>";
		else				//-- 평일
			calStr += "<th>" + weekNames[i] + "</th>";
	}
	calStr += "</tr>";
	
	
	// <td> 에 스타일 줄꺼라
	// td → class="sat" class="sun" class="now" 이런식으로
	// 토요일(td.sat), 일요일(td.sun), 오늘(td.now)에 해당되는 td 들한테 다 써줘야 한다!!
	// 그런데, 오늘(td.now)이 토요일(td.nowSat)/일요일(td.nowSun)인 경우에는 쫌 다르게 스타일!
	// → 무작정 td 그리면 안된다.
	
	// 빈 칸 공백 td 발생
	calStr += "<tr>";
	for (int i = 1; i <= week; i++)
		calStr += "<td></td>";
	
	// 날짜 td 발생
	for (int i = 1; i <= lastDay; i++)
	{	
		week++;		//-- 날짜가 하루씩 찍힐 때마다(구성이 이루어질 때마다) 요일도 함께 1씩 증가~!!!
		
		//calStr += "<td>" + i + "</td>";
		
		// nowSat(토요일인 오늘) → 년도/월이 현재 년도/월과 같고 && i 가 오늘 날짜와 같고 && 요일이 7로 나눴을 때 0
		if (selectYear==nowYear && selectMonth==nowMonth && i==nowDay && week%7==0)
			calStr += "<td class='nowSat'>" + i + "</td>";
		// nowSun(일요일인 오늘)
		else if (selectYear==nowYear && selectMonth==nowMonth && i==nowDay && week%7==1)
			calStr += "<td class='nowSun'>" + i + "</td>";
		// 평일인 오늘
		else if (selectYear==nowYear && selectMonth==nowMonth && i==nowDay)
			calStr += "<td class='now'>" + i + "</td>";
		// 오늘이 아닌 토요일
		else if (week%7==0)			
			calStr += "<td class='sat'>" + i + "</td>";
		// 오늘이 아닌 일요일
		else if (week%7==1)			
			calStr += "<td class='sun'>" + i + "</td>";
		else
			calStr += "<td>" + i + "</td>";
				
			
		if (week % 7 == 0)
			calStr += "</tr><tr>";
	}
	
	// 빈 칸 공백 td 발생
	for (int i = 0; i <= week; i++, week++)
	{
		if (week%7==0)
			break;
		
		calStr += "<td></td>";
	}
	
	
	if (week % 7 != 0)
		calStr += "</tr>";
	
	calStr += "</table>";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SendAndReceive07.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	td { text-align: right; }
	td.now { background-color: aqua; font-weight: bold; }
	td.sat { color: blue; }
	td.sun { color: red; }
	td.nowSat { background-color: aqua; font-weight: bold; color: blue; }
	td.nowSun { background-color: aqua; font-weight: bold; color: red; }
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
	<h1>데이터 송수신 실습07</h1>
	<hr>
</div>

<!-- 
	일단 완성 전에, 둘 중 하나라도 선택하면 값 둘 다 넘어가서 parseint 하기로 했는데
	-- 선택하세요 -- 
	넣어놓으면 NumberFormatException 오류나니까 주석처리해놓고 테스트했다.
-->

<div>
	<form action="" method="get">
		<select id="year" name="year" onchange="formCalendar(this.form)">
			<!-- <option>-- 선택하세요 --</option> -->
			<!-- <option value="9999">9999</option>
			<option value="9998">9998</option> -->
			<!-- 정적인 옵션 대신에 동적인 옵션 코드 넣어줌	-->
			<%=yOptions %>
		</select> 년
		<select id="month" name="month" onchange="formCalendar(this.form)">
			<!-- <option>-- 선택하세요 --</option> -->
			<!-- <option value="99">99</option>
			<option value="98">98</option> -->
			<!-- 정적인 옵션 대신에 동적인 옵션 코드 넣어줌	-->
			<%=mOptions %>
		</select> 월
	</form>
</div>
<br>
<div>
	<!-- 달력을 그리게 될 지점 -->
	<%=calStr %>
</div>


</body>
</html>