<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 스크립트 릿 영역 → 인텔리센스 안 먹히는 거 꽤 있음,,!
	
	// jsp 데이터 처리할 때는 → 스크립트 릿 영역에서 처리하는 거다.
	
	// 이전 페이지(Hap.jsp)로 부터 넘어온 데이터 수신 → su1, su2
	String str1 = request.getParameter("su1");
	String str2 = request.getParameter("su2");
	
	int sum = 0;
	
	// Hap.jsp 에서 받은 거 가지고 2개 합해주려고 한다.
	// 그대로 수신한 건 문자열이니까 형변환 해줘야 한다.
	// Integer.parseInt() 쓸 건데, 문자열이 정수형태 아니면
	// NumberFormatException 발생할테니까 try~catch 사용한다.
	try
	{
		int n1 = Integer.parseInt(str1);
		int n2 = Integer.parseInt(str2);
		
		sum = n1 + n2;
	}
	catch(Exception e)
	{
		// 예외 발생 시..
		// 클라이언트의 브라우저 화면에 출력되지 않고...
		// 서버의 콘솔 창에 오류 메세지가 나오도록 구성된다.
		System.out.println(e.toString());
		
		// 예외 발생 시...
		// 해당 내용을 서버 log 기록으로 남기는 처리...
		getServletContext().log("오류 : " + e.toString());
		
		
		/* 'aaa' 입력한 다음 콘솔창 확인하면, 
		
		// System.out.println(e.toString()); → 콘솔에 오류 메세지 뜨는거 
		java.lang.NumberFormatException: For input string: "aa"
		
		// getServletContext().log("오류 : " + e.toString()); → 서버 log 기록으로 남기는거
	 	4월 12, 2022 10:46:34 오전 org.apache.catalina.core.ApplicationContext log
	 	정보: 오류 : java.lang.NumberFormatException: For input string: "aa"
		*/
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HapOk.jsp</title>
</head>
<body>

<div>
	<h1>JSP를 이용한 데이터 송수신 실습 01</h1>
	<hr>
	<p>Hap.jsp ○ → HapOk.jsp ●</p>
</div> 

<div>
	<h2>결과 : <%=sum %></h2>
	<!-- ※ Hap.jsp의 정수1 또는 정수2 항목에
			정수 형태의 숫자가 아닌 변환이 불가능한 문자나 빈 공백을 입력했을 경우
			결과 확인 버튼 클릭 시 클라이언트의 화면 처리 결과를
			try ~ catch 블럭에 의해 항상 0으로 출력되며 (→ sum을 0으로 초기화해둬서)
			콘솔 창을 통해 이와 관련된 내용을 확인할 수 있다. -->
</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</body>
</html>