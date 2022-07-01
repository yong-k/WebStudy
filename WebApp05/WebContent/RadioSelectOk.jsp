<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 스크립트 릿 영역 → 이전 페이지(RadioSelect.jsp)로부터 전송된 데이터 수신(→ name, gender, major, hobby)
	
	// 보면 value 에 한글 들어있으니, 인코딩 먼저!
	// 한글 깨짐 방지 처리
	request.setCharacterEncoding("UTF-8");		// check~!!!
	
	String nameStr = request.getParameter("name");	
	//-- 텍스트박스... 단일값 수신
	//   우리가 여태 처리했던 방식대로 처리하면 된다.
	String genderStr = request.getParameter("gender");
	//-- 라디오버튼... 단일값 수신
	//   그냥 텍스트박스 처리하듯 똑같이 처리해도 상관없다.
	String majorStr = request.getParameter("major");
	//-- 선택상자... selectbox 이지만, 다중선택 허용되지 않는 상황 → 단일값 수신 !!
	//String hobbyStr = request.getParameter("hobby")
	//-- 선택상자... 다중 데이터 수신 → 그럼 위에처럼 처리하면 안된다!!
	String[] hobbyArr = request.getParameterValues("hobby");
	//-- 다중 선택이 가능한 선택상자일 경우... 『getParameterValues()』로 데이터 수신 → 배열 반환
	//   getParameterValues 에 마우스 올려보면 String[] 반환한다고 되어있다.
	
	// name 수신 및 처리 → 특이사항 없음~!!! (그냥 String으로 처리하면 되니까)
	// 단일값으로 넘어오니까 그냥 처리해주면 된다.
	
	// gender 수신 및 처리 → genderStr 은 M 또는 F 들어있음
	String gender = "";
	if(genderStr.equals("M"))
		gender = "남자";
	else if(genderStr.equals("F"))
		gender = "여자";
	else
		gender = "확인불가";
	
	// major 수신 및 처리 → 특이사항 없음~!!! 
	// 단일값으로 넘어오니까 그냥 처리해주면 된다.
	
	// hobby 수신 및 처리
	// 일단 배열 받았을 때는 → 배열이 null 인지 아닌지 확인하고 처리하는 게 좋다!!
	String hobby = "";
	// 배열 null 인지 먼저 확인
	if (hobbyArr != null)
	{
		for (String item : hobbyArr)
			hobby += " [" + item + "]";
	}
													
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RadioSelectOk.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSP를 이용한 데이터 송수신 실습 03</h1>
	<hr>
	<p>RadioSelect.jsp ○ → RadioSelectOk.jsp ●</p>
</div>

<div>
	<h2>radio, select 데이터 수신 결과 확인</h2>
	
	<div>
		<!-- 아래와 같은 형태로 처리되게 할 예정 -->
		<!-- <p>이름 : 김태형</p> -->
		<p>이름 : <%=nameStr %></p>
		
		<!-- <p>성별 : M(남자)</p> -->
		<p>성별 : <%=genderStr %>(<%=gender %>)</p>
		
		<!-- <p>전공 : 국문학</p> -->
		<p>전공 : <%=majorStr %></p>
		
		<!-- <p>취미 : [영화감상] [음악감상]</p> -->
		<p>취미 : <%=hobby %></p>
	</div>
</div>

</body>
</html>